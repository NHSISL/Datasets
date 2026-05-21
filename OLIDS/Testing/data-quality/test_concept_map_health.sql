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
         are essentially meaningless. Broken down by why the row is there
         (per NCL terminology-bugs investigation, 2026-03-27):
           - no_emis_ref_match: mostly TPP rows, no EMIS reference entry,
             so cannot be auto-fixed via the EMIS reference table
           - fixable_active: source code DOES have an active national SNOMED
             concept in the EMIS reference - easy backfill
           - fixable_emis_namespace: source maps to an EMIS-namespace SNOMED
             extension (module 1000006), valid local concept, not in NHSD
             reporting model, needs Dedalus to incorporate
           - retired_in_emis_ref: EMIS reference points to a retired concept
           - legitimately_root: EMIS reference also points at 138875005 -
             these are correctly mapped, NOT a bug
         The 'legitimately_root' rows count towards PASS, the others FAIL.

      3. Mappings pointing to retired SNOMED concepts
         A target that is no longer active in the NHSD SNOMED reporting
         model will not appear in termbrowser searches or modern code-set
         tooling. Counts CONCEPT_MAP rows whose TARGET_CODE matches an
         inactive Dictionary.NHSD_SnomedReportingModel.SCT_Concept.Id.

      4. Active SNOMED concepts not present in the concept map
         Active concepts that never appear as a CONCEPT_MAP.TARGET_CODE are
         effectively invisible if data starts to flow against them. Counts
         active SCT_Concept rows that have no CONCEPT_MAP target reference.

      5. Root-targeting rows resolvable via SCT_Description term match
         Of the rows pointing at SNOMED root, how many have a SOURCE_DISPLAY
         that exactly (case-insensitive) matches the Term on an active
         SCT_Description belonging to an active SCT_Concept. These are
         straightforward fix candidates - Dedalus could pick the matched
         concept as the target.

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

-- Check 2: CONCEPT_MAP rows pointing at SNOMED root 138875005, broken down by category.
-- Joining EMIS ref via cm.SOURCE_CODE (numeric EMIS code) since the UUID columns differ.
-- Dedupe the EMIS reference per code first so multiple ref rows for the same EMIS code
-- don't fan out the row count.
emis_ref_dedup AS (
    SELECT EMIS_CODE_ID, ANY_VALUE(SNOMED_CT_CONCEPT_ID) AS SNOMED_CT_CONCEPT_ID
    FROM REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE
    WHERE SNOMED_CT_CONCEPT_ID IS NOT NULL
    GROUP BY EMIS_CODE_ID
),
root_target_breakdown AS (
    SELECT
        cm.MAPPED_ITEM_ID,
        cm.SOURCE_CODE,
        ref.SNOMED_CT_CONCEPT_ID AS ref_snomed,
        sct."Active" AS sct_active
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    LEFT JOIN emis_ref_dedup ref
        ON cm.SOURCE_SYSTEM = 'http://LDS.nhs/EMIS/CodeID/cs'
       AND cm.SOURCE_CODE = ref.EMIS_CODE_ID::VARCHAR
    LEFT JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
        ON ref.SNOMED_CT_CONCEPT_ID = sct."Id"
    WHERE cm.TARGET_CODE = '138875005'
),
root_target_categories AS (
    SELECT
        SUM(CASE WHEN ref_snomed IS NULL THEN 1 ELSE 0 END) AS no_emis_ref_match,
        SUM(CASE WHEN ref_snomed = 138875005 THEN 1 ELSE 0 END) AS legitimately_root,
        SUM(CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active = TRUE THEN 1 ELSE 0 END) AS fixable_active,
        SUM(CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active = FALSE THEN 1 ELSE 0 END) AS retired_in_emis_ref,
        SUM(CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active IS NULL THEN 1 ELSE 0 END) AS fixable_emis_namespace,
        COUNT(*) AS total_root_rows,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE IS NOT NULL) AS total_cm_rows
    FROM root_target_breakdown
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

-- Check 5: root-targeting rows whose SOURCE_DISPLAY has an active SCT_Description term match
root_term_match AS (
    SELECT
        COUNT(DISTINCT cm.MAPPED_ITEM_ID) AS fixable_term_match,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE = '138875005') AS total_root_rows
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    WHERE cm.TARGET_CODE = '138875005'
      AND cm.SOURCE_DISPLAY IS NOT NULL
      AND EXISTS (
        SELECT 1
        FROM "Dictionary"."NHSD_SnomedReportingModel"."SCT_Description" d
        JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" c ON d."ConceptId" = c."Id"
        WHERE d."Active" = TRUE AND c."Active" = TRUE
          AND LOWER(d."Term") = LOWER(cm.SOURCE_DISPLAY)
      )
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

    -- Root target rows that are NOT legitimately mapped (i.e. should not be there)
    SELECT
        'concept_map_root_target',
        'CONCEPT_MAP',
        'CONCEPT_MAP rows not erroneously pointing at SNOMED root (138875005)',
        total_cm_rows - (total_root_rows - legitimately_root),
        total_root_rows - legitimately_root,
        total_cm_rows
    FROM root_target_categories

    UNION ALL

    SELECT
        'concept_map_root_no_emis_ref',
        'CONCEPT_MAP',
        'Root-targeting rows with NO EMIS reference match (mostly TPP - not auto-fixable)',
        total_root_rows - no_emis_ref_match,
        no_emis_ref_match,
        total_root_rows
    FROM root_target_categories

    UNION ALL

    SELECT
        'concept_map_root_fixable_active',
        'CONCEPT_MAP',
        'Root-targeting rows where EMIS ref has an ACTIVE national SNOMED (fixable backfill)',
        total_root_rows - fixable_active,
        fixable_active,
        total_root_rows
    FROM root_target_categories

    UNION ALL

    SELECT
        'concept_map_root_emis_namespace',
        'CONCEPT_MAP',
        'Root-targeting rows where EMIS ref points to an EMIS-namespace SNOMED extension',
        total_root_rows - fixable_emis_namespace,
        fixable_emis_namespace,
        total_root_rows
    FROM root_target_categories

    UNION ALL

    SELECT
        'concept_map_root_retired_in_ref',
        'CONCEPT_MAP',
        'Root-targeting rows where EMIS ref points to a RETIRED SNOMED concept',
        total_root_rows - retired_in_emis_ref,
        retired_in_emis_ref,
        total_root_rows
    FROM root_target_categories

    UNION ALL

    SELECT
        'concept_map_root_term_match',
        'CONCEPT_MAP',
        'Root-targeting rows resolvable via active SCT_Description term exact match (case-insensitive)',
        total_root_rows - fixable_term_match,
        fixable_term_match,
        total_root_rows
    FROM root_term_match

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
