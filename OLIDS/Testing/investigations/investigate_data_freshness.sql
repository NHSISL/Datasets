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
    SELECT 'OBSERVATION' AS table_name, record_owner_organisation_code AS org_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END) AS last_date_recorded,
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE) AS days_since
    FROM IDENTIFIER($schema_common || '.OBSERVATION') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'ENCOUNTER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.ENCOUNTER') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'MEDICATION_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'DIAGNOSTIC_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'ALLERGY_INTOLERANCE', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'REFERRAL_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST') WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code
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
