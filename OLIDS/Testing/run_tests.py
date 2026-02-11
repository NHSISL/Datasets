#!/usr/bin/env python3
"""
OLIDS Data Quality Test Runner

Discovers and executes test_*.sql files against Snowflake.
Database context is set from SNOWFLAKE_DATABASE in .env.

Usage:
    uv run run_tests.py
    uv run run_tests.py --test test_data_freshness
    uv run run_tests.py --verbose
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
        print("Run setup.ps1 or copy .env.example to .env and fill in your credentials.")
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


def execute_test(conn, sql_file: Path, database: str) -> list:
    """Execute USE DATABASE then the test SQL, returning result rows as dicts."""
    preamble = f'USE DATABASE "{database}"'
    sql = sql_file.read_text(encoding='utf-8')
    full_sql = preamble + ';\n' + sql

    statements = split_statements(full_sql)
    if not statements:
        return []

    if USE_SNOWPARK:
        # Execute each statement; collect results from the last one
        for stmt in statements[:-1]:
            conn.sql(stmt).collect()
        df = conn.sql(statements[-1]).to_pandas()
        return df.to_dict('records')
    else:
        cursor = conn.cursor()
        try:
            for stmt in statements:
                cursor.execute(stmt)
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

                if verbose:
                    for k, v in _extra_columns(f).items():
                        print(f"       {k}: {v}")

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
    parser.add_argument('--verbose', '-v', action='store_true', help='Show detailed output')
    args = parser.parse_args()

    validate_config()

    # Find tests
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

    # Execute tests
    all_results = {}
    all_durations = {}
    pipeline_start = time.time()
    try:
        for test_file in tests:
            print(f"\nExecuting: {test_file.name}...")
            test_start = time.time()
            try:
                results = execute_test(conn, test_file, DATABASE)
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
