/*
    Investigation: Concept Mapping
    Run: uv run run_tests.py --run investigations/investigate_concept_mapping.sql
         Or execute directly in Snowsight — set the USE DATABASE and schema
         variables below to match your ICB.

    For each concept field that has unmapped values, lists the distinct
    unmapped concept IDs with their row counts. Checks the full chain:
    concept_id -> CONCEPT_MAP.source_code_id -> CONCEPT_MAP.target_code_id -> CONCEPT.id
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

-- Unmapped concepts per table/field with row counts
WITH unmapped AS (
    SELECT 'OBSERVATION' AS table_name, 'observation_source_concept_id' AS concept_field,
        base.observation_source_concept_id AS concept_id, COUNT(*) AS row_count,
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END AS reason
    FROM IDENTIFIER($schema_common || '.OBSERVATION') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.observation_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.observation_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.observation_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'OBSERVATION', 'result_value_units_concept_id',
        base.result_value_units_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.OBSERVATION') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.result_value_units_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.result_value_units_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.result_value_units_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', 'medication_statement_source_concept_id',
        base.medication_statement_source_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.medication_statement_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.medication_statement_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.medication_statement_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'MEDICATION_STATEMENT', 'authorisation_type_concept_id',
        base.authorisation_type_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.authorisation_type_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.authorisation_type_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.authorisation_type_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'MEDICATION_ORDER', 'medication_order_source_concept_id',
        base.medication_order_source_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.medication_order_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.medication_order_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.medication_order_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'DIAGNOSTIC_ORDER', 'result_value_units_concept_id',
        base.result_value_units_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.result_value_units_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.result_value_units_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.result_value_units_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', 'procedure_request_source_concept_id',
        base.procedure_request_source_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.procedure_request_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.procedure_request_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.procedure_request_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'PROCEDURE_REQUEST', 'status_concept_id',
        base.status_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.status_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.status_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.status_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'REFERRAL_REQUEST', 'referral_request_priority_concept_id',
        base.referral_request_priority_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.referral_request_priority_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.referral_request_priority_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.referral_request_priority_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'REFERRAL_REQUEST', 'referral_request_type_concept_id',
        base.referral_request_type_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.referral_request_type_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.referral_request_type_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.referral_request_type_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'ENCOUNTER', 'encounter_source_concept_id',
        base.encounter_source_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.ENCOUNTER') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.encounter_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.encounter_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.encounter_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'ALLERGY_INTOLERANCE', 'allergy_intolerance_source_concept_id',
        base.allergy_intolerance_source_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.allergy_intolerance_source_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.allergy_intolerance_source_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.allergy_intolerance_source_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END

    UNION ALL
    SELECT 'APPOINTMENT', 'booking_method_concept_id',
        base.booking_method_concept_id, COUNT(*),
        CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
    FROM IDENTIFIER($schema_common || '.APPOINTMENT') base
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT_MAP') cm ON base.booking_method_concept_id = cm.source_code_id
    LEFT JOIN IDENTIFIER($schema_terminology || '.CONCEPT') c ON cm.target_code_id = c.id
    WHERE base.booking_method_concept_id IS NOT NULL AND (cm.source_code_id IS NULL OR c.id IS NULL)
    GROUP BY base.booking_method_concept_id, CASE WHEN cm.source_code_id IS NULL THEN 'NOT IN CONCEPT_MAP' ELSE 'TARGET CONCEPT MISSING' END
)

SELECT
    table_name,
    concept_field,
    concept_id,
    row_count,
    reason
FROM unmapped
ORDER BY table_name, concept_field, row_count DESC;
