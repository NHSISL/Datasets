/*
    Investigation: Concept Mapping
    Run: Execute directly in Snowsight or VS Code Snowflake extension.
         Set the USE DATABASE below to your ICB's OLIDS database.

    For each concept field that has unmapped values, lists the distinct
    unmapped concept IDs with their row counts.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

-- Unmapped concepts per table/field with row counts
WITH unmapped AS (
    SELECT 'OBSERVATION' AS table_name, 'observation_source_concept_id' AS concept_field,
        base.observation_source_concept_id AS concept_id, COUNT(*) AS row_count
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.observation_source_concept_id = cm.source_code_id
    WHERE base.observation_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.observation_source_concept_id

    UNION ALL
    SELECT 'OBSERVATION', 'result_value_units_concept_id',
        base.result_value_units_concept_id, COUNT(*)
    FROM OLIDS_COMMON.OBSERVATION base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.result_value_units_concept_id = cm.source_code_id
    WHERE base.result_value_units_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.result_value_units_concept_id

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', 'medication_statement_source_concept_id',
        base.medication_statement_source_concept_id, COUNT(*)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.medication_statement_source_concept_id = cm.source_code_id
    WHERE base.medication_statement_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.medication_statement_source_concept_id

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', 'authorisation_type_concept_id',
        base.authorisation_type_concept_id, COUNT(*)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.authorisation_type_concept_id = cm.source_code_id
    WHERE base.authorisation_type_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.authorisation_type_concept_id

    UNION ALL
    SELECT 'MEDICATION_ORDER', 'medication_order_source_concept_id',
        base.medication_order_source_concept_id, COUNT(*)
    FROM OLIDS_COMMON.MEDICATION_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.medication_order_source_concept_id = cm.source_code_id
    WHERE base.medication_order_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.medication_order_source_concept_id

    UNION ALL
    SELECT 'DIAGNOSTIC_ORDER', 'result_value_units_concept_id',
        base.result_value_units_concept_id, COUNT(*)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.result_value_units_concept_id = cm.source_code_id
    WHERE base.result_value_units_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.result_value_units_concept_id

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', 'procedure_request_source_concept_id',
        base.procedure_request_source_concept_id, COUNT(*)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.procedure_request_source_concept_id = cm.source_code_id
    WHERE base.procedure_request_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.procedure_request_source_concept_id

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', 'status_concept_id',
        base.status_concept_id, COUNT(*)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.status_concept_id = cm.source_code_id
    WHERE base.status_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.status_concept_id

    UNION ALL
    SELECT 'REFERRAL_REQUEST', 'referral_request_priority_concept_id',
        base.referral_request_priority_concept_id, COUNT(*)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_priority_concept_id = cm.source_code_id
    WHERE base.referral_request_priority_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.referral_request_priority_concept_id

    UNION ALL
    SELECT 'REFERRAL_REQUEST', 'referral_request_type_concept_id',
        base.referral_request_type_concept_id, COUNT(*)
    FROM OLIDS_COMMON.REFERRAL_REQUEST base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.referral_request_type_concept_id = cm.source_code_id
    WHERE base.referral_request_type_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.referral_request_type_concept_id

    UNION ALL
    SELECT 'ENCOUNTER', 'encounter_source_concept_id',
        base.encounter_source_concept_id, COUNT(*)
    FROM OLIDS_COMMON.ENCOUNTER base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.encounter_source_concept_id = cm.source_code_id
    WHERE base.encounter_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.encounter_source_concept_id

    UNION ALL
    SELECT 'ALLERGY_INTOLERANCE', 'allergy_intolerance_source_concept_id',
        base.allergy_intolerance_source_concept_id, COUNT(*)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.allergy_intolerance_source_concept_id = cm.source_code_id
    WHERE base.allergy_intolerance_source_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.allergy_intolerance_source_concept_id

    UNION ALL
    SELECT 'APPOINTMENT', 'booking_method_concept_id',
        base.booking_method_concept_id, COUNT(*)
    FROM OLIDS_COMMON.APPOINTMENT base
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON base.booking_method_concept_id = cm.source_code_id
    WHERE base.booking_method_concept_id IS NOT NULL AND cm.source_code_id IS NULL
    GROUP BY base.booking_method_concept_id
)

SELECT
    table_name,
    concept_field,
    concept_id,
    row_count
FROM unmapped
ORDER BY table_name, concept_field, row_count DESC;
