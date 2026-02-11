/*
    Investigation: Data Freshness
    Run: Execute directly in Snowsight or VS Code Snowflake extension.
         Set the USE DATABASE below to your ICB's OLIDS database.

    Shows per-org, per-table freshness: last date_recorded and days since.
    Ordered by stalest first to identify which orgs are behind.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET freshness_days = 5;

WITH org_freshness AS (
    SELECT 'OBSERVATION' AS table_name, record_owner_organisation_code AS org_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END) AS last_date_recorded,
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE) AS days_since
    FROM OLIDS_COMMON.OBSERVATION WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'ENCOUNTER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ENCOUNTER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'MEDICATION_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_ORDER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'DIAGNOSTIC_ORDER', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'ALLERGY_INTOLERANCE', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST WHERE record_owner_organisation_code IS NOT NULL
    GROUP BY record_owner_organisation_code

    UNION ALL
    SELECT 'REFERRAL_REQUEST', record_owner_organisation_code,
        MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END),
        DATEDIFF('day', MAX(CASE WHEN date_recorded <= CURRENT_DATE THEN date_recorded END), CURRENT_DATE)
    FROM OLIDS_COMMON.REFERRAL_REQUEST WHERE record_owner_organisation_code IS NOT NULL
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
