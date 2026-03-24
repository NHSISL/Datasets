/*
    Test: Data Freshness
    Run:  uv run run_tests.py --test test_data_freshness

    OLIDS tables have a date_recorded column showing when data was last received
    from each GP practice. This test checks that practices are sending data recently.

    How it works:
      1. The 'org_freshness' CTE finds MAX(date_recorded) per org per table,
         ignoring future dates (data quality issue in some feeds).
      2. The 'table_summary' CTE counts how many orgs are "fresh" (within
         freshness_days of today) vs "stale" per table.
      3. PASS if >= pass_threshold_pct of orgs are fresh for that table.

    Configuration (SET variables):
      - freshness_days: max days since last record to count as fresh (default: 5)
      - pass_threshold_pct: % of orgs that must be fresh to pass (default: 90)

    Output:
      - metric_value = % of orgs with fresh data
      - total_orgs, fresh_orgs, stale_orgs, min/max/avg days (shown with --verbose)

    Coverage:
      The 8 tables below are all OLIDS tables that have both
      record_owner_organisation_code and date_recorded columns.

    To add a table:
      Add a UNION ALL block selecting table_name, org_code, MAX(date_recorded),
      and DATEDIFF from any table with record_owner_organisation_code and
      date_recorded columns.
*/

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

SET freshness_days = 5;
SET pass_threshold_pct = 90.0;

WITH org_freshness AS (
    -- Each block: find most recent date_recorded per org for one table
    -- OBSERVATION
    SELECT 'OBSERVATION' AS table_name, record_owner_organisation_code AS org_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END) AS max_date_recorded,
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE) AS days_since_last
    FROM OLIDS_COMMON.OBSERVATION WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- ENCOUNTER
    SELECT 'ENCOUNTER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ENCOUNTER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- MEDICATION_ORDER
    SELECT 'MEDICATION_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_ORDER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- MEDICATION_STATEMENT
    SELECT 'MEDICATION_STATEMENT', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- DIAGNOSTIC_ORDER
    SELECT 'DIAGNOSTIC_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- ALLERGY_INTOLERANCE
    SELECT 'ALLERGY_INTOLERANCE', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- PROCEDURE_REQUEST
    SELECT 'PROCEDURE_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL

    -- REFERRAL_REQUEST
    SELECT 'REFERRAL_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.REFERRAL_REQUEST WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code
),

-- Aggregate: count fresh vs stale orgs per table
table_summary AS (
    SELECT
        table_name,
        COUNT(DISTINCT org_code) AS total_orgs,
        COUNT(DISTINCT CASE WHEN days_since_last <= $freshness_days THEN org_code END) AS fresh_orgs,
        COUNT(DISTINCT CASE WHEN days_since_last > $freshness_days THEN org_code END) AS stale_orgs,
        ROUND(100.0 * COUNT(DISTINCT CASE WHEN days_since_last <= $freshness_days THEN org_code END) / NULLIF(COUNT(DISTINCT org_code), 0), 2) AS fresh_pct,
        MIN(days_since_last) AS min_days_since,
        MAX(days_since_last) AS max_days_since,
        ROUND(AVG(days_since_last), 1) AS avg_days_since
    FROM org_freshness
    WHERE max_date_recorded IS NOT NULL
    GROUP BY table_name
)

SELECT
    'data_freshness' AS test_name,
    table_name,
    'orgs with data within ' || $freshness_days || ' days' AS test_subject,
    CASE
        WHEN fresh_pct >= $pass_threshold_pct THEN 'PASS'
        ELSE 'FAIL'
    END AS status,
    fresh_pct AS metric_value,
    $pass_threshold_pct AS threshold,
    total_orgs,
    fresh_orgs,
    stale_orgs,
    min_days_since,
    max_days_since,
    avg_days_since
FROM table_summary
ORDER BY status DESC, fresh_pct ASC, table_name;
