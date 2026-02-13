/*
    Investigation: Registration PDS Comparison
    Run: uv run run_tests.py --run investigations/investigate_registration_pds.sql
         Or execute directly in Snowsight — set the USE DATABASE and schema
         variables below to match your ICB.

    Shows per-practice comparison of OLIDS vs PDS registration counts.
    Reuses the same methodology as test_registration_pds.sql.
    Ordered by largest absolute % difference to highlight problem practices.
*/

USE DATABASE "Data_Store_OLIDS_Clinical_Validation";  -- Replace with your ICB's OLIDS database name

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

-- Snapshot date: the most recent month-end that OLIDS data covers.
-- PDS updates at month-ends, so we snap to a month boundary for accurate comparison.
-- Uses MAX(episode_of_care_start_date) as the freshness indicator. Future dates excluded.
SET snapshot_date = (
    SELECT LAST_DAY(DATEADD(MONTH, -1, DATEADD(DAY, 1,
        MAX(CASE WHEN episode_of_care_start_date <= CURRENT_DATE THEN episode_of_care_start_date END)::DATE
    )))
    FROM OLIDS_COMMON.EPISODE_OF_CARE
    WHERE record_owner_organisation_code IS NOT NULL
);

-- Practice codes derived from EPISODE_OF_CARE (only practices with actual data)
WITH icb_practices AS (
    SELECT DISTINCT record_owner_organisation_code AS practice_code
    FROM OLIDS_COMMON.EPISODE_OF_CARE
    WHERE record_owner_organisation_code IS NOT NULL
),

eligible_patients AS (
    SELECT id AS patient_id, sk_patient_id, death_year, death_month
    FROM OLIDS_MASKED.PATIENT
    WHERE sk_patient_id IS NOT NULL
        AND is_spine_sensitive = FALSE
        AND is_confidential = FALSE
        AND is_dummy_patient = FALSE
),

patient_death_dates AS (
    SELECT
        patient_id, sk_patient_id,
        death_year IS NOT NULL AS is_deceased,
        CASE
            WHEN death_year IS NOT NULL AND death_month IS NOT NULL
                THEN DATEADD(DAY,
                    FLOOR(DAY(LAST_DAY(TO_DATE(death_year || '-' || LPAD(death_month, 2, '0') || '-01'))) / 2),
                    TO_DATE(death_year || '-' || LPAD(death_month, 2, '0') || '-01'))
            WHEN death_year IS NOT NULL THEN TO_DATE(death_year || '-07-01')
            ELSE NULL
        END AS death_date_approx
    FROM eligible_patients
),

patient_to_person AS (
    SELECT patient_id, person_id
    FROM OLIDS_COMMON.PATIENT_PERSON
    WHERE patient_id IS NOT NULL AND person_id IS NOT NULL
),

episode_type_regular AS (
    SELECT source_code_id FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE source_code = 'Regular'
),

episode_status_left AS (
    SELECT source_code_id FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE source_code = 'Left'
),

filtered_episodes AS (
    SELECT eoc.id AS episode_id, ptp.person_id,
        eoc.record_owner_organisation_code AS practice_code,
        eoc.organisation_id, eoc.episode_of_care_start_date
    FROM OLIDS_COMMON.EPISODE_OF_CARE eoc
    INNER JOIN patient_death_dates pdd ON eoc.patient_id = pdd.patient_id
    INNER JOIN patient_to_person ptp ON eoc.patient_id = ptp.patient_id
    INNER JOIN episode_type_regular etr ON eoc.episode_type_source_concept_id = etr.source_code_id
    LEFT JOIN episode_status_left esl ON eoc.episode_status_source_concept_id = esl.source_code_id
    WHERE COALESCE(eoc.lds_is_deleted, FALSE) = FALSE
        AND eoc.lds_start_date_time IS NOT NULL
        AND eoc.episode_of_care_start_date IS NOT NULL
        AND eoc.patient_id IS NOT NULL
        AND eoc.organisation_id IS NOT NULL
        AND NOT (esl.source_code_id IS NOT NULL AND eoc.episode_of_care_end_date IS NULL)
        AND eoc.episode_of_care_start_date <= $snapshot_date::DATE
        AND (eoc.episode_of_care_end_date IS NULL
            OR eoc.episode_of_care_end_date > $snapshot_date::DATE
            OR eoc.episode_of_care_end_date < eoc.episode_of_care_start_date)
        AND (pdd.is_deceased = FALSE OR pdd.death_date_approx IS NULL OR pdd.death_date_approx > $snapshot_date::DATE)
),

deduplicated_registrations AS (
    SELECT person_id, practice_code
    FROM filtered_episodes
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY person_id, organisation_id
        ORDER BY episode_of_care_start_date DESC, episode_id DESC
    ) = 1
),

olids_counts AS (
    SELECT practice_code, COUNT(DISTINCT person_id) AS olids_count
    FROM deduplicated_registrations
    GROUP BY practice_code
),

pds_merged AS (
    SELECT
        COALESCE(merger."Pseudo Superseded NHS Number", reg."Pseudo NHS Number") AS merged_sk_patient_id,
        reg."Primary Care Provider" AS practice_code
    FROM "Data_Store_Registries"."pds"."PDS_Patient_Care_Practice" reg
    INNER JOIN icb_practices ip ON reg."Primary Care Provider" = ip.practice_code
    LEFT JOIN "Data_Store_Registries"."pds"."PDS_Person_Merger" merger
        ON reg."Pseudo NHS Number" = merger."Pseudo NHS Number"
        AND $snapshot_date::DATE BETWEEN merger."Person Merger Business Effective From Date"
            AND COALESCE(merger."Person Merger Business Effective To Date", '9999-12-31')
    LEFT JOIN "Data_Store_Registries"."pds"."PDS_Person" person
        ON reg."Pseudo NHS Number" = person."Pseudo NHS Number"
        AND $snapshot_date::DATE BETWEEN person."Person Business Effective From Date"
            AND COALESCE(person."Person Business Effective To Date", '9999-12-31')
    LEFT JOIN "Data_Store_Registries"."pds"."PDS_Reason_For_Removal" rfr
        ON reg."Pseudo NHS Number" = rfr."Pseudo NHS Number"
        AND $snapshot_date::DATE BETWEEN rfr."Reason for Removal Business Effective From Date"
            AND COALESCE(rfr."Reason for Removal Business Effective To Date", '9999-12-31')
    WHERE $snapshot_date::DATE BETWEEN reg."Primary Care Provider Business Effective From Date"
            AND COALESCE(reg."Primary Care Provider Business Effective To Date", '9999-12-31')
        AND person."Death Status" IS NULL
        AND rfr."Pseudo NHS Number" IS NULL
),

pds_counts AS (
    SELECT practice_code, COUNT(DISTINCT merged_sk_patient_id) AS pds_count
    FROM pds_merged
    WHERE practice_code IS NOT NULL
    GROUP BY practice_code
)

SELECT
    COALESCE(p.practice_code, o.practice_code) AS practice_code,
    COALESCE(o.olids_count, 0) AS olids_count,
    COALESCE(p.pds_count, 0) AS pds_count,
    COALESCE(o.olids_count, 0) - COALESCE(p.pds_count, 0) AS diff,
    ABS(COALESCE(o.olids_count, 0) - COALESCE(p.pds_count, 0)) AS abs_diff,
    CASE WHEN COALESCE(p.pds_count, 0) > 0
        THEN ROUND(ABS(COALESCE(o.olids_count, 0) - p.pds_count) * 100.0 / p.pds_count, 2)
        ELSE NULL
    END AS abs_pct_diff,
    CASE
        WHEN p.pds_count IS NULL THEN 'OLIDS ONLY'
        WHEN o.olids_count IS NULL THEN 'PDS ONLY'
        WHEN ABS(COALESCE(o.olids_count, 0) - p.pds_count) * 100.0 / p.pds_count < 2 OR ABS(COALESCE(o.olids_count, 0) - p.pds_count) < 5 THEN 'PASS (<2%)'
        WHEN ABS(COALESCE(o.olids_count, 0) - p.pds_count) * 100.0 / p.pds_count < 5 OR ABS(COALESCE(o.olids_count, 0) - p.pds_count) < 5 THEN 'PASS (<5%)'
        ELSE 'FAIL'
    END AS status,
    $snapshot_date::DATE AS snapshot_date
FROM pds_counts p
FULL OUTER JOIN olids_counts o ON p.practice_code = o.practice_code
ORDER BY abs_pct_diff DESC NULLS LAST;
