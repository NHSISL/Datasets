/*
    Investigation: Data Freshness
    Run: uv run run_tests.py --run investigations/investigate_data_freshness.sql
         Or execute directly in Snowsight — set the USE DATABASE and schema
         variables below to match your ICB.

    Shows per-org, per-table freshness: last date_recorded and days since.
    Ordered by stalest first to identify which orgs are behind.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

SET freshness_days = 5;

WITH org_freshness AS (
    SELECT 'OBSERVATION' AS table_name, publisher_organisation_code AS org_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END) AS last_date_recorded,
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE) AS days_since
    FROM OLIDS_COMMON.OBSERVATION WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'ENCOUNTER', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ENCOUNTER WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'MEDICATION_ORDER', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_ORDER WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'DIAGNOSTIC_ORDER', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'ALLERGY_INTOLERANCE', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code

    UNION ALL
    SELECT 'REFERRAL_REQUEST', publisher_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.REFERRAL_REQUEST WHERE publisher_organisation_code IS NOT NULL
    GROUP BY publisher_organisation_code
)

SELECT
    table_name,
    org_code,
    last_date_recorded,
    days_since,
    CASE WHEN days_since <= $freshness_days THEN 'FRESH' ELSE 'STALE' END AS freshness_status
FROM org_freshness
WHERE last_date_recorded IS NOT NULL
ORDER BY days_since DESC, table_name, org_code;