/*
    Investigation: Referential Integrity
    Run: Execute directly in Snowsight or VS Code Snowflake extension.
         Set the USE DATABASE below to your ICB's OLIDS database.

    For the most common FK failures, shows orphaned FK values
    with their row counts. Helps identify whether orphans are
    systematic (few IDs, many rows) or scattered.
    Add more FK checks as needed following the same pattern.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

-- ENCOUNTER -> PATIENT: orphaned patient_ids
SELECT 'ENCOUNTER' AS child_table, 'patient_id' AS fk_column, 'PATIENT' AS parent_table,
    c.patient_id AS orphaned_value, COUNT(*) AS row_count
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- OBSERVATION -> PATIENT
SELECT 'OBSERVATION', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- OBSERVATION -> ENCOUNTER
SELECT 'OBSERVATION', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- MEDICATION_ORDER -> PATIENT
SELECT 'MEDICATION_ORDER', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- MEDICATION_ORDER -> ENCOUNTER
SELECT 'MEDICATION_ORDER', 'encounter_id', 'ENCOUNTER',
    c.encounter_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_ORDER c
LEFT JOIN OLIDS_COMMON.ENCOUNTER p ON c.encounter_id = p.id
WHERE c.encounter_id IS NOT NULL AND p.id IS NULL
GROUP BY c.encounter_id

UNION ALL

-- MEDICATION_STATEMENT -> PATIENT
SELECT 'MEDICATION_STATEMENT', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.MEDICATION_STATEMENT c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- EPISODE_OF_CARE -> PATIENT
SELECT 'EPISODE_OF_CARE', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- APPOINTMENT -> PATIENT
SELECT 'APPOINTMENT', 'patient_id', 'PATIENT',
    c.patient_id, COUNT(*)
FROM OLIDS_COMMON.APPOINTMENT c
LEFT JOIN OLIDS_MASKED.PATIENT p ON c.patient_id = p.id
WHERE c.patient_id IS NOT NULL AND p.id IS NULL
GROUP BY c.patient_id

UNION ALL

-- SCHEDULE_PRACTITIONER -> SCHEDULE
SELECT 'SCHEDULE_PRACTITIONER', 'schedule_id', 'SCHEDULE',
    c.schedule_id, COUNT(*)
FROM OLIDS_COMMON.SCHEDULE_PRACTITIONER c
LEFT JOIN OLIDS_COMMON.SCHEDULE p ON c.schedule_id = p.id
WHERE c.schedule_id IS NOT NULL AND p.id IS NULL
GROUP BY c.schedule_id

UNION ALL

-- ENCOUNTER -> PERSON
SELECT 'ENCOUNTER', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.ENCOUNTER c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- OBSERVATION -> PERSON
SELECT 'OBSERVATION', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.OBSERVATION c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

UNION ALL

-- EPISODE_OF_CARE -> PERSON
SELECT 'EPISODE_OF_CARE', 'person_id', 'PERSON',
    c.person_id, COUNT(*)
FROM OLIDS_COMMON.EPISODE_OF_CARE c
LEFT JOIN OLIDS_MASKED.PERSON p ON c.person_id = p.id
WHERE c.person_id IS NOT NULL AND p.id IS NULL
GROUP BY c.person_id

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

ORDER BY child_table, fk_column, row_count DESC;
