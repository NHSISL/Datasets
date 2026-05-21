/*
    Test: Concept Map Health (Terminology)
    Run:  uv run run_tests.py --test test_concept_map_health

    Four checks on the OLIDS_TERMINOLOGY.CONCEPT_MAP and its alignment with
    the EMIS clinical-code reference table and the national SNOMED CT release:

      1. Missing EMIS -> SNOMED mappings
         Every EMIS clinical code that has a SNOMED concept in the EMIS
         reference table should also have a CONCEPT_MAP row for it. Counts
         EMIS codes with a SNOMED in REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE
         but no matching CONCEPT_MAP.SOURCE_CODE row.

      2. Mappings pointing to root SNOMED concept (138875005)
         Mappings whose target is the SNOMED root concept ("SNOMED CT Concept")
         are essentially meaningless. Counts CONCEPT_MAP rows with
         TARGET_CODE = '138875005'.

      3. Mappings pointing to retired SNOMED concepts
         A target that is no longer active in the NHSD SNOMED reporting
         model will not appear in termbrowser searches or modern code-set
         tooling. Counts CONCEPT_MAP rows whose TARGET_CODE matches an
         inactive Dictionary.NHSD_SnomedReportingModel.SCT_Concept.Id.

      4. Active SNOMED concepts not present in the concept map
         Active concepts that never appear as a CONCEPT_MAP.TARGET_CODE are
         effectively invisible if data starts to flow against them. Counts
         active SCT_Concept rows that have no CONCEPT_MAP target reference.

    External dependencies:
      - REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE  (in the current OLIDS DB)
      - Dictionary.NHSD_SnomedReportingModel.SCT_Concept  (NHSD share)
      Both must be readable by the test runner role. If your ICB does not
      share Dictionary, checks 3 and 4 will return ERROR.

    Output:
      - metric_value = % of healthy rows / codes (higher is better)
      - threshold    = 100%
      - bad_count    = absolute number of problem rows (--verbose)
      - total_count  = denominator (--verbose)

    Background:
      Driven by NCL terminology-bugs investigation (2026-03-27 email thread).
      See test-results-2026-05-21.md cross-cutting observation #1.

    Notes:
      - EMIS coding table is referenced under REFERENCE schema (matches the
        actual Data_Store_OLIDS share). If your ICB stores it elsewhere,
        find-replace REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE in this file.
      - CONCEPT_MAP joins use SOURCE_CODE (numeric EMIS code) rather than
        SOURCE_CONCEPT_ID UUID, because the EMIS reference table and the
        CONCEPT_MAP allocate different UUIDs for the same EMIS code.
*/

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

WITH
-- Check 1: EMIS clinical codes (with a SNOMED in the EMIS reference) that are missing from CONCEPT_MAP
emis_coverage AS (
    SELECT
        COUNT(DISTINCT CASE WHEN cm.SOURCE_CODE IS NULL THEN ref.EMIS_CODE_ID END) AS missing,
        COUNT(DISTINCT ref.EMIS_CODE_ID) AS total
    FROM REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE ref
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm
        ON ref.EMIS_CODE_ID::VARCHAR = cm.SOURCE_CODE
       AND cm.SOURCE_SYSTEM = 'http://LDS.nhs/EMIS/CodeID/cs'
    WHERE ref.SNOMED_CT_CONCEPT_ID IS NOT NULL
),

-- Check 2: CONCEPT_MAP rows pointing at SNOMED root concept 138875005
root_target AS (
    SELECT
        SUM(CASE WHEN TARGET_CODE = '138875005' THEN 1 ELSE 0 END) AS bad,
        COUNT(*) AS total
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP
    WHERE TARGET_CODE IS NOT NULL
),

-- Check 3: CONCEPT_MAP rows whose target is a retired SNOMED concept
retired_target AS (
    SELECT
        COUNT(*) AS bad,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE IS NOT NULL) AS total
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
        ON cm.TARGET_CODE = sct."Id"::VARCHAR
    WHERE sct."Active" = FALSE
),

-- Check 4: active SNOMED concepts that never appear as a CONCEPT_MAP target
snomed_coverage AS (
    SELECT
        SUM(CASE WHEN cm_targets.TARGET_CODE IS NULL THEN 1 ELSE 0 END) AS missing,
        COUNT(*) AS total
    FROM "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
    LEFT JOIN (
        SELECT DISTINCT TARGET_CODE
        FROM OLIDS_TERMINOLOGY.CONCEPT_MAP
        WHERE TARGET_CODE IS NOT NULL
    ) cm_targets ON sct."Id"::VARCHAR = cm_targets.TARGET_CODE
    WHERE sct."Active" = TRUE
),

checks AS (
    SELECT
        'emis_snomed_coverage' AS check_name,
        'CONCEPT_MAP' AS table_name,
        'EMIS clinical codes with a SNOMED that have a CONCEPT_MAP row' AS test_subject,
        total - missing AS good_count,
        missing AS bad_count,
        total AS total_count
    FROM emis_coverage

    UNION ALL

    SELECT
        'concept_map_root_target',
        'CONCEPT_MAP',
        'CONCEPT_MAP rows not pointing at SNOMED root (138875005)',
        total - bad,
        bad,
        total
    FROM root_target

    UNION ALL

    SELECT
        'concept_map_retired_target',
        'CONCEPT_MAP',
        'CONCEPT_MAP rows not pointing at a retired SNOMED concept',
        total - bad,
        bad,
        total
    FROM retired_target

    UNION ALL

    SELECT
        'snomed_active_coverage',
        'CONCEPT_MAP',
        'Active SNOMED concepts present as a CONCEPT_MAP target',
        total - missing,
        missing,
        total
    FROM snomed_coverage
)

SELECT
    check_name AS test_name,
    table_name,
    test_subject || ' (' || bad_count || ' bad)' AS test_subject,
    CASE
        WHEN total_count = 0 THEN 'WARN'
        WHEN bad_count = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status,
    ROUND(100.0 * good_count / NULLIF(total_count, 0), 4) AS metric_value,
    100.0 AS threshold,
    good_count,
    bad_count,
    total_count
FROM checks
ORDER BY status DESC, metric_value ASC, test_name;
