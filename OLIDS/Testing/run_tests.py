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
    uv run run_tests.py --run investigations/investigate_column_completeness.sql
"""

import os
import sys
import time
import argparse
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
    """Create Snowflake connection using SSO."""
    connection_params = {
        "account": ACCOUNT,
        "user": USER,
        "authenticator": "externalbrowser",
        "warehouse": WAREHOUSE,
        "role": ROLE,
    }

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
        'DIAGNOSTIC_ORDER', 'ENCOUNTER', 'EPISODE_OF_CARE', 'FLAG', 'LOCATION',
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


def detect_schemas(conn, database: str) -> dict:
    """Auto-detect schema names by querying INFORMATION_SCHEMA for known tables.

    Returns a map from default name to actual name, e.g.
    {'OLIDS_MASKED': 'OLIDS_PCD', 'OLIDS_COMMON': 'OLIDS_COMMON', ...}
    """
    # Reverse map: table name -> default schema
    table_to_default = {}
    for default_schema, tables in SCHEMA_TABLES.items():
        for table in tables:
            table_to_default[table] = default_schema

    all_tables = list(table_to_default.keys())
    placeholders = ','.join(f"'{t}'" for t in all_tables)
    query = (
        f"SELECT TABLE_SCHEMA, TABLE_NAME "
        f"FROM INFORMATION_SCHEMA.TABLES "
        f"WHERE TABLE_NAME IN ({placeholders})"
    )

    if USE_SNOWPARK:
        rows = conn.sql(query).collect()
        results = [(r['TABLE_SCHEMA'], r['TABLE_NAME']) for r in rows]
    else:
        cursor = conn.cursor()
        try:
            cursor.execute(query)
            results = cursor.fetchall()
        finally:
            cursor.close()

    # For each default schema, collect the actual schema(s) its tables appear in
    default_to_actuals = {ds: set() for ds in SCHEMA_TABLES}
    for schema, table in results:
        default = table_to_default.get(table)
        if default:
            default_to_actuals[default].add(schema)

    schema_map = {}
    for default_name, actual_schemas in default_to_actuals.items():
        if not actual_schemas:
            print(f"ERROR: No tables found for schema '{default_name}' in database '{database}'.")
            print(f"  Expected tables: {', '.join(SCHEMA_TABLES[default_name][:5])}...")
            sys.exit(1)
        if len(actual_schemas) > 1:
            print(f"ERROR: Tables for '{default_name}' found in multiple schemas: "
                  f"{', '.join(sorted(actual_schemas))}")
            sys.exit(1)
        schema_map[default_name] = actual_schemas.pop()

    return schema_map


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


def execute_sql(conn, sql_file: Path, database: str, schema_map: dict = None) -> list:
    """Execute USE DATABASE then the SQL file, returning result rows as dicts.

    Strips any USE DATABASE statements from the file (the runner controls database
    context via .env), and applies schema name remapping before execution.
    """
    preamble = f'USE DATABASE "{database}"'
    sql = sql_file.read_text(encoding='utf-8')
    if schema_map:
        sql = apply_schema_map(sql, schema_map)
    full_sql = preamble + ';\n' + sql

    statements = split_statements(full_sql)
    # Strip USE DATABASE/SCHEMA statements from the file; the preamble handles context
    statements = [statements[0]] + [
        s for s in statements[1:]
        if not s.strip().upper().startswith(('USE DATABASE', 'USE SCHEMA'))
    ]
    if not statements:
        return []

    if USE_SNOWPARK:
        # Execute each statement; collect results from the last one
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
        df = conn.sql(statements[-1]).to_pandas()
        return df.to_dict('records')
    else:
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
                    raise
            columns = [desc[0] for desc in cursor.description] if cursor.description else []
            rows = cursor.fetchall()
            return [dict(zip(columns, row)) for row in rows]
        finally:
            cursor.close()


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
        status_icon = "PASS" if fail_count == 0 else "FAIL"
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

    overall = "ALL TESTS PASSED" if total_fail == 0 else f"{total_fail} TESTS FAILED"
    print(f"\n{overall}")
    print("=" * 80)

    return total_fail == 0


def main():
    parser = argparse.ArgumentParser(description='Run OLIDS data quality tests')
    parser.add_argument('--dir', '-d', default='data-quality',
                        help='Test subdirectory (default: data-quality)')
    parser.add_argument('--test', '-t', help='Run specific test file only')
    parser.add_argument('--run', '-r', help='Execute any SQL file with schema replacement and print results')
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

    schema_map = detect_schemas(conn, DATABASE)
    print(f"Database: {DATABASE}")
    for default, actual in schema_map.items():
        label = f" (remapped from {default})" if default != actual else ""
        print(f"  {actual}{label}")

    # --run mode: execute a single SQL file and print results
    if run_file:
        print(f"\nExecuting: {run_file.name}...")
        try:
            results = execute_sql(conn, run_file, DATABASE, schema_map)
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
                results = execute_sql(conn, test_file, DATABASE, schema_map)
                duration = time.time() - test_start
                all_results[test_file.name] = results
                all_durations[test_file.name] = duration
                passed = sum(1 for r in results if r.get('STATUS') == 'PASS')
                failed = sum(1 for r in results if r.get('STATUS') == 'FAIL')
                warned = sum(1 for r in results if r.get('STATUS') == 'WARN')
                icon = "PASS" if failed == 0 else "FAIL"
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
