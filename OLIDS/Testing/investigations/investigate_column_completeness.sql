/*
    Investigation: Column Completeness
    Run: Execute directly in Snowsight or VS Code Snowflake extension.
         Set the USE DATABASE below to your ICB's OLIDS database.

    Shows NULL counts and rates for every checked column,
    ordered by null rate descending to highlight problem areas.
    Includes total_rows so you can gauge table size.

    Thresholds: 0.0% PKs, 0.5% core FKs, 1.0% dates, 5.0% concept fields
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

WITH checks AS (
    -- PATIENT (OLIDS_MASKED)
    SELECT 'PATIENT' AS table_name, 'id' AS column_name, 0.0 AS threshold, COUNT(*) AS total_rows, SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_count FROM OLIDS_MASKED.PATIENT
    UNION ALL SELECT 'PATIENT', 'sk_patient_id', 0.5, COUNT(*), SUM(CASE WHEN sk_patient_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT
    UNION ALL SELECT 'PATIENT', 'birth_year', 1.0, COUNT(*), SUM(CASE WHEN birth_year IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT
    UNION ALL SELECT 'PATIENT', 'birth_month', 1.0, COUNT(*), SUM(CASE WHEN birth_month IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT
    UNION ALL SELECT 'PATIENT', 'gender_concept_id', 5.0, COUNT(*), SUM(CASE WHEN gender_concept_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT
    UNION ALL SELECT 'PATIENT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT

    -- PERSON (OLIDS_MASKED)
    UNION ALL SELECT 'PERSON', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PERSON
    UNION ALL SELECT 'PERSON', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PERSON

    -- PATIENT_ADDRESS (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_ADDRESS', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_ADDRESS
    UNION ALL SELECT 'PATIENT_ADDRESS', 'address_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN address_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_ADDRESS
    UNION ALL SELECT 'PATIENT_ADDRESS', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_ADDRESS

    -- PATIENT_CONTACT (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_CONTACT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_CONTACT
    UNION ALL SELECT 'PATIENT_CONTACT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_CONTACT

    -- PATIENT_UPRN (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_UPRN', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_UPRN
    UNION ALL SELECT 'PATIENT_UPRN', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_MASKED.PATIENT_UPRN

    -- PATIENT_PERSON (OLIDS_COMMON)
    UNION ALL SELECT 'PATIENT_PERSON', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.PATIENT_PERSON
    UNION ALL SELECT 'PATIENT_PERSON', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.PATIENT_PERSON

    -- EPISODE_OF_CARE (OLIDS_COMMON)
    UNION ALL SELECT 'EPISODE_OF_CARE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_of_care_start_date', 1.0, COUNT(*), SUM(CASE WHEN episode_of_care_start_date IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_type_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episode_type_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_status_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episode_status_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM OLIDS_COMMON.EPISODE_OF_CARE
)

SELECT
    table_name,
    column_name,
    total_rows,
    null_count,
    CASE WHEN total_rows = 0 THEN NULL ELSE ROUND(100.0 * null_count / total_rows, 4) END AS null_pct,
    threshold AS max_null_pct,
    CASE
        WHEN total_rows = 0 THEN 'EMPTY TABLE'
        WHEN ROUND(100.0 * null_count / total_rows, 4) <= threshold THEN 'PASS'
        ELSE 'FAIL'
    END AS status
FROM checks
ORDER BY null_pct DESC NULLS LAST, table_name, column_name;
