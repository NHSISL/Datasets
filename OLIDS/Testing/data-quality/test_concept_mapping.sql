/*
    Test: Concept Mapping Integrity
    Run:  uv run run_tests.py --test test_concept_mapping

    OLIDS stores coded clinical data using concept IDs. These must map through
    the terminology layer to be usable:
      concept_id -> CONCEPT_MAP.source_code_id -> CONCEPT_MAP.target_code_id -> CONCEPT.id

    How it works:
      1. The 'checks' CTE tests each concept_id column in each table.
         For each, it LEFT JOINs to CONCEPT_MAP (source lookup) and CONCEPT
         (target lookup), then counts how many distinct concept IDs fail to
         map through the full chain (missing from CONCEPT_MAP or target
         CONCEPT record doesn't exist).
      2. Only non-NULL concept values are checked (NULLs are a completeness
         issue, not a mapping issue).
      3. FAIL if any concept IDs are unmapped. The test_subject shows the
         count (e.g. "3/100 unmapped").

    Output:
      - metric_value = % of distinct concepts that ARE mapped
      - unmapped_concepts, unmapped_rows = counts (shown with --verbose)

    To add a check:
      Add a UNION ALL block joining your table's concept column through
      CONCEPT_MAP and CONCEPT. Follow the pattern below:
        LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.<concept_col> = cm.source_code_id
        LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
*/

WITH checks AS (
    -- Each block: LEFT JOIN concept column through CONCEPT_MAP -> CONCEPT,
    -- count distinct values and how many fail to map.

    -- OBSERVATION
    SELECT 'OBSERVATION' AS table_name, 'observation_source_concept_id' AS concept_field,
        COUNT(DISTINCT base.observation_source_concept_id) AS total_distinct,
        COUNT(*) AS total_rows,
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.observation_source_concept_id END) AS unmapped_concepts,
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END) AS unmapped_rows
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.observation_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.observation_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'OBSERVATION', 'result_value_units_concept_id',
        COUNT(DISTINCT base.result_value_units_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.result_value_units_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.result_value_units_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.result_value_units_concept_id IS NOT NULL

    UNION ALL

    SELECT 'OBSERVATION', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    SELECT 'OBSERVATION', 'episodicity_concept_id',
        COUNT(DISTINCT base.episodicity_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.episodicity_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.episodicity_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.episodicity_concept_id IS NOT NULL

    UNION ALL

    -- MEDICATION_STATEMENT
    SELECT 'MEDICATION_STATEMENT', 'medication_statement_source_concept_id',
        COUNT(DISTINCT base.medication_statement_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.medication_statement_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.medication_statement_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.medication_statement_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'MEDICATION_STATEMENT', 'authorisation_type_concept_id',
        COUNT(DISTINCT base.authorisation_type_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.authorisation_type_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.authorisation_type_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.authorisation_type_concept_id IS NOT NULL

    UNION ALL

    SELECT 'MEDICATION_STATEMENT', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    -- MEDICATION_ORDER
    SELECT 'MEDICATION_ORDER', 'medication_order_source_concept_id',
        COUNT(DISTINCT base.medication_order_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.medication_order_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.medication_order_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.medication_order_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'MEDICATION_ORDER', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    -- DIAGNOSTIC_ORDER
    SELECT 'DIAGNOSTIC_ORDER', 'diagnostic_order_source_concept_id',
        COUNT(DISTINCT base.diagnostic_order_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.diagnostic_order_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.diagnostic_order_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.diagnostic_order_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'DIAGNOSTIC_ORDER', 'result_value_units_concept_id',
        COUNT(DISTINCT base.result_value_units_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.result_value_units_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.result_value_units_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.result_value_units_concept_id IS NOT NULL

    UNION ALL

    SELECT 'DIAGNOSTIC_ORDER', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    SELECT 'DIAGNOSTIC_ORDER', 'episodicity_concept_id',
        COUNT(DISTINCT base.episodicity_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.episodicity_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.episodicity_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.episodicity_concept_id IS NOT NULL

    UNION ALL

    -- PROCEDURE_REQUEST
    SELECT 'PROCEDURE_REQUEST', 'procedure_request_source_concept_id',
        COUNT(DISTINCT base.procedure_request_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.procedure_request_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.procedure_request_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.procedure_request_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'PROCEDURE_REQUEST', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    SELECT 'PROCEDURE_REQUEST', 'status_concept_id',
        COUNT(DISTINCT base.status_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.status_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.status_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.status_concept_id IS NOT NULL

    UNION ALL

    -- REFERRAL_REQUEST
    SELECT 'REFERRAL_REQUEST', 'referral_request_source_concept_id',
        COUNT(DISTINCT base.referral_request_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.referral_request_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.referral_request_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'REFERRAL_REQUEST', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    SELECT 'REFERRAL_REQUEST', 'referral_request_priority_concept_id',
        COUNT(DISTINCT base.referral_request_priority_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.referral_request_priority_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_priority_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.referral_request_priority_concept_id IS NOT NULL

    UNION ALL

    SELECT 'REFERRAL_REQUEST', 'referral_request_type_concept_id',
        COUNT(DISTINCT base.referral_request_type_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.referral_request_type_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_type_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.referral_request_type_concept_id IS NOT NULL

    UNION ALL

    SELECT 'REFERRAL_REQUEST', 'referral_request_specialty_concept_id',
        COUNT(DISTINCT base.referral_request_specialty_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.referral_request_specialty_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_specialty_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.referral_request_specialty_concept_id IS NOT NULL

    UNION ALL

    -- ALLERGY_INTOLERANCE
    SELECT 'ALLERGY_INTOLERANCE', 'allergy_intolerance_source_concept_id',
        COUNT(DISTINCT base.allergy_intolerance_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.allergy_intolerance_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.allergy_intolerance_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.allergy_intolerance_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'ALLERGY_INTOLERANCE', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    -- ENCOUNTER
    SELECT 'ENCOUNTER', 'encounter_source_concept_id',
        COUNT(DISTINCT base.encounter_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.encounter_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.encounter_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.encounter_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'ENCOUNTER', 'date_precision_concept_id',
        COUNT(DISTINCT base.date_precision_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.date_precision_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.date_precision_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.date_precision_concept_id IS NOT NULL

    UNION ALL

    -- EPISODE_OF_CARE
    SELECT 'EPISODE_OF_CARE', 'episode_type_source_concept_id',
        COUNT(DISTINCT base.episode_type_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.episode_type_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.EPISODE_OF_CARE base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.episode_type_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.episode_type_source_concept_id IS NOT NULL

    UNION ALL

    SELECT 'EPISODE_OF_CARE', 'episode_status_source_concept_id',
        COUNT(DISTINCT base.episode_status_source_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.episode_status_source_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.EPISODE_OF_CARE base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.episode_status_source_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.episode_status_source_concept_id IS NOT NULL

    UNION ALL

    -- LOCATION_CONTACT
    SELECT 'LOCATION_CONTACT', 'contact_type_concept_id',
        COUNT(DISTINCT base.contact_type_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.contact_type_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.LOCATION_CONTACT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.contact_type_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.contact_type_concept_id IS NOT NULL

    UNION ALL

    -- APPOINTMENT
    SELECT 'APPOINTMENT', 'appointment_status_concept_id',
        COUNT(DISTINCT base.appointment_status_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.appointment_status_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.appointment_status_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.appointment_status_concept_id IS NOT NULL

    UNION ALL

    SELECT 'APPOINTMENT', 'booking_method_concept_id',
        COUNT(DISTINCT base.booking_method_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.booking_method_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.booking_method_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.booking_method_concept_id IS NOT NULL

    UNION ALL

    SELECT 'APPOINTMENT', 'contact_mode_concept_id',
        COUNT(DISTINCT base.contact_mode_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.contact_mode_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.contact_mode_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.contact_mode_concept_id IS NOT NULL

    UNION ALL

    -- PATIENT (OLIDS_MASKED)
    SELECT 'PATIENT', 'gender_concept_id',
        COUNT(DISTINCT base.gender_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.gender_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.gender_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.gender_concept_id IS NOT NULL

    UNION ALL

    -- PATIENT_ADDRESS (OLIDS_MASKED)
    SELECT 'PATIENT_ADDRESS', 'address_type_concept_id',
        COUNT(DISTINCT base.address_type_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.address_type_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT_ADDRESS base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.address_type_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.address_type_concept_id IS NOT NULL

    UNION ALL

    -- PATIENT_CONTACT (OLIDS_MASKED)
    SELECT 'PATIENT_CONTACT', 'contact_type_concept_id',
        COUNT(DISTINCT base.contact_type_concept_id), COUNT(*),
        COUNT(DISTINCT CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN base.contact_type_concept_id END),
        SUM(CASE WHEN (cm.source_code_id IS NULL OR c.id IS NULL) THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT_CONTACT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.contact_type_concept_id = cm.source_code_id
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT c ON cm.target_code_id = c.id
    WHERE base.contact_type_concept_id IS NOT NULL
)

-- Compute mapping % per concept field
SELECT
    'concept_mapping' AS test_name,
    table_name,
    concept_field || ' (' || unmapped_concepts || '/' || total_distinct || ' unmapped)' AS test_subject,
    CASE
        WHEN unmapped_concepts = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status,
    ROUND(100.0 * (total_distinct - unmapped_concepts) / NULLIF(total_distinct, 0), 4) AS metric_value,
    100.0 AS threshold,
    total_distinct,
    total_rows,
    unmapped_concepts,
    unmapped_rows
FROM checks
ORDER BY status DESC, metric_value ASC, table_name, concept_field;
