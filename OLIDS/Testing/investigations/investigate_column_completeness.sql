/*
    Investigation: Column Completeness
    Run: uv run run_tests.py --run investigations/investigate_column_completeness.sql
         Or execute directly in Snowsight — set the USE DATABASE and schema
         variables below to match your ICB.

    Shows NULL counts and rates for every checked column,
    ordered by null rate descending to highlight problem areas.
    Includes total_rows so you can gauge table size.

    Thresholds: 0.0% PKs, 0.5% core FKs, 1.0% dates, 5.0% concept fields
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

WITH checks AS (
    -- PATIENT (OLIDS_MASKED)
    SELECT 'PATIENT' AS table_name, 'id' AS column_name, 0.0 AS threshold, COUNT(*) AS total_rows, SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_count FROM IDENTIFIER($schema_masked || '.PATIENT')
    UNION ALL SELECT 'PATIENT', 'sk_patient_id', 0.5, COUNT(*), SUM(CASE WHEN sk_patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT')
    UNION ALL SELECT 'PATIENT', 'birth_year', 1.0, COUNT(*), SUM(CASE WHEN birth_year IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT')
    UNION ALL SELECT 'PATIENT', 'birth_month', 1.0, COUNT(*), SUM(CASE WHEN birth_month IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT')
    UNION ALL SELECT 'PATIENT', 'gender_concept_id', 5.0, COUNT(*), SUM(CASE WHEN gender_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT')
    UNION ALL SELECT 'PATIENT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT')

    -- PERSON (OLIDS_MASKED)
    UNION ALL SELECT 'PERSON', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PERSON')
    UNION ALL SELECT 'PERSON', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PERSON')

    -- PATIENT_ADDRESS (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_ADDRESS', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_ADDRESS')
    UNION ALL SELECT 'PATIENT_ADDRESS', 'address_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN address_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_ADDRESS')
    UNION ALL SELECT 'PATIENT_ADDRESS', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_ADDRESS')

    -- PATIENT_CONTACT (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_CONTACT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_CONTACT')
    UNION ALL SELECT 'PATIENT_CONTACT', 'contact_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN contact_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_CONTACT')
    UNION ALL SELECT 'PATIENT_CONTACT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_CONTACT')

    -- PATIENT_UPRN (OLIDS_MASKED)
    UNION ALL SELECT 'PATIENT_UPRN', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_UPRN')
    UNION ALL SELECT 'PATIENT_UPRN', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_masked || '.PATIENT_UPRN')

    -- PATIENT_PERSON (OLIDS_COMMON)
    UNION ALL SELECT 'PATIENT_PERSON', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PATIENT_PERSON')
    UNION ALL SELECT 'PATIENT_PERSON', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PATIENT_PERSON')

    -- EPISODE_OF_CARE (OLIDS_COMMON)
    UNION ALL SELECT 'EPISODE_OF_CARE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_of_care_start_date', 1.0, COUNT(*), SUM(CASE WHEN episode_of_care_start_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_type_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episode_type_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')
    UNION ALL SELECT 'EPISODE_OF_CARE', 'episode_status_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episode_status_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.EPISODE_OF_CARE')

    -- OBSERVATION (OLIDS_COMMON)
    UNION ALL SELECT 'OBSERVATION', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'observation_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN observation_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'result_value_units_concept_id', 5.0, COUNT(*), SUM(CASE WHEN result_value_units_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')
    UNION ALL SELECT 'OBSERVATION', 'episodicity_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episodicity_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.OBSERVATION')

    -- MEDICATION_STATEMENT (OLIDS_COMMON)
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'medication_statement_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN medication_statement_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'authorisation_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN authorisation_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')
    UNION ALL SELECT 'MEDICATION_STATEMENT', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_STATEMENT')

    -- MEDICATION_ORDER (OLIDS_COMMON)
    UNION ALL SELECT 'MEDICATION_ORDER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'medication_order_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN medication_order_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')
    UNION ALL SELECT 'MEDICATION_ORDER', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.MEDICATION_ORDER')

    -- DIAGNOSTIC_ORDER (OLIDS_COMMON)
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'diagnostic_order_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN diagnostic_order_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'result_value_units_concept_id', 5.0, COUNT(*), SUM(CASE WHEN result_value_units_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')
    UNION ALL SELECT 'DIAGNOSTIC_ORDER', 'episodicity_concept_id', 5.0, COUNT(*), SUM(CASE WHEN episodicity_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.DIAGNOSTIC_ORDER')

    -- ENCOUNTER (OLIDS_COMMON)
    UNION ALL SELECT 'ENCOUNTER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'encounter_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN encounter_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')
    UNION ALL SELECT 'ENCOUNTER', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ENCOUNTER')

    -- ALLERGY_INTOLERANCE (OLIDS_COMMON)
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'patient_id', 0.5, COUNT(*), SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'person_id', 0.5, COUNT(*), SUM(CASE WHEN person_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'allergy_intolerance_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN allergy_intolerance_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')
    UNION ALL SELECT 'ALLERGY_INTOLERANCE', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ALLERGY_INTOLERANCE')

    -- PROCEDURE_REQUEST (OLIDS_COMMON)
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'procedure_request_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN procedure_request_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')
    UNION ALL SELECT 'PROCEDURE_REQUEST', 'status_concept_id', 5.0, COUNT(*), SUM(CASE WHEN status_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PROCEDURE_REQUEST')

    -- REFERRAL_REQUEST (OLIDS_COMMON)
    UNION ALL SELECT 'REFERRAL_REQUEST', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'clinical_effective_date', 1.0, COUNT(*), SUM(CASE WHEN clinical_effective_date IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'referral_request_source_concept_id', 5.0, COUNT(*), SUM(CASE WHEN referral_request_source_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'date_precision_concept_id', 5.0, COUNT(*), SUM(CASE WHEN date_precision_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'referral_request_priority_concept_id', 5.0, COUNT(*), SUM(CASE WHEN referral_request_priority_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'referral_request_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN referral_request_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')
    UNION ALL SELECT 'REFERRAL_REQUEST', 'referral_request_specialty_concept_id', 5.0, COUNT(*), SUM(CASE WHEN referral_request_specialty_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.REFERRAL_REQUEST')

    -- LOCATION_CONTACT (OLIDS_COMMON)
    UNION ALL SELECT 'LOCATION_CONTACT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.LOCATION_CONTACT')
    UNION ALL SELECT 'LOCATION_CONTACT', 'contact_type_concept_id', 5.0, COUNT(*), SUM(CASE WHEN contact_type_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.LOCATION_CONTACT')
    UNION ALL SELECT 'LOCATION_CONTACT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.LOCATION_CONTACT')

    -- APPOINTMENT (OLIDS_COMMON)
    UNION ALL SELECT 'APPOINTMENT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT')
    UNION ALL SELECT 'APPOINTMENT', 'appointment_status_concept_id', 5.0, COUNT(*), SUM(CASE WHEN appointment_status_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT')
    UNION ALL SELECT 'APPOINTMENT', 'booking_method_concept_id', 5.0, COUNT(*), SUM(CASE WHEN booking_method_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT')
    UNION ALL SELECT 'APPOINTMENT', 'contact_mode_concept_id', 5.0, COUNT(*), SUM(CASE WHEN contact_mode_concept_id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT')
    UNION ALL SELECT 'APPOINTMENT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT')

    -- APPOINTMENT_PRACTITIONER (OLIDS_COMMON)
    UNION ALL SELECT 'APPOINTMENT_PRACTITIONER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT_PRACTITIONER')
    UNION ALL SELECT 'APPOINTMENT_PRACTITIONER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.APPOINTMENT_PRACTITIONER')

    -- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE (OLIDS_COMMON)
    UNION ALL SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE')
    UNION ALL SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE')

    -- LOCATION (OLIDS_COMMON)
    UNION ALL SELECT 'LOCATION', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.LOCATION')
    UNION ALL SELECT 'LOCATION', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.LOCATION')

    -- FLAG (OLIDS_COMMON)
    UNION ALL SELECT 'FLAG', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.FLAG')
    UNION ALL SELECT 'FLAG', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.FLAG')

    -- ORGANISATION (OLIDS_COMMON)
    UNION ALL SELECT 'ORGANISATION', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ORGANISATION')
    UNION ALL SELECT 'ORGANISATION', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.ORGANISATION')

    -- PRACTITIONER (OLIDS_COMMON)
    UNION ALL SELECT 'PRACTITIONER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PRACTITIONER')
    UNION ALL SELECT 'PRACTITIONER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PRACTITIONER')

    -- PRACTITIONER_IN_ROLE (OLIDS_COMMON)
    UNION ALL SELECT 'PRACTITIONER_IN_ROLE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PRACTITIONER_IN_ROLE')
    UNION ALL SELECT 'PRACTITIONER_IN_ROLE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.PRACTITIONER_IN_ROLE')

    -- SCHEDULE (OLIDS_COMMON)
    UNION ALL SELECT 'SCHEDULE', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.SCHEDULE')
    UNION ALL SELECT 'SCHEDULE', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.SCHEDULE')

    -- SCHEDULE_PRACTITIONER (OLIDS_COMMON)
    UNION ALL SELECT 'SCHEDULE_PRACTITIONER', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.SCHEDULE_PRACTITIONER')
    UNION ALL SELECT 'SCHEDULE_PRACTITIONER', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_common || '.SCHEDULE_PRACTITIONER')

    -- CONCEPT (OLIDS_TERMINOLOGY)
    UNION ALL SELECT 'CONCEPT', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_terminology || '.CONCEPT')
    UNION ALL SELECT 'CONCEPT', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_terminology || '.CONCEPT')

    -- CONCEPT_MAP (OLIDS_TERMINOLOGY)
    UNION ALL SELECT 'CONCEPT_MAP', 'id', 0.0, COUNT(*), SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_terminology || '.CONCEPT_MAP')
    UNION ALL SELECT 'CONCEPT_MAP', 'lds_start_date_time', 1.0, COUNT(*), SUM(CASE WHEN lds_start_date_time IS NULL THEN 1 ELSE 0 END) FROM IDENTIFIER($schema_terminology || '.CONCEPT_MAP')
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
