/*
    Test: Registration Count - PDS Comparison
    Run:  uv run run_tests.py --test test_registration_pds

    Compares OLIDS GP registration counts against PDS (Personal Demographics Service)
    to validate that the OLIDS data reflects the national registration picture.

    How it works:
      1. 'icb_practices' - gets practice codes from EPISODE_OF_CARE, limiting to
         practices that actually have data in this OLIDS database (~175 for NCL).
      2. OLIDS side (CTEs: eligible_patients -> patient_death_dates -> filtered_episodes
         -> deduplicated_registrations -> olids_counts):
           - Start with patients who are not sensitive, confidential, or dummy
           - Approximate death dates from year/month (mid-month or mid-year)
           - Filter episodes: Regular type only, active as of snapshot, not soft-deleted
           - Exclude "Left" episodes with no end date (malformed data)
           - Treat end_date < start_date as still active (known data quality issue)
           - Deduplicate: one registration per person per practice (latest episode wins)
      3. PDS side (CTEs: pds_merged -> pds_counts):
           - Active registrations as of snapshot date
           - Handle NHS number mergers (superseded numbers via PDS_Person_Merger)
           - Exclude deceased patients (PDS_Person.Death Status)
           - Exclude patients with reason for removal (PDS_Reason_For_Removal)
      4. 'comparison' - joins OLIDS and PDS counts per practice, computes % diff
      5. 'summary' - counts how many practices pass at each threshold

    Three output rows at different thresholds:
      - <1% or <5 persons (strictest)
      - <2% or <5 persons (tight)
      - <5% or <5 persons (loose)
    The <5 persons clause prevents small practices (e.g. 50 patients) from
    failing due to a handful of patients causing a high % diff.

    Configuration:
      - snapshot_date: last day of the previous complete calendar month
        (PDS updates at month-ends)

    PDS tables:
      This test reads from "Data_Store_Registries"."pds" which is the standard
      PDS location for most London ICBs. If your ICB stores PDS data elsewhere,
      search for "Data_Store_Registries" in this file and replace all occurrences.
*/

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

-- Step 1: Patients eligible for counting (exclude test/sensitive/confidential)
eligible_patients AS (
    SELECT
        id AS patient_id,
        sk_patient_id,
        death_year,
        death_month
    FROM OLIDS_MASKED.PATIENT
    WHERE sk_patient_id IS NOT NULL
        AND is_spine_sensitive = FALSE
        AND is_confidential = FALSE
        AND is_dummy_patient = FALSE
),

-- Step 2: Approximate death dates from year/month (OLIDS only stores year+month, not exact date)
-- If year+month known: use mid-month. If only year: use July 1st.
patient_death_dates AS (
    SELECT
        patient_id,
        sk_patient_id,
        death_year IS NOT NULL AS is_deceased,
        CASE
            WHEN death_year IS NOT NULL AND death_month IS NOT NULL
                THEN DATEADD(
                    DAY,
                    FLOOR(DAY(LAST_DAY(TO_DATE(death_year || '-' || LPAD(death_month, 2, '0') || '-01'))) / 2),
                    TO_DATE(death_year || '-' || LPAD(death_month, 2, '0') || '-01')
                )
            WHEN death_year IS NOT NULL
                THEN TO_DATE(death_year || '-07-01')
            ELSE NULL
        END AS death_date_approx
    FROM eligible_patients
),

-- Step 3: Map patient_id to person_id (OLIDS deduplicates by person, not patient)
patient_to_person AS (
    SELECT patient_id, person_id
    FROM OLIDS_COMMON.PATIENT_PERSON
    WHERE patient_id IS NOT NULL AND person_id IS NOT NULL
),

-- Step 4: Look up concept IDs for 'Regular' episode type and 'Left' status
episode_type_regular AS (
    SELECT source_code_id
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP
    WHERE source_code = 'Regular'
),

episode_status_left AS (
    SELECT source_code_id
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP
    WHERE source_code = 'Left'
),

-- Step 5: Filter to active, valid registration episodes as of the snapshot date
filtered_episodes AS (
    SELECT
        eoc.id AS episode_id,
        ptp.person_id,
        eoc.record_owner_organisation_code AS practice_code,
        eoc.organisation_id,
        eoc.episode_of_care_start_date
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
        -- Exclude Left episodes with no end date (data quality issue)
        AND NOT (esl.source_code_id IS NOT NULL AND eoc.episode_of_care_end_date IS NULL)
        -- Episode started on or before snapshot
        AND eoc.episode_of_care_start_date <= $snapshot_date::DATE
        -- Episode still active: not ended, or end_date after snapshot, or end_date < start_date (bad data, treat as active)
        AND (
            eoc.episode_of_care_end_date IS NULL
            OR eoc.episode_of_care_end_date > $snapshot_date::DATE
            OR eoc.episode_of_care_end_date < eoc.episode_of_care_start_date
        )
        -- Patient alive as of snapshot
        AND (pdd.is_deceased = FALSE OR pdd.death_date_approx IS NULL OR pdd.death_date_approx > $snapshot_date::DATE)
),

-- Step 6: One registration per person per practice (latest episode wins)
deduplicated_registrations AS (
    SELECT person_id, practice_code
    FROM filtered_episodes
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY person_id, organisation_id
        ORDER BY episode_of_care_start_date DESC, episode_id DESC
    ) = 1
),

-- Step 7: Count distinct persons per practice
olids_counts AS (
    SELECT practice_code, COUNT(DISTINCT person_id) AS olids_count
    FROM deduplicated_registrations
    GROUP BY practice_code
),

-- Step 8: PDS registrations - count per practice using merged NHS numbers
-- PDS tables are in "Data_Store_Registries"."pds" - change if your ICB differs.
-- Uses temporal BETWEEN filters on business effective dates for point-in-time accuracy.
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

-- Step 9: Count distinct merged NHS numbers per practice
pds_counts AS (
    SELECT practice_code, COUNT(DISTINCT merged_sk_patient_id) AS pds_count
    FROM pds_merged
    WHERE practice_code IS NOT NULL
    GROUP BY practice_code
),

-- Step 10: Compare OLIDS vs PDS counts per practice
comparison AS (
    SELECT
        p.practice_code,
        COALESCE(o.olids_count, 0) AS olids_count,
        p.pds_count,
        ABS(COALESCE(o.olids_count, 0) - p.pds_count) AS abs_diff,
        ABS(COALESCE(o.olids_count, 0) - p.pds_count) * 100.0 / p.pds_count AS abs_pct_diff
    FROM pds_counts p
    LEFT JOIN olids_counts o ON p.practice_code = o.practice_code
    WHERE p.pds_count > 0
),

summary AS (
    SELECT
        COUNT(*) AS total_practices,
        SUM(CASE WHEN abs_pct_diff < 1 OR abs_diff < 5 THEN 1 ELSE 0 END) AS pass_strictest,
        SUM(CASE WHEN abs_pct_diff < 2 OR abs_diff < 5 THEN 1 ELSE 0 END) AS pass_tight,
        SUM(CASE WHEN abs_pct_diff < 5 OR abs_diff < 5 THEN 1 ELSE 0 END) AS pass_loose
    FROM comparison
)

SELECT
    'registration_pds_comparison' AS test_name,
    'Practice Registrations' AS table_name,
    pass_strictest || '/' || total_practices || ' practices within 1% or <5 persons of PDS' AS test_subject,
    CASE WHEN ROUND(100.0 * pass_strictest / NULLIF(total_practices, 0), 2) >= 100 THEN 'PASS' ELSE 'FAIL' END AS status,
    ROUND(100.0 * pass_strictest / NULLIF(total_practices, 0), 2) AS metric_value,
    100.0 AS threshold,
    $snapshot_date::DATE AS snapshot_date
FROM summary

UNION ALL

SELECT
    'registration_pds_comparison',
    'Practice Registrations',
    pass_tight || '/' || total_practices || ' practices within 2% or <5 persons of PDS' AS test_subject,
    CASE WHEN ROUND(100.0 * pass_tight / NULLIF(total_practices, 0), 2) >= 100 THEN 'PASS' ELSE 'FAIL' END AS status,
    ROUND(100.0 * pass_tight / NULLIF(total_practices, 0), 2) AS metric_value,
    100.0 AS threshold,
    $snapshot_date::DATE AS snapshot_date
FROM summary

UNION ALL

SELECT
    'registration_pds_comparison',
    'Practice Registrations',
    pass_loose || '/' || total_practices || ' practices within 5% or <5 persons of PDS',
    CASE WHEN ROUND(100.0 * pass_loose / NULLIF(total_practices, 0), 2) >= 100 THEN 'PASS' ELSE 'FAIL' END,
    ROUND(100.0 * pass_loose / NULLIF(total_practices, 0), 2),
    100.0,
    $snapshot_date::DATE
FROM summary;
