/*
    Test: Referential Integrity
    Run:  uv run run_tests.py --test test_referential_integrity

    OLIDS tables use foreign key columns (patient_id, encounter_id, etc.) to
    link records across tables. This test checks that every FK value points to
    an existing record in the parent table.

    How it works:
      1. The 'fk_checks' CTE has one block per FK relationship. Each block
         LEFT JOINs the child table (alias 'c') to the parent table (alias 'p')
         on the FK column, then counts how many distinct FK values have no match
         (orphaned_fk) and how many rows are affected (orphaned_rows).
      2. Only non-NULL FK values are checked (NULLs are a completeness issue).
      3. FAIL if any orphaned FK values exist (threshold = 100% integrity).

    Output:
      - metric_value = % of distinct FK values that DO have a parent record
      - total_distinct_fk, orphaned_fk, orphaned_rows (shown with --verbose)

    To add a check:
      Add a UNION ALL block with the child table LEFT JOINed to the parent.
      Use aliases 'c' (child) and 'p' (parent). Follow the pattern below.
*/

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

WITH fk_checks AS (
    -- Each block: LEFT JOIN child.fk_column to parent.id, count orphaned values.
    -- Uses 'c' for child table and 'p' for parent table throughout.

    -- ALLERGY_INTOLERANCE -> PATIENT
    SELECT 'ALLERGY_INTOLERANCE' AS child_table, 'patient_id' AS fk_column, 'PATIENT' AS parent_table,
        COUNT(DISTINCT c.patient_id) AS total_distinct_fk,
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END) AS total_rows_with_fk,
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END) AS orphaned_fk,
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END) AS orphaned_rows
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- ALLERGY_INTOLERANCE -> PERSON
    SELECT 'ALLERGY_INTOLERANCE', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- ALLERGY_INTOLERANCE -> ENCOUNTER
    SELECT 'ALLERGY_INTOLERANCE', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- ALLERGY_INTOLERANCE -> PRACTITIONER
    SELECT 'ALLERGY_INTOLERANCE', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ALLERGY_INTOLERANCE c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- APPOINTMENT -> PATIENT
    SELECT 'APPOINTMENT', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- APPOINTMENT -> PRACTITIONER_IN_ROLE
    SELECT 'APPOINTMENT', 'practitioner_in_role_id', 'PRACTITIONER_IN_ROLE',
        COUNT(DISTINCT c.practitioner_in_role_id),
        SUM(CASE WHEN c.practitioner_in_role_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_in_role_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_in_role_id END),
        SUM(CASE WHEN c.practitioner_in_role_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER_IN_ROLE p ON c.practitioner_in_role_id = p.id

    UNION ALL

    -- APPOINTMENT -> SCHEDULE
    SELECT 'APPOINTMENT', 'schedule_id', 'SCHEDULE',
        COUNT(DISTINCT c.schedule_id),
        SUM(CASE WHEN c.schedule_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.schedule_id IS NOT NULL AND p.id IS NULL THEN c.schedule_id END),
        SUM(CASE WHEN c.schedule_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT c
    LEFT JOIN OLIDS_COMMON.SCHEDULE p ON c.schedule_id = p.id

    UNION ALL

    -- APPOINTMENT_PRACTITIONER -> APPOINTMENT
    SELECT 'APPOINTMENT_PRACTITIONER', 'appointment_id', 'APPOINTMENT',
        COUNT(DISTINCT c.appointment_id),
        SUM(CASE WHEN c.appointment_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.appointment_id IS NOT NULL AND p.id IS NULL THEN c.appointment_id END),
        SUM(CASE WHEN c.appointment_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT_PRACTITIONER c
    LEFT JOIN OLIDS_COMMON.APPOINTMENT p ON c.appointment_id = p.id

    UNION ALL

    -- APPOINTMENT_PRACTITIONER -> PRACTITIONER
    SELECT 'APPOINTMENT_PRACTITIONER', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.APPOINTMENT_PRACTITIONER c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- DIAGNOSTIC_ORDER -> PATIENT
    SELECT 'DIAGNOSTIC_ORDER', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- DIAGNOSTIC_ORDER -> PERSON
    SELECT 'DIAGNOSTIC_ORDER', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- DIAGNOSTIC_ORDER -> ENCOUNTER
    SELECT 'DIAGNOSTIC_ORDER', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- DIAGNOSTIC_ORDER -> PRACTITIONER
    SELECT 'DIAGNOSTIC_ORDER', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- DIAGNOSTIC_ORDER -> OBSERVATION (parent)
    SELECT 'DIAGNOSTIC_ORDER', 'parent_observation_id', 'OBSERVATION',
        COUNT(DISTINCT c.parent_observation_id),
        SUM(CASE WHEN c.parent_observation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.parent_observation_id IS NOT NULL AND p.id IS NULL THEN c.parent_observation_id END),
        SUM(CASE WHEN c.parent_observation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.DIAGNOSTIC_ORDER c
    LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.parent_observation_id = p.id

    UNION ALL

    -- ENCOUNTER -> PATIENT
    SELECT 'ENCOUNTER', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- ENCOUNTER -> PERSON
    SELECT 'ENCOUNTER', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- ENCOUNTER -> PRACTITIONER
    SELECT 'ENCOUNTER', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- ENCOUNTER -> EPISODE_OF_CARE
    SELECT 'ENCOUNTER', 'episode_of_care_id', 'EPISODE_OF_CARE',
        COUNT(DISTINCT c.episode_of_care_id),
        SUM(CASE WHEN c.episode_of_care_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.episode_of_care_id IS NOT NULL AND p.id IS NULL THEN c.episode_of_care_id END),
        SUM(CASE WHEN c.episode_of_care_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_COMMON.EPISODE_OF_CARE p ON c.episode_of_care_id = p.id

    UNION ALL

    -- ENCOUNTER -> APPOINTMENT
    SELECT 'ENCOUNTER', 'appointment_id', 'APPOINTMENT',
        COUNT(DISTINCT c.appointment_id),
        SUM(CASE WHEN c.appointment_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.appointment_id IS NOT NULL AND p.id IS NULL THEN c.appointment_id END),
        SUM(CASE WHEN c.appointment_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_COMMON.APPOINTMENT p ON c.appointment_id = p.id

    UNION ALL

    -- ENCOUNTER -> ORGANISATION (service provider)
    SELECT 'ENCOUNTER', 'service_provider_organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.service_provider_organisation_id),
        SUM(CASE WHEN c.service_provider_organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.service_provider_organisation_id IS NOT NULL AND p.id IS NULL THEN c.service_provider_organisation_id END),
        SUM(CASE WHEN c.service_provider_organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ENCOUNTER c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.service_provider_organisation_id = p.id

    UNION ALL

    -- EPISODE_OF_CARE -> PATIENT
    SELECT 'EPISODE_OF_CARE', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.EPISODE_OF_CARE c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- EPISODE_OF_CARE -> PERSON
    SELECT 'EPISODE_OF_CARE', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.EPISODE_OF_CARE c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- EPISODE_OF_CARE -> PRACTITIONER (care manager)
    SELECT 'EPISODE_OF_CARE', 'care_manager_practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.care_manager_practitioner_id),
        SUM(CASE WHEN c.care_manager_practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.care_manager_practitioner_id IS NOT NULL AND p.id IS NULL THEN c.care_manager_practitioner_id END),
        SUM(CASE WHEN c.care_manager_practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.EPISODE_OF_CARE c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.care_manager_practitioner_id = p.id

    UNION ALL

    -- FLAG -> PATIENT
    SELECT 'FLAG', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.FLAG c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- LOCATION -> ORGANISATION (managing)
    SELECT 'LOCATION', 'managing_organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.managing_organisation_id),
        SUM(CASE WHEN c.managing_organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.managing_organisation_id IS NOT NULL AND p.id IS NULL THEN c.managing_organisation_id END),
        SUM(CASE WHEN c.managing_organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.LOCATION c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.managing_organisation_id = p.id

    UNION ALL

    -- LOCATION_CONTACT -> LOCATION
    SELECT 'LOCATION_CONTACT', 'location_id', 'LOCATION',
        COUNT(DISTINCT c.location_id),
        SUM(CASE WHEN c.location_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.location_id IS NOT NULL AND p.id IS NULL THEN c.location_id END),
        SUM(CASE WHEN c.location_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.LOCATION_CONTACT c
    LEFT JOIN OLIDS_COMMON.LOCATION p ON c.location_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> PATIENT
    SELECT 'MEDICATION_ORDER', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> PERSON
    SELECT 'MEDICATION_ORDER', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> MEDICATION_STATEMENT
    SELECT 'MEDICATION_ORDER', 'medication_statement_id', 'MEDICATION_STATEMENT',
        COUNT(DISTINCT c.medication_statement_id),
        SUM(CASE WHEN c.medication_statement_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.medication_statement_id IS NOT NULL AND p.id IS NULL THEN c.medication_statement_id END),
        SUM(CASE WHEN c.medication_statement_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.MEDICATION_STATEMENT p ON c.medication_statement_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> ORGANISATION
    SELECT 'MEDICATION_ORDER', 'organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.organisation_id),
        SUM(CASE WHEN c.organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN c.organisation_id END),
        SUM(CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> ENCOUNTER
    SELECT 'MEDICATION_ORDER', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> PRACTITIONER
    SELECT 'MEDICATION_ORDER', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> OBSERVATION
    SELECT 'MEDICATION_ORDER', 'observation_id', 'OBSERVATION',
        COUNT(DISTINCT c.observation_id),
        SUM(CASE WHEN c.observation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.observation_id IS NOT NULL AND p.id IS NULL THEN c.observation_id END),
        SUM(CASE WHEN c.observation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.observation_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> ALLERGY_INTOLERANCE
    SELECT 'MEDICATION_ORDER', 'allergy_intolerance_id', 'ALLERGY_INTOLERANCE',
        COUNT(DISTINCT c.allergy_intolerance_id),
        SUM(CASE WHEN c.allergy_intolerance_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL THEN c.allergy_intolerance_id END),
        SUM(CASE WHEN c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.ALLERGY_INTOLERANCE p ON c.allergy_intolerance_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> DIAGNOSTIC_ORDER
    SELECT 'MEDICATION_ORDER', 'diagnostic_order_id', 'DIAGNOSTIC_ORDER',
        COUNT(DISTINCT c.diagnostic_order_id),
        SUM(CASE WHEN c.diagnostic_order_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.diagnostic_order_id IS NOT NULL AND p.id IS NULL THEN c.diagnostic_order_id END),
        SUM(CASE WHEN c.diagnostic_order_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.DIAGNOSTIC_ORDER p ON c.diagnostic_order_id = p.id

    UNION ALL

    -- MEDICATION_ORDER -> REFERRAL_REQUEST
    SELECT 'MEDICATION_ORDER', 'referral_request_id', 'REFERRAL_REQUEST',
        COUNT(DISTINCT c.referral_request_id),
        SUM(CASE WHEN c.referral_request_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.referral_request_id IS NOT NULL AND p.id IS NULL THEN c.referral_request_id END),
        SUM(CASE WHEN c.referral_request_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_ORDER c
    LEFT JOIN OLIDS_COMMON.REFERRAL_REQUEST p ON c.referral_request_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> PATIENT
    SELECT 'MEDICATION_STATEMENT', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> PERSON
    SELECT 'MEDICATION_STATEMENT', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> ORGANISATION
    SELECT 'MEDICATION_STATEMENT', 'organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.organisation_id),
        SUM(CASE WHEN c.organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN c.organisation_id END),
        SUM(CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> ENCOUNTER
    SELECT 'MEDICATION_STATEMENT', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> PRACTITIONER
    SELECT 'MEDICATION_STATEMENT', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> OBSERVATION
    SELECT 'MEDICATION_STATEMENT', 'observation_id', 'OBSERVATION',
        COUNT(DISTINCT c.observation_id),
        SUM(CASE WHEN c.observation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.observation_id IS NOT NULL AND p.id IS NULL THEN c.observation_id END),
        SUM(CASE WHEN c.observation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.observation_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> ALLERGY_INTOLERANCE
    SELECT 'MEDICATION_STATEMENT', 'allergy_intolerance_id', 'ALLERGY_INTOLERANCE',
        COUNT(DISTINCT c.allergy_intolerance_id),
        SUM(CASE WHEN c.allergy_intolerance_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL THEN c.allergy_intolerance_id END),
        SUM(CASE WHEN c.allergy_intolerance_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.ALLERGY_INTOLERANCE p ON c.allergy_intolerance_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> DIAGNOSTIC_ORDER
    SELECT 'MEDICATION_STATEMENT', 'diagnostic_order_id', 'DIAGNOSTIC_ORDER',
        COUNT(DISTINCT c.diagnostic_order_id),
        SUM(CASE WHEN c.diagnostic_order_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.diagnostic_order_id IS NOT NULL AND p.id IS NULL THEN c.diagnostic_order_id END),
        SUM(CASE WHEN c.diagnostic_order_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.DIAGNOSTIC_ORDER p ON c.diagnostic_order_id = p.id

    UNION ALL

    -- MEDICATION_STATEMENT -> REFERRAL_REQUEST
    SELECT 'MEDICATION_STATEMENT', 'referral_request_id', 'REFERRAL_REQUEST',
        COUNT(DISTINCT c.referral_request_id),
        SUM(CASE WHEN c.referral_request_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.referral_request_id IS NOT NULL AND p.id IS NULL THEN c.referral_request_id END),
        SUM(CASE WHEN c.referral_request_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.MEDICATION_STATEMENT c
    LEFT JOIN OLIDS_COMMON.REFERRAL_REQUEST p ON c.referral_request_id = p.id

    UNION ALL

    -- OBSERVATION -> PATIENT
    SELECT 'OBSERVATION', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- OBSERVATION -> PERSON
    SELECT 'OBSERVATION', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- OBSERVATION -> ENCOUNTER
    SELECT 'OBSERVATION', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- OBSERVATION -> PRACTITIONER
    SELECT 'OBSERVATION', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- OBSERVATION -> OBSERVATION (parent)
    SELECT 'OBSERVATION', 'parent_observation_id', 'OBSERVATION',
        COUNT(DISTINCT c.parent_observation_id),
        SUM(CASE WHEN c.parent_observation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.parent_observation_id IS NOT NULL AND p.id IS NULL THEN c.parent_observation_id END),
        SUM(CASE WHEN c.parent_observation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.OBSERVATION c
    LEFT JOIN OLIDS_COMMON.OBSERVATION p ON c.parent_observation_id = p.id

    UNION ALL

    -- ORGANISATION -> ORGANISATION (parent)
    SELECT 'ORGANISATION', 'parent_organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.parent_organisation_id),
        SUM(CASE WHEN c.parent_organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.parent_organisation_id IS NOT NULL AND p.id IS NULL THEN c.parent_organisation_id END),
        SUM(CASE WHEN c.parent_organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.ORGANISATION c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.parent_organisation_id = p.id

    UNION ALL

    -- PATIENT -> ORGANISATION (registered practice)
    SELECT 'PATIENT', 'registered_practice_id', 'ORGANISATION',
        COUNT(DISTINCT c.registered_practice_id),
        SUM(CASE WHEN c.registered_practice_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.registered_practice_id IS NOT NULL AND p.id IS NULL THEN c.registered_practice_id END),
        SUM(CASE WHEN c.registered_practice_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.registered_practice_id = p.id

    UNION ALL

    -- PATIENT_ADDRESS -> PATIENT
    SELECT 'PATIENT_ADDRESS', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT_ADDRESS c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- PATIENT_CONTACT -> PATIENT
    SELECT 'PATIENT_CONTACT', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_MASKED.PATIENT_CONTACT c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- PATIENT_PERSON -> PATIENT
    SELECT 'PATIENT_PERSON', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_PERSON c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- PATIENT_PERSON -> PERSON
    SELECT 'PATIENT_PERSON', 'person_id', 'PERSON',
        COUNT(DISTINCT c.person_id),
        SUM(CASE WHEN c.person_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN c.person_id END),
        SUM(CASE WHEN c.person_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_PERSON c
    LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id

    UNION ALL

    -- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> PATIENT
    SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> ORGANISATION
    SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.organisation_id),
        SUM(CASE WHEN c.organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN c.organisation_id END),
        SUM(CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id

    UNION ALL

    -- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> PRACTITIONER
    SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- PATIENT_REGISTERED_PRACTITIONER_IN_ROLE -> EPISODE_OF_CARE
    SELECT 'PATIENT_REGISTERED_PRACTITIONER_IN_ROLE', 'episode_of_care_id', 'EPISODE_OF_CARE',
        COUNT(DISTINCT c.episode_of_care_id),
        SUM(CASE WHEN c.episode_of_care_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.episode_of_care_id IS NOT NULL AND p.id IS NULL THEN c.episode_of_care_id END),
        SUM(CASE WHEN c.episode_of_care_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PATIENT_REGISTERED_PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_COMMON.EPISODE_OF_CARE p ON c.episode_of_care_id = p.id

    UNION ALL

    -- PRACTITIONER_IN_ROLE -> PRACTITIONER
    SELECT 'PRACTITIONER_IN_ROLE', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- PRACTITIONER_IN_ROLE -> ORGANISATION
    SELECT 'PRACTITIONER_IN_ROLE', 'organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.organisation_id),
        SUM(CASE WHEN c.organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN c.organisation_id END),
        SUM(CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PRACTITIONER_IN_ROLE c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id

    UNION ALL

    -- PROCEDURE_REQUEST -> PATIENT
    SELECT 'PROCEDURE_REQUEST', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- PROCEDURE_REQUEST -> ENCOUNTER
    SELECT 'PROCEDURE_REQUEST', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- PROCEDURE_REQUEST -> PRACTITIONER
    SELECT 'PROCEDURE_REQUEST', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.PROCEDURE_REQUEST c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> PATIENT
    SELECT 'REFERRAL_REQUEST', 'patient_id', 'PATIENT',
        COUNT(DISTINCT c.patient_id),
        SUM(CASE WHEN c.patient_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN c.patient_id END),
        SUM(CASE WHEN c.patient_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> ENCOUNTER
    SELECT 'REFERRAL_REQUEST', 'encounter_id', 'ENCOUNTER',
        COUNT(DISTINCT c.encounter_id),
        SUM(CASE WHEN c.encounter_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN c.encounter_id END),
        SUM(CASE WHEN c.encounter_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> PRACTITIONER
    SELECT 'REFERRAL_REQUEST', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> ORGANISATION
    SELECT 'REFERRAL_REQUEST', 'organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.organisation_id),
        SUM(CASE WHEN c.organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN c.organisation_id END),
        SUM(CASE WHEN c.organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.organisation_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> ORGANISATION (requester)
    SELECT 'REFERRAL_REQUEST', 'requester_organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.requester_organisation_id),
        SUM(CASE WHEN c.requester_organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.requester_organisation_id IS NOT NULL AND p.id IS NULL THEN c.requester_organisation_id END),
        SUM(CASE WHEN c.requester_organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.requester_organisation_id = p.id

    UNION ALL

    -- REFERRAL_REQUEST -> ORGANISATION (recipient)
    SELECT 'REFERRAL_REQUEST', 'recipient_organisation_id', 'ORGANISATION',
        COUNT(DISTINCT c.recipient_organisation_id),
        SUM(CASE WHEN c.recipient_organisation_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.recipient_organisation_id IS NOT NULL AND p.id IS NULL THEN c.recipient_organisation_id END),
        SUM(CASE WHEN c.recipient_organisation_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.REFERRAL_REQUEST c
    LEFT JOIN OLIDS_COMMON.ORGANISATION p ON c.recipient_organisation_id = p.id

    UNION ALL

    -- SCHEDULE -> LOCATION
    SELECT 'SCHEDULE', 'location_id', 'LOCATION',
        COUNT(DISTINCT c.location_id),
        SUM(CASE WHEN c.location_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.location_id IS NOT NULL AND p.id IS NULL THEN c.location_id END),
        SUM(CASE WHEN c.location_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.SCHEDULE c
    LEFT JOIN OLIDS_COMMON.LOCATION p ON c.location_id = p.id

    UNION ALL

    -- SCHEDULE -> PRACTITIONER
    SELECT 'SCHEDULE', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.SCHEDULE c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id

    UNION ALL

    -- SCHEDULE_PRACTITIONER -> SCHEDULE
    SELECT 'SCHEDULE_PRACTITIONER', 'schedule_id', 'SCHEDULE',
        COUNT(DISTINCT c.schedule_id),
        SUM(CASE WHEN c.schedule_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.schedule_id IS NOT NULL AND p.id IS NULL THEN c.schedule_id END),
        SUM(CASE WHEN c.schedule_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.SCHEDULE_PRACTITIONER c
    LEFT JOIN OLIDS_COMMON.SCHEDULE p ON c.schedule_id = p.id

    UNION ALL

    -- SCHEDULE_PRACTITIONER -> PRACTITIONER
    SELECT 'SCHEDULE_PRACTITIONER', 'practitioner_id', 'PRACTITIONER',
        COUNT(DISTINCT c.practitioner_id),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL THEN 1 ELSE 0 END),
        COUNT(DISTINCT CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN c.practitioner_id END),
        SUM(CASE WHEN c.practitioner_id IS NOT NULL AND p.id IS NULL THEN 1 ELSE 0 END)
    FROM OLIDS_COMMON.SCHEDULE_PRACTITIONER c
    LEFT JOIN OLIDS_COMMON.PRACTITIONER p ON c.practitioner_id = p.id
)

SELECT
    'referential_integrity' AS test_name,
    child_table AS table_name,
    fk_column || ' -> ' || parent_table || '.id' AS test_subject,
    CASE
        WHEN total_rows_with_fk = 0 THEN 'WARN'
        WHEN orphaned_fk = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status,
    CASE WHEN total_rows_with_fk = 0 THEN NULL
        ELSE ROUND(100.0 * (total_distinct_fk - orphaned_fk) / NULLIF(total_distinct_fk, 0), 2)
    END AS metric_value,
    100.0 AS threshold,
    total_distinct_fk,
    total_rows_with_fk,
    orphaned_fk,
    orphaned_rows
FROM fk_checks
ORDER BY status DESC, metric_value ASC, child_table, fk_column;
