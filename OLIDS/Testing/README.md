# OLIDS Data Quality Tests

SQL-based data quality tests for OLIDS, run against Snowflake. Portable across London ICBs — each ICB sets their own database name via `.env` and the runner auto-detects schema names at startup.

## Prerequisites

- **Git** — to clone the repository
  - Windows: download from [git-scm.com/downloads/win](https://git-scm.com/downloads/win)
  - macOS: run `xcode-select --install` or download from [git-scm.com/downloads/mac](https://git-scm.com/downloads/mac)
- **A web browser** — for Snowflake SSO login (opens automatically on first run)

Python and all dependencies are installed automatically by the setup script via [uv](https://docs.astral.sh/uv/).

## Setup

```powershell
# Windows
cd OLIDS/Testing
.\setup.ps1
```

```bash
# macOS / Linux
cd OLIDS/Testing
./setup.sh
```

This installs [uv](https://docs.astral.sh/uv/), prompts for Snowflake credentials, writes `.env`, and runs `uv sync`.

> **Snowflake private link**: If your organisation connects via private link, use the format `<account_locator>.<region>.privatelink` as your Snowflake account identifier (e.g. `us12345.uk-south.privatelink`).

## Running Tests

All commands assume you're in the `OLIDS/Testing` directory.

```bash
# Run all tests
uv run run_tests.py

# Run a single test
uv run run_tests.py --test test_column_completeness

# Show passing results and extra columns
uv run run_tests.py --verbose

# Run an investigation script (or any SQL file) with schema auto-detection
uv run run_tests.py --run investigations/investigate_column_completeness.sql
```

## Tests

| File | What it checks |
|---|---|
| `test_column_completeness.sql` | NULL rates per column, with per-column thresholds |
| `test_referential_integrity.sql` | Foreign keys reference existing parent records |
| `test_concept_mapping.sql` | Concept IDs map through CONCEPT_MAP to CONCEPT |
| `test_data_freshness.sql` | GP practices sending data within N days |
| `test_registration_pds.sql` | OLIDS registration counts vs PDS at 1%, 2%, 5% thresholds |

## Output Contract

Every test SQL must return these columns:

| Column | Description |
|---|---|
| `test_name` | Identifier for the test |
| `table_name` | Table or domain being tested |
| `test_subject` | What specifically is being checked |
| `status` | `PASS`, `FAIL`, or `WARN` |
| `metric_value` | Measured value (usually a %) |
| `threshold` | Target the metric is compared against |

Additional columns are allowed and shown with `--verbose`.

## Adding Checks

Each test file has a `-- To add a check:` comment at the top explaining the pattern. In general:

- **Column completeness**: add a `UNION ALL SELECT` row with table, column, threshold, `COUNT(*)`, and `SUM(CASE WHEN col IS NULL ...)`.
- **Referential integrity**: add a `UNION ALL` block with the child table `LEFT JOIN`ed to the parent.
- **Concept mapping**: add a `UNION ALL` block joining the concept field through `CONCEPT_MAP` and `CONCEPT`.
- **Data freshness**: add a `UNION ALL` block selecting `table_name`, `org_code`, `MAX(date_recorded)` from any table with those columns.

## Creating New Test Files

Drop a `test_*.sql` file in `data-quality/` and the runner picks it up automatically. The final `SELECT` must return these columns:

```sql
SELECT
    'my_test_name'   AS test_name,      -- identifies the test
    'SOME_TABLE'     AS table_name,     -- table or domain being tested
    'what is checked' AS test_subject,  -- human-readable description of the check
    CASE WHEN ... THEN 'PASS' ELSE 'FAIL' END AS status,  -- PASS, FAIL, or WARN
    42.5             AS metric_value,   -- measured value (usually a %)
    100.0            AS threshold       -- target the metric is compared against
FROM ...
```

Use `UNION ALL` to return multiple checks from one file. Any extra columns beyond these six are shown with `--verbose`.

Other notes:
- Use `SET var = value;` and `$var` for Snowflake session variables (e.g. thresholds)
- Schema names are declared as SET variables at the top of each file (`schema_masked`, `schema_common`, `schema_terminology`). The runner auto-detects actual schema names at startup and replaces them in the SQL before execution (e.g. `OLIDS_MASKED` → `OLIDS_PCD`). For Snowsight, find-replace the schema prefixes to match your ICB.
- Avoid semicolons inside comments or string literals — the runner naively splits on `;` to execute statements individually

## Investigating Failures

The `investigations/` folder has companion scripts for each test. These return row-level detail to help diagnose failures. Run them through the runner with `--run` (handles schema detection and database context automatically), or directly in Snowsight (set the `USE DATABASE` and find-replace the schema prefixes at the top of each file to match your ICB).

```bash
uv run run_tests.py --run investigations/investigate_referential_integrity.sql
```

| File | What it shows |
|---|---|
| `investigate_column_completeness.sql` | All checked columns with NULL counts and rates |
| `investigate_concept_mapping.sql` | Unmapped concept IDs and their row counts per table |
| `investigate_data_freshness.sql` | Per-org, per-table last data date, ordered by stalest |
| `investigate_referential_integrity.sql` | Orphaned FK values with row counts |
| `investigate_registration_pds.sql` | Per-practice OLIDS vs PDS counts with diff and status |

## ICB-Specific Tests

For tests that reference datasets unique to your ICB (e.g. local reference tables or warehouse-specific schemas), create a subdirectory and run with `--dir`:

```bash
uv run run_tests.py --dir my-icb-tests
```
