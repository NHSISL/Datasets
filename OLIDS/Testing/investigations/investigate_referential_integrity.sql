/*
    Investigation: Referential Integrity
    Run: uv run run_tests.py --run investigations/investigate_referential_integrity.sql
         Or execute directly in Snowsight — set the USE DATABASE and schema
         variables below to match your ICB.

    For each FK relationship, shows orphaned FK values
    with their row counts. Helps identify whether orphans are
    systematic (few IDs, many rows) or scattered.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

-- ALLERGY_INTOLERANCE -> PATIENT
SELECT 'ALLERGY_INTOLERANCE' AS child_table, 'patient_id' AS fk_column, 'PATIENT' AS parent_table,
    c.patient_id AS orphaned_value, COUNT(*) AS row_count
FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- ALLERGY_INTOLERANCE -> PERSON
SELECT 'ALLERGY_INTOLERANCE', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- ALLERGY_INTOLERANCE -> ENCOUNTER
SELECT 'ALLERGY_INTOLERANCE', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- ALLERGY_INTOLERANCE -> PRACTITIONER
SELECT 'ALLERGY_INTOLERANCE', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- APPOINTMENT -> PATIENT
SELECT 'APPOINTMENT', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- APPOINTMENT -> PRACTITIONER_IN_ROLE
SELECT 'APPOINTMENT', 'practitioner_in_role_id', 'PRACTITIONER_IN_ROLE',
    c.practitioner_in_role_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT c
LEFT JOIN OLIDS_COMMON.PRACTITIONER_IN_ROLE p ON c.practitioner_in_role_id = p.id
WHERE c.practitioner_in_role_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_in_role_id

UNION ALL

-- APPOINTMENT -> SCHEDULE
SELECT 'APPOINTMENT', 'schedule_id', 'SCHEDULE',
    c.schedule_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT c
LEFT JOIN OLIDS_COMMON.SCHEDULE p ON c.schedule_id = p.id
WHERE c.schedule_id IS NOT NULL AND p.id IS NULL
GROUP BY c.schedule_id

UNION ALL

-- APPOINTMENT_PRACTITIONER -> APPOINTMENT
SELECT 'APPOINTMENT_PRACTITIONER', 'appointment_id', 'APPOINTMENT',
    c.appointment_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT_PRACTITIONER c
LEFT JOIN OLIDS_COMMON.APPOINTMENT p ON c.appointment_id = p.id
WHERE c.appointment_id IS NOT NULL AND p.id IS NULL
GROUP BY c.appointment_id

UNION ALL

-- APPOINTMENT_PRACTITIONER -> PRACTITIONER
SELECT 'APPOINTMENT_PRACTITIONER', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT_PRACTITIONER c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- DIAGNOSTIC_ORDER -> PATIENT
SELECT 'DIAGNOSTIC_ORDER', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- DIAGNOSTIC_ORDER -> PERSON
SELECT 'DIAGNOSTIC_ORDER', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- DIAGNOSTIC_ORDER -> ENCOUNTER
SELECT 'DIAGNOSTIC_ORDER', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- DIAGNOSTIC_ORDER -> PRACTITIONER
SELECT 'DIAGNOSTIC_ORDER', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- DIAGNOSTIC_ORDER -> OBSERVATION (parent)
SELECT 'DIAGNOSTIC_ORDER', 'parent_observation_id', 'OBSERVATION',
    c.parent_observation_id, COUNT(*)
FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.parent_observation_id = p.id
WHERE c.parent_observation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.parent_observation_id

UNION ALL

-- ENCOUNTER -> PATIENT
SELECT 'ENCOUNTER', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- ENCOUNTER -> PERSON
SELECT 'ENCOUNTER', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- ENCOUNTER -> PRACTITIONER
SELECT 'ENCOUNTER', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- ENCOUNTER -> EPISODE_OF_CARE
SELECT 'ENCOUNTER', 'episode_of_care_id', 'EPISODE_OF_CARE',
    c.episode_of_care_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_COMMON.EPISODE_OF_CARE p ON c.episode_of_care_id = p.id
WHERE c.episode_of_care_id IS NOT NULL AND p.id IS NULL
GROUP BY c.episode_of_care_id

UNION ALL

-- ENCOUNTER -> APPOINTMENT
SELECT 'ENCOUNTER', 'appointment_id', 'APPOINTMENT',
    c.appointment_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_COMMON.APPOINTMENT p ON c.appointment_id = p.id
WHERE c.appointment_id IS NOT NULL AND p.id IS NULL
GROUP BY c.appointment_id

UNION ALL

-- ENCOUNTER -> ORGANISATION (service provider)
SELECT 'ENCOUNTER', 'service_provider_organisation_id', 'ORGANISATION',
    c.service_provider_organisation_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.service_provider_organisation_id = p.id
WHERE c.service_provider_organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.service_provider_organisation_id

UNION ALL

-- EPISODE_OF_CARE -> PATIENT
SELECT 'EPISODE_OF_CARE', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- EPISODE_OF_CARE -> PERSON
SELECT 'EPISODE_OF_CARE', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- EPISODE_OF_CARE -> PRACTITIONER (care manager)
SELECT 'EPISODE_OF_CARE', 'care_manager_practitioner_id', 'PRACTITIONER',
    c.care_manager_practitioner_id, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.care_manager_practitioner_id = p.id
WHERE c.care_manager_practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.care_manager_practitioner_id

UNION ALL

-- EPISODE_OF_CARE -> ORGANISATION (publisher)
SELECT 'EPISODE_OF_CARE', 'organisation_id_publisher', 'ORGANISATION',
    c.organisation_id_publisher, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id_publisher = p.id
WHERE c.organisation_id_publisher IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id_publisher

UNION ALL

-- EPISODE_OF_CARE -> ORGANISATION (managing)
SELECT 'EPISODE_OF_CARE', 'organisation_id_managing', 'ORGANISATION',
    c.organisation_id_managing, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id_managing = p.id
WHERE c.organisation_id_managing IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id_managing

UNION ALL

-- FLAG -> PATIENT
SELECT 'FLAG', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.FLAG c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- LOCATION -> ORGANISATION (managing)
SELECT 'LOCATION', 'managing_organisation_id', 'ORGANISATION',
    c.managing_organisation_id, COUNT(*)
FROM OLIDS_COMMON.LOCATION c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.managing_organisation_id = p.id
WHERE c.managing_organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.managing_organisation_id

UNION ALL

-- LOCATION_CONTACT -> LOCATION
SELECT 'LOCATION_CONTACT', 'location_id', 'LOCATION',
    c.location_id, COUNT(*)
FROM OLIDS_COMMON.LOCATION_CONTACT c
LEFT JOIN OLIDS_COMMON.LOCATION p ON c.location_id = p.id
WHERE c.location_id IS NOT NULL AND p.id IS NULL
GROUP BY c.location_id

UNION ALL

-- MEDICATION_ORDER -> PATIENT
SELECT 'MEDICATION_ORDER', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- MEDICATION_ORDER -> PERSON
SELECT 'MEDICATION_ORDER', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- MEDICATION_ORDER -> MEDICATION_STATEMENT
SELECT 'MEDICATION_ORDER', 'medication_statement_id', 'MEDICATION_STATEMENT',
    c.medication_statement_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.MEDICATION_STATEMENT p ON c.medication_statement_id = p.id
WHERE c.medication_statement_id IS NOT NULL AND p.id IS NULL
GROUP BY c.medication_statement_id

UNION ALL

-- MEDICATION_ORDER -> ORGANISATION
SELECT 'MEDICATION_ORDER', 'organisation_id', 'ORGANISATION',
    c.organisation_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id
WHERE c.organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id

UNION ALL

-- MEDICATION_ORDER -> ENCOUNTER
SELECT 'MEDICATION_ORDER', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- MEDICATION_ORDER -> PRACTITIONER
SELECT 'MEDICATION_ORDER', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- MEDICATION_ORDER -> OBSERVATION
SELECT 'MEDICATION_ORDER', 'observation_id', 'OBSERVATION',
    c.observation_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.observation_id = p.id
WHERE c.observation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.observation_id

UNION ALL

-- MEDICATION_ORDER -> ALLERGY_INTOLERANCE
SELECT 'MEDICATION_ORDER', 'allergy_intolerance_id', 'ALLERGY_INTOLERANCE',
    c.allergy_intolerance_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.ALLERGY_INTOLERANCE p ON c.allergy_intolerance_id = p.id
WHERE c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL
GROUP BY c.allergy_intolerance_id

UNION ALL

-- MEDICATION_ORDER -> DIAGNOSTIC_ORDER
SELECT 'MEDICATION_ORDER', 'diagnostic_order_id', 'DIAGNOSTIC_ORDER',
    c.diagnostic_order_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.DIAGNOSTIC_ORDER p ON c.diagnostic_order_id = p.id
WHERE c.diagnostic_order_id IS NOT NULL AND p.id IS NULL
GROUP BY c.diagnostic_order_id

UNION ALL

-- MEDICATION_ORDER -> REFERRAL_REQUEST
SELECT 'MEDICATION_ORDER', 'referral_request_id', 'REFERRAL_REQUEST',
    c.referral_request_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.REFERRAL_REQUEST p ON c.referral_request_id = p.id
WHERE c.referral_request_id IS NOT NULL AND p.id IS NULL
GROUP BY c.referral_request_id

UNION ALL

-- MEDICATION_STATEMENT -> PATIENT
SELECT 'MEDICATION_STATEMENT', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- MEDICATION_STATEMENT -> PERSON
SELECT 'MEDICATION_STATEMENT', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- MEDICATION_STATEMENT -> ORGANISATION
SELECT 'MEDICATION_STATEMENT', 'organisation_id', 'ORGANISATION',
    c.organisation_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id
WHERE c.organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id

UNION ALL

-- MEDICATION_STATEMENT -> ENCOUNTER
SELECT 'MEDICATION_STATEMENT', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- MEDICATION_STATEMENT -> PRACTITIONER
SELECT 'MEDICATION_STATEMENT', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- MEDICATION_STATEMENT -> OBSERVATION
SELECT 'MEDICATION_STATEMENT', 'observation_id', 'OBSERVATION',
    c.observation_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.observation_id = p.id
WHERE c.observation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.observation_id

UNION ALL

-- MEDICATION_STATEMENT -> ALLERGY_INTOLERANCE
SELECT 'MEDICATION_STATEMENT', 'allergy_intolerance_id', 'ALLERGY_INTOLERANCE',
    c.allergy_intolerance_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.ALLERGY_INTOLERANCE p ON c.allergy_intolerance_id = p.id
WHERE c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL
GROUP BY c.allergy_intolerance_id

UNION ALL

-- MEDICATION_STATEMENT -> DIAGNOSTIC_ORDER
SELECT 'MEDICATION_STATEMENT', 'diagnostic_order_id', 'DIAGNOSTIC_ORDER',
    c.diagnostic_order_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.DIAGNOSTIC_ORDER p ON c.diagnostic_order_id = p.id
WHERE c.diagnostic_order_id IS NOT NULL AND p.id IS NULL
GROUP BY c.diagnostic_order_id

UNION ALL

-- MEDICATION_STATEMENT -> REFERRAL_REQUEST
SELECT 'MEDICATION_STATEMENT', 'referral_request_id', 'REFERRAL_REQUEST',
    c.referral_request_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_COMMON.REFERRAL_REQUEST p ON c.referral_request_id = p.id
WHERE c.referral_request_id IS NOT NULL AND p.id IS NULL
GROUP BY c.referral_request_id

UNION ALL

-- OBSERVATION -> PATIENT
SELECT 'OBSERVATION', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- OBSERVATION -> PERSON
SELECT 'OBSERVATION', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- OBSERVATION -> ENCOUNTER
SELECT 'OBSERVATION', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- OBSERVATION -> PRACTITIONER
SELECT 'OBSERVATION', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- OBSERVATION -> OBSERVATION (parent)
SELECT 'OBSERVATION', 'parent_observation_id', 'OBSERVATION',
    c.parent_observation_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.parent_observation_id = p.id
WHERE c.parent_observation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.parent_observation_id

UNION ALL

-- ORGANISATION -> ORGANISATION (parent)
SELECT 'ORGANISATION', 'parent_organisation_id', 'ORGANISATION',
    c.parent_organisation_id, COUNT(*)
FROM OLIDS_COMMON.ORGANISATION c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.parent_organisation_id = p.id
WHERE c.parent_organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.parent_organisation_id

UNION ALL

-- PATIENT -> ORGANISATION (registered practice)
SELECT 'PATIENT', 'registered_practice_id', 'ORGANISATION',
    c.registered_practice_id, COUNT(*)
FROM OLIDS_MASKED.PATIENT c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.registered_practice_id = p.id
WHERE c.registered_practice_id IS NOT NULL AND p.id IS NULL
GROUP BY c.registered_practice_id

UNION ALL

-- PATIENT_ADDRESS -> PATIENT
SELECT 'PATIENT_ADDRESS', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_MASKED.PATIENT_ADDRESS c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- PATIENT_CONTACT -> PATIENT
SELECT 'PATIENT_CONTACT', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_MASKED.PATIENT_CONTACT c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- PATIENT_PERSON -> PATIENT
SELECT 'PATIENT_PERSON', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_PERSON c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- PATIENT_PERSON -> PERSON
SELECT 'PATIENT_PERSON', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_PERSON c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> PATIENT
SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> ORGANISATION
SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'organisation_id', 'ORGANISATION',
    c.organisation_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id
WHERE c.organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id

UNION ALL

-- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> PRACTITIONER
SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> EPISODE_OF_CARE
SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'episode_of_care_id', 'EPISODE_OF_CARE',
    c.episode_of_care_id, COUNT(*)
FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_COMMON.EPISODE_OF_CARE p ON c.episode_of_care_id = p.id
WHERE c.episode_of_care_id IS NOT NULL AND p.id IS NULL
GROUP BY c.episode_of_care_id

UNION ALL

-- PRACTITIONER_IN_ROLE -> PRACTITIONER
SELECT 'PRACTITIONER_IN_ROLE', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- PRACTITIONER_IN_ROLE -> ORGANISATION
SELECT 'PRACTITIONER_IN_ROLE', 'organisation_id', 'ORGANISATION',
    c.organisation_id, COUNT(*)
FROM OLIDS_COMMON.PRACTITIONER_IN_ROLE c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id
WHERE c.organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id

UNION ALL

-- PROCEDURE_REQUEST -> PATIENT
SELECT 'PROCEDURE_REQUEST', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.PROCEDURE_REQUEST c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- PROCEDURE_REQUEST -> ENCOUNTER
SELECT 'PROCEDURE_REQUEST', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.PROCEDURE_REQUEST c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- PROCEDURE_REQUEST -> PRACTITIONER
SELECT 'PROCEDURE_REQUEST', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.PROCEDURE_REQUEST c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- REFERRAL_REQUEST -> PATIENT
SELECT 'REFERRAL_REQUEST', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- REFERRAL_REQUEST -> ENCOUNTER
SELECT 'REFERRAL_REQUEST', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- REFERRAL_REQUEST -> PRACTITIONER
SELECT 'REFERRAL_REQUEST', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- REFERRAL_REQUEST -> ORGANISATION
SELECT 'REFERRAL_REQUEST', 'organisation_id', 'ORGANISATION',
    c.organisation_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id
WHERE c.organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.organisation_id

UNION ALL

-- REFERRAL_REQUEST -> ORGANISATION (requester)
SELECT 'REFERRAL_REQUEST', 'requester_organisation_id', 'ORGANISATION',
    c.requester_organisation_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.requester_organisation_id = p.id
WHERE c.requester_organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.requester_organisation_id

UNION ALL

-- REFERRAL_REQUEST -> ORGANISATION (recipient)
SELECT 'REFERRAL_REQUEST', 'recipient_organisation_id', 'ORGANISATION',
    c.recipient_organisation_id, COUNT(*)
FROM OLIDS_COMMON.REFERRAL_REQUEST c
LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.recipient_organisation_id = p.id
WHERE c.recipient_organisation_id IS NOT NULL AND p.id IS NULL
GROUP BY c.recipient_organisation_id

UNION ALL

-- SCHEDULE -> LOCATION
SELECT 'SCHEDULE', 'location_id', 'LOCATION',
    c.location_id, COUNT(*)
FROM OLIDS_COMMON.SCHEDULE c
LEFT JOIN OLIDS_COMMON.LOCATION p ON c.location_id = p.id
WHERE c.location_id IS NOT NULL AND p.id IS NULL
GROUP BY c.location_id

UNION ALL

-- SCHEDULE -> PRACTITIONER
SELECT 'SCHEDULE', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.SCHEDULE c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

UNION ALL

-- SCHEDULE_PRACTITIONER -> SCHEDULE
SELECT 'SCHEDULE_PRACTITIONER', 'schedule_id', 'SCHEDULE',
    c.schedule_id, COUNT(*)
FROM OLIDS_COMMON.SCHEDULE_PRACTITIONER c
LEFT JOIN OLIDS_COMMON.SCHEDULE p ON c.schedule_id = p.id
WHERE c.schedule_id IS NOT NULL AND p.id IS NULL
GROUP BY c.schedule_id

UNION ALL

-- SCHEDULE_PRACTITIONER -> PRACTITIONER
SELECT 'SCHEDULE_PRACTITIONER', 'practitioner_id', 'PRACTITIONER',
    c.practitioner_id, COUNT(*)
FROM OLIDS_COMMON.SCHEDULE_PRACTITIONER c
LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
WHERE c.practitioner_id IS NOT NULL AND p.id IS NULL
GROUP BY c.practitioner_id

ORDER BY child_table, fk_column, row_count DESC;
