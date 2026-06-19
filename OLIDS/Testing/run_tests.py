#!/usr/bin/env python3
"""
OLIDS Data Quality Test Runner

Discovers and executes test_*.sql files against Snowflake.
Database context is set from SNOWFLAKE_DATABASE in .env.
Schema names (OLIDS_MASKED, OLIDS_COMMON, OLIDS_TERMINOLOGY) are
auto-detected from INFORMATION_SCHEMA and remapped at runtime.

Usage:
    uv run run_tests.py
    uv run run_tests.py --test test_data_freshness
    uv run run_tests.py --verbose
    uv run run_tests.py --olids-schema OLIDS_PCD
    uv run run_tests.py --run investigations/investigate_column_completeness.sql
"""

import os
import sys
import time
import argparse
import re
from pathlib import Path
from datetime import datetime
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Try to import snowflake connector
try:
    from snowflake.snowpark import Session
    USE_SNOWPARK = True
except ImportError:
    try:
        import snowflake.connector
        USE_SNOWPARK = False
    except ImportError:
        print("ERROR: Neither snowflake-snowpark-python nor snowflake-connector-python installed")
        sys.exit(1)


# Configuration from environment
ACCOUNT = os.getenv('SNOWFLAKE_ACCOUNT')
USER = os.getenv('SNOWFLAKE_USER')
WAREHOUSE = os.getenv('SNOWFLAKE_WAREHOUSE')
ROLE = os.getenv('SNOWFLAKE_ROLE')
DATABASE = os.getenv('SNOWFLAKE_DATABASE')
OLIDS_SCHEMA = os.getenv('OLIDS_SCHEMA')


def validate_config():
    """Check that all required env vars are set."""
    missing = []
    for var in ['SNOWFLAKE_ACCOUNT', 'SNOWFLAKE_USER', 'SNOWFLAKE_WAREHOUSE',
                'SNOWFLAKE_ROLE', 'SNOWFLAKE_DATABASE']:
        if not os.getenv(var):
            missing.append(var)
    if missing:
        print(f"ERROR: Missing environment variables: {', '.join(missing)}")
        print("Run setup.ps1 (Windows) or setup.sh (macOS), or copy .env.example to .env.")
        sys.exit(1)


def get_connection():
    """Create Snowflake connection.

    Scripted runs can pass SNOWFLAKE_PASSWORD, otherwise the connector falls
    back to browser SSO for the existing portable setup flow.
    """
    connection_params = {
        "account": ACCOUNT,
        "user": USER,
        "warehouse": WAREHOUSE,
        "role": ROLE,
    }
    password = os.getenv('SNOWFLAKE_PASSWORD')
    if password:
        connection_params["password"] = password
    else:
        connection_params["authenticator"] = "externalbrowser"

    if USE_SNOWPARK:
        return Session.builder.configs(connection_params).create()
    else:
        return snowflake.connector.connect(**connection_params)


def discover_tests(test_dir: Path, specific_test: str = None) -> list:
    """Find all test_*.sql files in the directory."""
    if specific_test:
        if not specific_test.endswith('.sql'):
            specific_test += '.sql'
        test_file = test_dir / specific_test
        if test_file.exists():
            return [test_file]
        else:
            print(f"ERROR: Test file not found: {specific_test}")
            sys.exit(1)

    tests = sorted(test_dir.glob("test_*.sql"))
    return tests


# Known tables per default schema. Used to auto-detect actual schema names
# by querying INFORMATION_SCHEMA. All tables in a group must resolve to the
# same actual schema; detection fails if they don't.
SCHEMA_TABLES = {
    'OLIDS_MASKED': [
        'PATIENT', 'PERSON', 'PATIENT_ADDRESS', 'PATIENT_CONTACT', 'PATIENT_UPRN',
    ],
    'OLIDS_COMMON': [
        'ALLERGY_INTOLERANCE', 'APPOINTMENT', 'APPOINTMENT_PRACTITIONER',
        'DIAGNOSTIC_ORDER', 'ENCOUNTER', 'EPISODE_OF_CARE', 'LOCATION',
        'LOCATION_CONTACT', 'MEDICATION_ORDER', 'MEDICATION_STATEMENT',
        'OBSERVATION', 'ORGANISATION', 'PATIENT_PERSON',
        'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'PRACTITIONER',
        'PRACTITIONER_IN_ROLE', 'PROCEDURE_REQUEST', 'REFERRAL_REQUEST',
        'SCHEDULE', 'SCHEDULE_PRACTITIONER',
    ],
    'OLIDS_TERMINOLOGY': [
        'CONCEPT', 'CONCEPT_MAP',
    ],
}


def _fetch_rows(conn, query: str) -> list:
    """Run a query and return row tuples for both Snowpark and connector APIs."""
    if USE_SNOWPARK:
        rows = conn.sql(query).collect()
        return [tuple(r) for r in rows]

    cursor = conn.cursor()
    try:
        cursor.execute(query)
        return cursor.fetchall()
    finally:
        cursor.close()


def detect_schemas(conn, database: str, single_schema: str = None) -> dict:
    """Auto-detect schema names by querying INFORMATION_SCHEMA for known tables.

    Returns a map from default name to actual name, e.g.
    {'OLIDS_MASKED': 'OLIDS_PCD', 'OLIDS_COMMON': 'OLIDS_COMMON', ...}

    Newer dbt/Snowflake OLIDS builds collapse all exposed tables into one
    physical schema (for example OLIDS_PSEUDO) and omit some legacy tables.
    Detection therefore chooses the schema with the most matching tables for
    each legacy group, instead of requiring every legacy table to exist.

    When single_schema is provided, all legacy schema names are mapped to that
    schema after checking at least one known OLIDS table exists there.
    """
    if single_schema:
        schema = single_schema.strip().strip('"').upper()
        all_tables = sorted({table for tables in SCHEMA_TABLES.values() for table in tables})
        placeholders = ','.join(f"'{t}'" for t in all_tables)
        query = (
            "SELECT COUNT(*) "
            "FROM INFORMATION_SCHEMA.TABLES "
            f"WHERE TABLE_SCHEMA = '{schema}' "
            f"AND TABLE_NAME IN ({placeholders})"
        )
        rows = _fetch_rows(conn, query)
        match_count = int(rows[0][0]) if rows else 0
        if match_count == 0:
            print(f"ERROR: OLIDS_SCHEMA '{schema}' has no known OLIDS tables in database '{database}'.")
            print("  Check OLIDS_SCHEMA / --olids-schema, SNOWFLAKE_DATABASE, and role access.")
            sys.exit(1)
        return {default_name: schema for default_name in SCHEMA_TABLES}

    # Reverse map: table name -> default schema(s)
    table_to_defaults = {}
    for default_schema, tables in SCHEMA_TABLES.items():
        for table in tables:
            table_to_defaults.setdefault(table, set()).add(default_schema)

    all_tables = sorted(table_to_defaults)
    placeholders = ','.join(f"'{t}'" for t in all_tables)
    query = (
        f"SELECT TABLE_SCHEMA, TABLE_NAME "
        f"FROM INFORMATION_SCHEMA.TABLES "
        f"WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA' "
        f"AND TABLE_NAME IN ({placeholders})"
    )

    results = _fetch_rows(conn, query)

    schema_to_tables = {}
    for schema, table in results:
        schema_to_tables.setdefault(schema, set()).add(table)

    # dbt/Snowflake OLIDS releases expose every logical OLIDS area through one
    # schema, commonly OLIDS_PCD or OLIDS_PSEUDO. Prefer that shape when one
    # schema contains at least one known table from every legacy group.
    single_schema_candidates = []
    for schema, tables in schema_to_tables.items():
        matched_groups = {
            default_schema
            for default_schema, expected_tables in SCHEMA_TABLES.items()
            if tables.intersection(expected_tables)
        }
        if len(matched_groups) == len(SCHEMA_TABLES):
            single_schema_candidates.append((schema, len(tables)))
    if single_schema_candidates:
        schema = sorted(single_schema_candidates, key=lambda item: (item[1], item[0]), reverse=True)[0][0]
        return {default_name: schema for default_name in SCHEMA_TABLES}

    # For each default schema, count how many of its expected tables appear in
    # each actual schema.
    default_to_counts = {ds: {} for ds in SCHEMA_TABLES}
    for schema, table in results:
        for default in table_to_defaults.get(table, []):
            default_to_counts[default][schema] = default_to_counts[default].get(schema, 0) + 1

    schema_map = {}
    for default_name, schema_counts in default_to_counts.items():
        if not schema_counts:
            print(f"ERROR: No tables found for schema '{default_name}' in database '{database}'.")
            print(f"  Expected tables: {', '.join(SCHEMA_TABLES[default_name][:5])}...")
            sys.exit(1)
        ranked = sorted(
            schema_counts.items(),
            key=lambda item: (item[1], item[0] == default_name, item[0]),
            reverse=True,
        )
        schema_map[default_name] = ranked[0][0]

    return schema_map


def fetch_schema_metadata(conn) -> dict:
    """Return {schema: {table: {columns}}} for the current database."""
    query = (
        "SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME "
        "FROM INFORMATION_SCHEMA.COLUMNS "
        "WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'"
    )
    rows = _fetch_rows(conn, query)
    metadata = {}
    for schema, table, column in rows:
        schema_key = str(schema).upper()
        table_key = str(table).upper()
        column_key = str(column).upper()
        metadata.setdefault(schema_key, {}).setdefault(table_key, set()).add(column_key)
    return metadata


def apply_schema_map(sql: str, schema_map: dict) -> str:
    """Replace default schema names in SQL with the detected actual names.

    Handles both direct references (OLIDS_MASKED.TABLE in test files) and
    SET variable values ('OLIDS_MASKED' in investigation files).
    """
    for default_name, actual_name in schema_map.items():
        if default_name != actual_name:
            sql = sql.replace(f'{default_name}.', f'{actual_name}.')
            sql = sql.replace(f"'{default_name}'", f"'{actual_name}'")
    return sql


def strip_sql_literals_and_comments(sql: str) -> str:
    """Blank out literals/comments so regex checks only see executable SQL."""
    sql = re.sub(r"/\*.*?\*/", " ", sql, flags=re.DOTALL)
    sql = re.sub(r"--.*?$", " ", sql, flags=re.MULTILINE)
    sql = re.sub(r"'(?:''|[^'])*'", "''", sql)
    sql = re.sub(r'"(?:""|[^"])*"', '""', sql)
    return sql


def normalize_identifier(identifier: str) -> str:
    """Normalize Snowflake identifiers for metadata lookup."""
    identifier = identifier.strip()
    if identifier.startswith('"') and identifier.endswith('"'):
        return identifier[1:-1].replace('""', '"').upper()
    return identifier.upper()


def find_matching_paren(sql: str, open_index: int) -> int:
    """Find the matching ')' for sql[open_index], ignoring strings/comments."""
    depth = 0
    i = open_index
    in_single = False
    in_double = False
    in_line_comment = False
    in_block_comment = False
    while i < len(sql):
        ch = sql[i]
        nxt = sql[i + 1] if i + 1 < len(sql) else ''

        if in_line_comment:
            if ch == '\n':
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if ch == '*' and nxt == '/':
                in_block_comment = False
                i += 2
            else:
                i += 1
            continue
        if in_single:
            if ch == "'" and nxt == "'":
                i += 2
                continue
            if ch == "'":
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"' and nxt == '"':
                i += 2
                continue
            if ch == '"':
                in_double = False
            i += 1
            continue

        if ch == '-' and nxt == '-':
            in_line_comment = True
            i += 2
            continue
        if ch == '/' and nxt == '*':
            in_block_comment = True
            i += 2
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def split_top_level_unions(sql: str) -> list:
    """Split a CTE body into top-level UNION branches.

    Returns [(delimiter_before_branch, branch_sql), ...]. The first delimiter
    is None.
    """
    branches = []
    depth = 0
    i = 0
    start = 0
    current_delimiter = None
    in_single = False
    in_double = False
    in_line_comment = False
    in_block_comment = False
    union_re = re.compile(r"\bUNION(?:\s+ALL)?\b", re.IGNORECASE)

    while i < len(sql):
        ch = sql[i]
        nxt = sql[i + 1] if i + 1 < len(sql) else ''

        if in_line_comment:
            if ch == '\n':
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if ch == '*' and nxt == '/':
                in_block_comment = False
                i += 2
            else:
                i += 1
            continue
        if in_single:
            if ch == "'" and nxt == "'":
                i += 2
                continue
            if ch == "'":
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"' and nxt == '"':
                i += 2
                continue
            if ch == '"':
                in_double = False
            i += 1
            continue

        if ch == '-' and nxt == '-':
            in_line_comment = True
            i += 2
            continue
        if ch == '/' and nxt == '*':
            in_block_comment = True
            i += 2
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == '(':
            depth += 1
            i += 1
            continue
        if ch == ')':
            depth -= 1
            i += 1
            continue

        if depth == 0:
            match = union_re.match(sql, i)
            if match:
                branch = sql[start:i].strip()
                if branch:
                    branches.append((current_delimiter, branch))
                current_delimiter = match.group(0).upper()
                i = match.end()
                start = i
                continue
        i += 1

    branch = sql[start:].strip()
    if branch:
        branches.append((current_delimiter, branch))
    return branches


def split_top_level_commas(sql: str) -> list:
    """Split a SQL fragment on top-level commas."""
    parts = []
    depth = 0
    i = 0
    start = 0
    in_single = False
    in_double = False
    while i < len(sql):
        ch = sql[i]
        nxt = sql[i + 1] if i + 1 < len(sql) else ''

        if in_single:
            if ch == "'" and nxt == "'":
                i += 2
                continue
            if ch == "'":
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"' and nxt == '"':
                i += 2
                continue
            if ch == '"':
                in_double = False
            i += 1
            continue

        if ch == "'":
            in_single = True
        elif ch == '"':
            in_double = True
        elif ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif ch == ',' and depth == 0:
            parts.append(sql[start:i].strip())
            start = i + 1
        i += 1

    tail = sql[start:].strip()
    if tail:
        parts.append(tail)
    return parts


def find_top_level_keyword(sql: str, keyword: str, start: int = 0) -> int:
    """Find a top-level SQL keyword index, ignoring parentheses and strings."""
    pattern = re.compile(rf"\b{re.escape(keyword)}\b", re.IGNORECASE)
    depth = 0
    i = start
    in_single = False
    in_double = False
    while i < len(sql):
        ch = sql[i]
        nxt = sql[i + 1] if i + 1 < len(sql) else ''

        if in_single:
            if ch == "'" and nxt == "'":
                i += 2
                continue
            if ch == "'":
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"' and nxt == '"':
                i += 2
                continue
            if ch == '"':
                in_double = False
            i += 1
            continue

        if ch == "'":
            in_single = True
        elif ch == '"':
            in_double = True
        elif ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif depth == 0:
            match = pattern.match(sql, i)
            if match:
                return i
        i += 1
    return -1


def extract_select_aliases(branch: str) -> list:
    """Extract output aliases from a simple SELECT branch."""
    select_match = re.search(r"\bSELECT\b", branch, flags=re.IGNORECASE)
    if not select_match:
        return []
    from_index = find_top_level_keyword(branch, "FROM", select_match.end())
    if from_index == -1:
        return []

    select_list = branch[select_match.end():from_index]
    aliases = []
    for expression in split_top_level_commas(select_list):
        alias_match = re.search(r"\bAS\s+([A-Za-z_][A-Za-z0-9_]*)\s*$", expression, flags=re.IGNORECASE)
        if not alias_match:
            return []
        aliases.append(alias_match.group(1))
    return aliases


def wrap_branch_with_aliases(branch: str, aliases: list) -> str:
    """Wrap a UNION branch so standalone execution preserves first-branch aliases."""
    if not aliases:
        return branch
    columns = ', '.join(aliases)
    return f"SELECT * FROM (\n{branch}\n) split_branch({columns})"


def extract_table_refs(sql: str) -> list:
    """Extract known-schema FROM/JOIN references as (schema, table, alias)."""
    refs = []
    pattern = re.compile(
        r"\b(?:FROM|JOIN)\s+"
        r"(?:(?P<db>\"[^\"]+\"|[A-Za-z0-9_]+)\.)?"
        r"(?P<schema>\"[^\"]+\"|[A-Za-z0-9_]+)\."
        r"(?P<table>\"[^\"]+\"|[A-Za-z0-9_]+)"
        r"(?:\s+(?:AS\s+)?(?P<alias>[A-Za-z_][A-Za-z0-9_]*))?",
        re.IGNORECASE,
    )
    for match in pattern.finditer(sql):
        alias = match.group('alias')
        refs.append((
            normalize_identifier(match.group('schema')),
            normalize_identifier(match.group('table')),
            normalize_identifier(alias) if alias else None,
        ))
    return refs


def referenced_unqualified_columns(sql: str) -> set:
    """Best-effort extraction of unqualified column refs used by test SQL."""
    cleaned = strip_sql_literals_and_comments(sql)
    columns = set()
    patterns = [
        r"\bCOUNT\s*\(\s*DISTINCT\s+([A-Za-z_][A-Za-z0-9_]*)",
        r"\bWHEN\s+([A-Za-z_][A-Za-z0-9_]*)\s+IS\s+(?:NOT\s+)?NULL",
        r"\bWHERE\s+([A-Za-z_][A-Za-z0-9_]*)\s+IS\s+(?:NOT\s+)?NULL",
        r"\bWHEN\s+([A-Za-z_][A-Za-z0-9_]*)\s*(?:<=|>=|<>|!=|=|<|>)",
        r"\bMAX\s*\(\s*(?:CASE\s+WHEN\s+)?([A-Za-z_][A-Za-z0-9_]*)",
        r"\bGROUP\s+BY\s+([A-Za-z_][A-Za-z0-9_]*(?:\s*,\s*[A-Za-z_][A-Za-z0-9_]*)*)",
    ]
    for pattern in patterns:
        for match in re.finditer(pattern, cleaned, flags=re.IGNORECASE):
            for identifier in re.split(r"\s*,\s*", match.group(1)):
                columns.add(normalize_identifier(identifier))
    return columns


def validate_sql_branch(branch: str, metadata: dict, active_schemas: set) -> tuple:
    """Return (is_valid, reasons) for one UNION branch."""
    refs = extract_table_refs(branch)
    known_refs = []
    reasons = []
    active_ref_count = 0

    for schema, table, alias in refs:
        if schema not in active_schemas:
            continue
        active_ref_count += 1
        if schema not in metadata or table not in metadata[schema]:
            reasons.append(f"missing table {schema}.{table}")
            continue
        key = (schema, table)
        known_refs.append((key, alias, table))

    alias_to_table = {}
    for key, alias, table in known_refs:
        alias_to_table[table] = key
        if alias:
            alias_to_table[alias] = key

    cleaned = strip_sql_literals_and_comments(branch)
    for alias, column in re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)\b", cleaned):
        alias_key = normalize_identifier(alias)
        column_key = normalize_identifier(column)
        table_key = alias_to_table.get(alias_key)
        if table_key and column_key not in metadata[table_key[0]][table_key[1]]:
            reasons.append(f"missing column {table_key[0]}.{table_key[1]}.{column_key}")

    single_tables = {key for key, _alias, _table in known_refs}
    if len(single_tables) == 1 and active_ref_count == len(known_refs):
        schema, table = next(iter(single_tables))
        for column in referenced_unqualified_columns(branch):
            if column not in metadata[schema][table]:
                reasons.append(f"missing column {schema}.{table}.{column}")

    return not reasons, sorted(set(reasons))


def compatibility_warning(sql_file: Path, reason: str, table_name: str = 'N/A') -> dict:
    """Build a WARN row that fits the normal test output contract."""
    return {
        'TEST_NAME': 'schema_compatibility',
        'TABLE_NAME': table_name,
        'TEST_SUBJECT': reason[:500],
        'STATUS': 'WARN',
        'METRIC_VALUE': None,
        'THRESHOLD': None,
        'SQL_FILE': sql_file.name,
    }


def prune_incompatible_unions(sql: str, metadata: dict, active_schemas: set, sql_file: Path) -> tuple:
    """Remove UNION branches that reference absent OLIDS tables/columns."""
    warnings = []
    replacements = []
    for match in re.finditer(r"\b([A-Za-z_][A-Za-z0-9_]*)\s+AS\s*\(", sql, flags=re.IGNORECASE):
        open_index = sql.find('(', match.end() - 1)
        close_index = find_matching_paren(sql, open_index)
        if close_index == -1:
            continue

        body = sql[open_index + 1:close_index]
        if not re.search(r"\bUNION(?:\s+ALL)?\b", body, flags=re.IGNORECASE):
            continue

        branches = split_top_level_unions(body)
        if len(branches) <= 1:
            continue

        kept = []
        skipped = []
        for delimiter, branch in branches:
            valid, reasons = validate_sql_branch(branch, metadata, active_schemas)
            if valid:
                kept.append((delimiter, branch))
            else:
                skipped.append((branch, reasons))

        if not skipped or not kept:
            continue

        rebuilt = []
        for i, (delimiter, branch) in enumerate(kept):
            if i > 0:
                rebuilt.append(f"\n    {delimiter or 'UNION ALL'}\n")
            rebuilt.append(branch)
        replacement = ''.join(rebuilt)
        if not replacement.endswith('\n'):
            replacement += '\n'
        replacements.append((open_index + 1, close_index, replacement))

        cte_name = match.group(1)
        for branch, reasons in skipped:
            table_match = re.search(r"SELECT\s+'([^']+)'", branch, flags=re.IGNORECASE)
            table_name = table_match.group(1) if table_match else cte_name
            warnings.append(compatibility_warning(
                sql_file,
                f"Skipped incompatible {cte_name} block: {'; '.join(reasons)}",
                table_name,
            ))

    for start, end, replacement in reversed(replacements):
        sql = sql[:start] + replacement + sql[end:]
    return sql, warnings


def split_union_check_runs(sql: str, metadata: dict, active_schemas: set, sql_file: Path) -> tuple:
    """Build one SQL text per compatible branch of a check-style UNION CTE.

    This lets each old UNION ALL block behave like an independent test. If one
    branch references a legacy table/column, it becomes a WARN without blocking
    the other branches in the same file.
    """
    for match in re.finditer(r"\b([A-Za-z_][A-Za-z0-9_]*)\s+AS\s*\(", sql, flags=re.IGNORECASE):
        open_index = sql.find('(', match.end() - 1)
        close_index = find_matching_paren(sql, open_index)
        if close_index == -1:
            continue

        body = sql[open_index + 1:close_index]
        if not re.search(r"\bUNION(?:\s+ALL)?\b", body, flags=re.IGNORECASE):
            continue

        branches = split_top_level_unions(body)
        if len(branches) <= 1:
            continue

        # Only split CTEs whose UNION branches directly read the active OLIDS
        # schemas. This avoids splitting final reporting CTEs that UNION results
        # from earlier CTEs.
        if not any(
            schema in active_schemas
            for _delimiter, branch in branches
            for schema, _table, _alias in extract_table_refs(branch)
        ):
            continue

        warnings = []
        sql_runs = []
        cte_name = match.group(1)
        output_aliases = extract_select_aliases(branches[0][1])
        for _delimiter, branch in branches:
            valid, reasons = validate_sql_branch(branch, metadata, active_schemas)
            table_match = re.search(r"SELECT\s+'([^']+)'", branch, flags=re.IGNORECASE)
            table_name = table_match.group(1) if table_match else cte_name
            if not valid:
                warnings.append(compatibility_warning(
                    sql_file,
                    f"Skipped incompatible {cte_name} block: {'; '.join(reasons)}",
                    table_name,
                ))
                continue

            replacement = wrap_branch_with_aliases(branch, output_aliases)
            if not replacement.endswith('\n'):
                replacement += '\n'
            sql_runs.append(sql[:open_index + 1] + replacement + sql[close_index:])

        if sql_runs or warnings:
            return sql_runs, warnings, cte_name

    return [], [], None


def split_statements(sql: str) -> list:
    """Split SQL into individual statements, skipping empty/comment-only ones."""
    statements = []
    for stmt in sql.split(';'):
        stmt = stmt.strip()
        if not stmt:
            continue
        # Skip statements where every non-empty line is a -- comment
        lines = [l.strip() for l in stmt.split('\n') if l.strip()]
        if lines and all(l.startswith('--') for l in lines):
            continue
        statements.append(stmt)
    return statements


def _statements_for_sql(sql: str, database: str) -> list:
    """Add runner-controlled database context and split executable statements."""
    preamble = f'USE DATABASE "{database}"'
    full_sql = preamble + ';\n' + sql
    statements = split_statements(full_sql)
    statements = [statements[0]] + [
        s for s in statements[1:]
        if not s.strip().upper().startswith(('USE DATABASE', 'USE SCHEMA'))
    ]
    return statements


def _execute_statements(conn, statements: list, database: str, sql_file: Path,
                        compatibility: bool = True, context: str = None) -> tuple:
    """Execute prepared SQL statements and return (rows, warnings)."""
    warnings = []
    if not statements:
        return [], warnings

    if USE_SNOWPARK:
        for i, stmt in enumerate(statements[:-1]):
            try:
                conn.sql(stmt).collect()
            except Exception as e:
                if i == 0 and 'USE' in stmt.upper():
                    raise RuntimeError(
                        f"Failed to set database '{database}'. "
                        f"Check SNOWFLAKE_DATABASE in .env is correct and your role has access."
                    ) from e
                raise
        try:
            df = conn.sql(statements[-1]).to_pandas()
            return df.to_dict('records'), warnings
        except Exception as e:
            if compatibility:
                subject = context or "SQL file"
                warnings.append(compatibility_warning(
                    sql_file,
                    f"Skipped {subject} after compatibility pruning could not compile: {e}",
                ))
                return [], warnings
            raise

    cursor = conn.cursor()
    try:
        for i, stmt in enumerate(statements):
            try:
                cursor.execute(stmt)
            except Exception as e:
                if i == 0 and 'USE' in stmt.upper():
                    raise RuntimeError(
                        f"Failed to set database '{database}'. "
                        f"Check SNOWFLAKE_DATABASE in .env is correct and your role has access."
                    ) from e
                if compatibility and i == len(statements) - 1:
                    subject = context or "SQL file"
                    warnings.append(compatibility_warning(
                        sql_file,
                        f"Skipped {subject} after compatibility pruning could not compile: {e}",
                    ))
                    return [], warnings
                raise
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        rows = cursor.fetchall()
        return [dict(zip(columns, row)) for row in rows], warnings
    finally:
        cursor.close()


def execute_sql(conn, sql_file: Path, database: str, schema_map: dict = None,
                metadata: dict = None, compatibility: bool = True,
                split_union_checks: bool = False) -> tuple:
    """Execute USE DATABASE then the SQL file, returning result rows as dicts.

    Strips any USE DATABASE statements from the file (the runner controls database
    context via .env), and applies schema name remapping before execution.
    """
    sql = sql_file.read_text(encoding='utf-8')
    if schema_map:
        sql = apply_schema_map(sql, schema_map)
    warnings = []

    if compatibility and split_union_checks and metadata and schema_map:
        active_schemas = {str(schema).upper() for schema in schema_map.values()}
        sql_runs, split_warnings, cte_name = split_union_check_runs(sql, metadata, active_schemas, sql_file)
        warnings.extend(split_warnings)
        if sql_runs:
            rows = []
            for branch_sql in sql_runs:
                branch_rows, branch_warnings = _execute_statements(
                    conn,
                    _statements_for_sql(branch_sql, database),
                    database,
                    sql_file,
                    compatibility=compatibility,
                    context=f"{cte_name} block",
                )
                rows.extend(branch_rows)
                warnings.extend(branch_warnings)
            return rows, warnings
        if split_warnings:
            return [], warnings

    if compatibility and metadata and schema_map:
        sql, warnings = prune_incompatible_unions(
            sql,
            metadata,
            {str(schema).upper() for schema in schema_map.values()},
            sql_file,
        )

    rows, execution_warnings = _execute_statements(
        conn,
        _statements_for_sql(sql, database),
        database,
        sql_file,
        compatibility=compatibility,
    )
    warnings.extend(execution_warnings)
    return rows, warnings


# Standard columns that every test must return. Any additional columns
# returned by a test SQL file are automatically collected as "details"
# and shown in verbose mode.
STANDARD_COLUMNS = {'TEST_NAME', 'TABLE_NAME', 'TEST_SUBJECT', 'STATUS',
                    'METRIC_VALUE', 'THRESHOLD'}


def _extra_columns(row: dict) -> dict:
    """Return non-standard columns from a result row."""
    return {k: v for k, v in row.items() if k not in STANDARD_COLUMNS}


def print_query_results(results: list):
    """Print query results as a formatted table (for --run mode)."""
    if not results:
        print("No results returned.")
        return
    columns = list(results[0].keys())
    col_widths = {}
    for col in columns:
        values = [str(r.get(col, '')) for r in results]
        col_widths[col] = min(max(len(col), max((len(v) for v in values), default=0)), 40)
    header = ' | '.join(col.ljust(col_widths[col])[:col_widths[col]] for col in columns)
    separator = '-+-'.join('-' * col_widths[col] for col in columns)
    print(header)
    print(separator)
    for r in results:
        row = ' | '.join(str(r.get(col, '')).ljust(col_widths[col])[:col_widths[col]] for col in columns)
        print(row)
    print(f"\n{len(results)} row(s)")


def print_results(all_results: dict, durations: dict = None, verbose: bool = False):
    """Print formatted test results to console."""
    total_tests = 0
    total_pass = 0
    total_fail = 0
    total_warn = 0
    durations = durations or {}

    print("\n" + "=" * 80)
    print("OLIDS DATA QUALITY TEST RESULTS")
    print("=" * 80)
    print(f"Execution time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()

    for test_file, results in all_results.items():
        if not results:
            print(f"\n  {test_file}: No results returned")
            continue

        # Count by status
        pass_count = sum(1 for r in results if r.get('STATUS') == 'PASS')
        fail_count = sum(1 for r in results if r.get('STATUS') == 'FAIL')
        warn_count = sum(1 for r in results if r.get('STATUS') == 'WARN')

        total_tests += len(results)
        total_pass += pass_count
        total_fail += fail_count
        total_warn += warn_count

        # Test header
        status_icon = "FAIL" if fail_count else ("WARN" if warn_count and not pass_count else "PASS")
        dur = f" ({durations[test_file]:.1f}s)" if test_file in durations else ""
        print(f"\n[{status_icon}] {test_file}{dur}")
        print(f"   PASS: {pass_count} | FAIL: {fail_count}" + (f" | WARN: {warn_count}" if warn_count else ""))

        # Show failures
        failures = [r for r in results if r.get('STATUS') == 'FAIL']
        if failures:
            print("\n   Failures:")
            for f in failures:
                table = f.get('TABLE_NAME', 'N/A')
                subject = f.get('TEST_SUBJECT', 'N/A')
                metric = f.get('METRIC_VALUE', 'N/A')
                threshold = f.get('THRESHOLD', 'N/A')
                print(f"   - {table}.{subject}: {metric}% (threshold: {threshold}%)")

                extras = _extra_columns(f)
                if extras:
                    detail = ', '.join(f"{k}={v}" for k, v in extras.items())
                    print(f"     [{detail}]")

        # Show passing results
        passes = [r for r in results if r.get('STATUS') == 'PASS']
        if passes and verbose:
            print("\n   Passed:")
            for p in passes:
                table = p.get('TABLE_NAME', 'N/A')
                subject = p.get('TEST_SUBJECT', 'N/A')
                metric = p.get('METRIC_VALUE', 'N/A')
                threshold = p.get('THRESHOLD', 'N/A')
                print(f"   - {table}.{subject}: {metric}% (threshold: {threshold}%)")
                for k, v in _extra_columns(p).items():
                    print(f"       {k}: {v}")

        # Show warnings
        warnings = [r for r in results if r.get('STATUS') == 'WARN']
        if warnings:
            print("\n   Warnings:")
            for w in warnings:
                table = w.get('TABLE_NAME', 'N/A')
                subject = w.get('TEST_SUBJECT', 'N/A')
                print(f"   - {table}.{subject}")

    # Summary
    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total checks: {total_tests}")
    print(f"Passed: {total_pass} ({100*total_pass/total_tests:.1f}%)" if total_tests else "Passed: 0")
    print(f"Failed: {total_fail} ({100*total_fail/total_tests:.1f}%)" if total_tests else "Failed: 0")
    if total_warn:
        print(f"Warnings: {total_warn}")

    if total_fail:
        overall = f"{total_fail} TESTS FAILED"
    elif total_warn:
        overall = "NO FAILURES (WARNINGS PRESENT)"
    else:
        overall = "ALL TESTS PASSED"
    print(f"\n{overall}")
    print("=" * 80)

    return total_fail == 0


def main():
    parser = argparse.ArgumentParser(description='Run OLIDS data quality tests')
    parser.add_argument('--dir', '-d', default='data-quality',
                        help='Test subdirectory (default: data-quality)')
    parser.add_argument('--test', '-t', help='Run specific test file only')
    parser.add_argument('--run', '-r', help='Execute any SQL file with schema replacement and print results')
    parser.add_argument('--olids-schema',
                        help='Map all legacy OLIDS schemas to one physical schema (or set OLIDS_SCHEMA)')
    parser.add_argument('--strict-schema', action='store_true',
                        help='Disable compatibility pruning for legacy tables/columns')
    parser.add_argument('--verbose', '-v', action='store_true', help='Show detailed output')
    args = parser.parse_args()

    validate_config()

    run_file = None
    if args.run:
        run_path = Path(args.run)
        if not run_path.is_absolute():
            run_path = Path(__file__).parent / run_path
        if not run_path.exists():
            print(f"ERROR: SQL file not found: {args.run}")
            sys.exit(1)
        run_file = run_path

    # Find tests (skip when using --run)
    tests = []
    if not run_file:
        test_dir = Path(__file__).parent / args.dir
        if not test_dir.exists():
            print(f"ERROR: Test directory not found: {test_dir}")
            sys.exit(1)

        tests = discover_tests(test_dir, args.test)

        if not tests:
            print(f"No test files found (test_*.sql) in {test_dir}")
            sys.exit(1)

        print(f"Found {len(tests)} test file(s)")
        for t in tests:
            print(f"  - {t.name}")

    # Connect to Snowflake
    print("\nConnecting to Snowflake...")
    try:
        conn = get_connection()
        print("Connected successfully")
    except Exception as e:
        print(f"ERROR: Failed to connect: {e}")
        sys.exit(1)

    # Detect schema names
    print("\nDetecting schemas...")
    try:
        use_db_stmt = f'USE DATABASE "{DATABASE}"'
        if USE_SNOWPARK:
            conn.sql(use_db_stmt).collect()
        else:
            cursor = conn.cursor()
            try:
                cursor.execute(use_db_stmt)
            finally:
                cursor.close()
    except Exception as e:
        print(f"ERROR: Failed to set database '{DATABASE}': {e}")
        print("Check SNOWFLAKE_DATABASE in .env is correct and your role has access.")
        conn.close()
        sys.exit(1)

    single_schema = (args.olids_schema or OLIDS_SCHEMA or '').strip() or None
    schema_map = detect_schemas(conn, DATABASE, single_schema=single_schema)
    metadata = fetch_schema_metadata(conn)
    print(f"Database: {DATABASE}")
    if single_schema:
        print(f"  Single OLIDS schema override: {single_schema.upper()}")
    elif len(set(schema_map.values())) == 1:
        print(f"  Single OLIDS schema discovered: {next(iter(schema_map.values()))}")
    for default, actual in schema_map.items():
        label = f" (remapped from {default})" if default != actual else ""
        print(f"  {actual}{label}")
    if not args.strict_schema:
        print("  Schema compatibility pruning: enabled")

    # --run mode: execute a single SQL file and print results
    if run_file:
        print(f"\nExecuting: {run_file.name}...")
        try:
            results, warnings = execute_sql(
                conn,
                run_file,
                DATABASE,
                schema_map,
                metadata,
                compatibility=not args.strict_schema,
                split_union_checks=False,
            )
            print()
            if warnings:
                print(f"Compatibility warnings: {len(warnings)} skipped block(s)")
                for warning in warnings[:10]:
                    print(f"  - {warning['TABLE_NAME']}: {warning['TEST_SUBJECT']}")
                if len(warnings) > 10:
                    print(f"  ... {len(warnings) - 10} more")
                print()
            print_query_results(results)
        except Exception as e:
            print(f"ERROR: {e}")
            sys.exit(1)
        finally:
            conn.close()
        sys.exit(0)

    # Execute tests
    all_results = {}
    all_durations = {}
    pipeline_start = time.time()
    try:
        for test_file in tests:
            print(f"\nExecuting: {test_file.name}...")
            test_start = time.time()
            try:
                results, warnings = execute_sql(
                    conn,
                    test_file,
                    DATABASE,
                    schema_map,
                    metadata,
                    compatibility=not args.strict_schema,
                    split_union_checks=not args.strict_schema,
                )
                results.extend(warnings)
                duration = time.time() - test_start
                all_results[test_file.name] = results
                all_durations[test_file.name] = duration
                passed = sum(1 for r in results if r.get('STATUS') == 'PASS')
                failed = sum(1 for r in results if r.get('STATUS') == 'FAIL')
                warned = sum(1 for r in results if r.get('STATUS') == 'WARN')
                icon = "FAIL" if failed else ("WARN" if warned and not passed else "PASS")
                summary = f"[{icon}] {len(results)} checks: {passed} passed, {failed} failed"
                if warned:
                    summary += f", {warned} warnings"
                print(f"  -> {summary} ({duration:.1f}s)")
            except Exception as e:
                duration = time.time() - test_start
                all_durations[test_file.name] = duration
                print(f"  -> ERROR: {e} ({duration:.1f}s)")
                all_results[test_file.name] = []
    finally:
        conn.close()
        print("\nConnection closed")

    # Print results
    pipeline_duration = time.time() - pipeline_start
    all_passed = print_results(all_results, durations=all_durations, verbose=args.verbose)

    print(f"\nTotal duration: {pipeline_duration:.1f}s")
    print("=" * 80)

    # Exit code
    sys.exit(0 if all_passed else 1)


if __name__ == '__main__':
    main()
