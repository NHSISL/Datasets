/*
    Test: Concept Map Health (Terminology)
    Run:  uv run run_tests.py --test test_concept_map_health

    Checks on OLIDS_TERMINOLOGY.CONCEPT_MAP against the EMIS clinical-code
    reference table and the national SNOMED CT release. Each headline check
    has both a catalogue-wide variant (counting every ref/map row) and an
    'in_use' variant restricted to source UUIDs actually referenced by
    clinical tables (OBSERVATION / ALLERGY_INTOLERANCE / MEDICATION_* /
    DIAGNOSTIC_ORDER / PROCEDURE_REQUEST / REFERRAL_REQUEST / ENCOUNTER).
    The in_use numbers reflect real data impact rather than theoretical
    catalogue gaps.

      1. Missing EMIS -> SNOMED mappings
         Catalogue: EMIS clinical codes with a SNOMED in the EMIS reference
         table but no CONCEPT_MAP entry.
         In-use:    distinct source_concept_id values referenced by clinical
                    tables that have no CONCEPT_MAP entry at all.

      2. Mappings pointing to root SNOMED concept (138875005)
         Catalogue: CONCEPT_MAP rows whose target is the SNOMED root concept.
         Broken down by why the row is there (no_emis_ref_match, fixable_active,
         fixable_emis_namespace, retired_in_emis_ref, legitimately_root).
         In-use:    same root-target rows restricted to source_concept_id
                    values actually referenced by clinical tables.

      3. Mappings pointing to retired SNOMED concepts
         Catalogue: CONCEPT_MAP rows whose TARGET_CODE matches an inactive
         Dictionary.NHSD_SnomedReportingModel.SCT_Concept.Id.
         In-use:    same restricted to in-use source UUIDs.

      4. Active SNOMED concepts not present as a CONCEPT_MAP target
         Active SCT_Concept rows that never appear as a CONCEPT_MAP.TARGET_CODE.
         Effectively forward-looking - if data flows against these concepts
         in future, they will be invisible. No in_use variant (by definition,
         absent targets cannot be in use).

      5. Term-match fix candidates (SCT_Description)
         Three variants - how many of the unmapped / misdirected rows have a
         straightforward auto-fix via case-insensitive exact match against
         the Term column of an active SCT_Description belonging to an active
         SCT_Concept.
           - missing-in-use term match: in-use unmapped UUIDs whose CONCEPT
             display has a matching SCT_Description term
           - root-target term match:    root-target CM rows whose SOURCE_DISPLAY
             has a matching SCT_Description term
           - retired-target term match: retired-target CM rows whose
             SOURCE_DISPLAY has a matching SCT_Description term

    External dependencies:
      - REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE  (in the current OLIDS DB)
      - Dictionary.NHSD_SnomedReportingModel.SCT_Concept  (NHSD share)
      - Dictionary.NHSD_SnomedReportingModel.SCT_Description  (NHSD share)
      All must be readable by the test runner role. If your ICB does not
      share Dictionary, the SCT-dependent checks will return ERROR.

    Output:
      - metric_value = % of healthy rows / codes (higher is better)
      - threshold    = 100%
      - bad_count    = absolute number of problem rows OR (for *_term_match
                       checks) the actionable subset count
      - total_count  = denominator (--verbose)

    Background:
      Driven by NCL terminology-bugs investigation (2026-03-27 email thread).
      The 'in_use' framing was added 2026-05-21 because catalogue-wide counts
      (e.g. 136k missing EMIS->SNOMED) overstate actual data impact - most
      of those codes never flow into clinical tables.

    Notes:
      - EMIS coding table is referenced under REFERENCE schema (matches the
        actual Data_Store_OLIDS share). If your ICB stores it elsewhere,
        find-replace REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE in this file.
      - The EMIS reference table has duplicate rows for some codes, so ref
        is deduped per UUID first to keep each CONCEPT_MAP row matched to a
        single ref row.
*/

SET schema_masked = 'OLIDS_MASKED';        -- Change if your ICB uses a different name (e.g. OLIDS_PCD)
SET schema_common = 'OLIDS_COMMON';
SET schema_terminology = 'OLIDS_TERMINOLOGY';

WITH
-- Deduped EMIS reference (one row per OLIDS UUID) so the joins below don't fan out
emis_ref_dedup AS (
    SELECT OLIDS_EMIS_CODE_CONCEPT_ID::UUID AS uuid_id,
           ANY_VALUE(EMIS_CODE_ID) AS EMIS_CODE_ID,
           ANY_VALUE(SNOMED_CT_CONCEPT_ID) AS SNOMED_CT_CONCEPT_ID
    FROM REFERENCE.PRIMARY_CARE_EMIS_CLINICAL_CODE
    GROUP BY OLIDS_EMIS_CODE_CONCEPT_ID
),

-- Distinct source_concept_id values referenced by primary clinical tables.
-- This is the "what's actually in use" universe.
in_use_uuids AS (
    SELECT DISTINCT source_concept_id FROM (
        SELECT observation_source_concept_id              AS source_concept_id FROM OLIDS_COMMON.OBSERVATION           WHERE observation_source_concept_id IS NOT NULL
        UNION SELECT allergy_intolerance_source_concept_id                     FROM OLIDS_COMMON.ALLERGY_INTOLERANCE  WHERE allergy_intolerance_source_concept_id IS NOT NULL
        UNION SELECT medication_statement_source_concept_id                    FROM OLIDS_COMMON.MEDICATION_STATEMENT WHERE medication_statement_source_concept_id IS NOT NULL
        UNION SELECT medication_order_source_concept_id                        FROM OLIDS_COMMON.MEDICATION_ORDER     WHERE medication_order_source_concept_id IS NOT NULL
        UNION SELECT diagnostic_order_source_concept_id                        FROM OLIDS_COMMON.DIAGNOSTIC_ORDER     WHERE diagnostic_order_source_concept_id IS NOT NULL
        UNION SELECT procedure_request_source_concept_id                       FROM OLIDS_COMMON.PROCEDURE_REQUEST    WHERE procedure_request_source_concept_id IS NOT NULL
        UNION SELECT referral_request_source_concept_id                        FROM OLIDS_COMMON.REFERRAL_REQUEST     WHERE referral_request_source_concept_id IS NOT NULL
        UNION SELECT encounter_source_concept_id                               FROM OLIDS_COMMON.ENCOUNTER            WHERE encounter_source_concept_id IS NOT NULL
    )
),

in_use_total AS (
    SELECT COUNT(*) AS n FROM in_use_uuids
),

-- Check 1 (catalogue): EMIS codes (with a SNOMED in the EMIS reference) missing from CONCEPT_MAP
emis_coverage AS (
    SELECT
        COUNT(DISTINCT CASE WHEN cm.SOURCE_CONCEPT_ID IS NULL THEN ref.uuid_id END) AS missing,
        COUNT(DISTINCT ref.uuid_id) AS total
    FROM emis_ref_dedup ref
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm
        ON ref.uuid_id = cm.SOURCE_CONCEPT_ID
    WHERE ref.SNOMED_CT_CONCEPT_ID IS NOT NULL
),

-- Check 1 (in_use): in-use UUIDs with no CONCEPT_MAP row
in_use_missing AS (
    SELECT COUNT(DISTINCT u.source_concept_id) AS missing
    FROM in_use_uuids u
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON u.source_concept_id = cm.SOURCE_CONCEPT_ID
    WHERE cm.SOURCE_CONCEPT_ID IS NULL
),

-- Check 1 + term match (in_use): of in-use missing UUIDs, how many have an active SCT_Description term match via CONCEPT.DISPLAY
in_use_missing_term_match AS (
    SELECT COUNT(DISTINCT u.source_concept_id) AS fixable
    FROM in_use_uuids u
    LEFT JOIN OLIDS_TERMINOLOGY.CONCEPT_MAP cm ON u.source_concept_id = cm.SOURCE_CONCEPT_ID
    JOIN OLIDS_TERMINOLOGY.CONCEPT c ON u.source_concept_id = c.CONCEPT_ID
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Description" d ON LOWER(d."Term") = LOWER(c.DISPLAY)
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sc ON d."ConceptId" = sc."Id"
    WHERE cm.SOURCE_CONCEPT_ID IS NULL
      AND c.DISPLAY IS NOT NULL
      AND d."Active" = TRUE
      AND sc."Active" = TRUE
),

-- Check 2 (catalogue): CONCEPT_MAP rows pointing at SNOMED root 138875005, broken down by category.
root_target_breakdown AS (
    SELECT
        cm.MAPPED_ITEM_ID,
        cm.SOURCE_CONCEPT_ID,
        ref.SNOMED_CT_CONCEPT_ID AS ref_snomed,
        sct."Active" AS sct_active
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    LEFT JOIN emis_ref_dedup ref
        ON cm.SOURCE_CONCEPT_ID = ref.uuid_id
    LEFT JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
        ON ref.SNOMED_CT_CONCEPT_ID = sct."Id"
    WHERE cm.TARGET_CODE = '138875005'
),
root_target_categories AS (
    SELECT
        COUNT(DISTINCT CASE WHEN ref_snomed IS NULL THEN MAPPED_ITEM_ID END) AS no_emis_ref_match,
        COUNT(DISTINCT CASE WHEN ref_snomed = 138875005 THEN MAPPED_ITEM_ID END) AS legitimately_root,
        COUNT(DISTINCT CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active = TRUE THEN MAPPED_ITEM_ID END) AS fixable_active,
        COUNT(DISTINCT CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active = FALSE THEN MAPPED_ITEM_ID END) AS retired_in_emis_ref,
        COUNT(DISTINCT CASE WHEN ref_snomed IS NOT NULL AND ref_snomed <> 138875005 AND sct_active IS NULL THEN MAPPED_ITEM_ID END) AS fixable_emis_namespace,
        COUNT(DISTINCT MAPPED_ITEM_ID) AS total_root_rows,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE IS NOT NULL) AS total_cm_rows
    FROM root_target_breakdown
),

-- Check 2 (in_use): root-target CM rows whose source UUID is actually in use
root_in_use AS (
    SELECT COUNT(DISTINCT cm.MAPPED_ITEM_ID) AS bad
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    INNER JOIN in_use_uuids u ON cm.SOURCE_CONCEPT_ID = u.source_concept_id
    WHERE cm.TARGET_CODE = '138875005'
),

-- Check 3 (catalogue): CONCEPT_MAP rows whose target is a retired SNOMED concept
retired_target AS (
    SELECT
        COUNT(*) AS bad,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE IS NOT NULL) AS total
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
        ON cm.TARGET_CODE = sct."Id"::VARCHAR
    WHERE sct."Active" = FALSE
),

-- Check 3 (in_use): retired-target CM rows whose source UUID is in use
retired_in_use AS (
    SELECT COUNT(DISTINCT cm.MAPPED_ITEM_ID) AS bad
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    INNER JOIN in_use_uuids u ON cm.SOURCE_CONCEPT_ID = u.source_concept_id
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct
        ON cm.TARGET_CODE = sct."Id"::VARCHAR
    WHERE sct."Active" = FALSE
),

-- Check 3 + term match: retired-target CM rows whose SOURCE_DISPLAY has an active SCT_Description term match
retired_term_match AS (
    SELECT COUNT(DISTINCT cm.MAPPED_ITEM_ID) AS fixable
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sct ON cm.TARGET_CODE = sct."Id"::VARCHAR
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Description" d ON LOWER(d."Term") = LOWER(cm.SOURCE_DISPLAY)
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sc ON d."ConceptId" = sc."Id"
    WHERE sct."Active" = FALSE
      AND cm.SOURCE_DISPLAY IS NOT NULL
      AND d."Active" = TRUE
      AND sc."Active" = TRUE
),

-- Check 5 (existing): root-targeting rows whose SOURCE_DISPLAY has an active SCT_Description term match
root_term_match AS (
    SELECT
        COUNT(DISTINCT cm.MAPPED_ITEM_ID) AS fixable_term_match,
        (SELECT COUNT(*) FROM OLIDS_TERMINOLOGY.CONCEPT_MAP WHERE TARGET_CODE = '138875005') AS total_root_rows
    FROM OLIDS_TERMINOLOGY.CONCEPT_MAP cm
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Description" d ON LOWER(d."Term") = LOWER(cm.SOURCE_DISPLAY)
    JOIN "Dictionary"."NHSD_SnomedReportingModel"."SCT_Concept" sc ON d."ConceptId" = sc."Id"
    WHERE cm.TARGET_CODE = '138875005'
      AND cm.SOURCE_DISPLAY IS NOT NULL
      AND d."Active" = TRUE
      AND sc."Active" = TRUE
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
    -- 1. Missing EMIS -> SNOMED (catalogue)
    SELECT
        'emis_snomed_coverage' AS check_name,
        'CONCEPT_MAP' AS table_name,
        'EMIS clinical codes with a SNOMED that have a CONCEPT_MAP row' AS test_subject,
        total - missing AS good_count,
        missing AS bad_count,
        total AS total_count
    FROM emis_coverage

    UNION ALL

    -- 1. Missing concept-map entry (in_use): distinct in-use UUIDs with no CONCEPT_MAP row
    SELECT
        'concept_map_in_use_missing',
        'CONCEPT_MAP',
        'In-use source_concept_id values that have a CONCEPT_MAP row',
        iut.n - m.missing,
        m.missing,
        iut.n
    FROM in_use_missing m, in_use_total iut

    UNION ALL

    -- 1 + term match: of in-use missing UUIDs, how many are fixable via SCT_Description term match
    SELECT
        'concept_map_in_use_missing_term_match',
        'CONCEPT_MAP',
        'In-use missing UUIDs resolvable via active SCT_Description term exact match (case-insensitive)',
        m.missing - tm.fixable,
        tm.fixable,
        m.missing
    FROM in_use_missing m, in_use_missing_term_match tm

    UNION ALL

    -- 2. Root target (catalogue) - rows that are NOT legitimately mapped
    SELECT
        'concept_map_root_target',
        'CONCEPT_MAP',
        'CONCEPT_MAP rows not erroneously pointing at SNOMED root (138875005)',
        total_cm_rows - (total_root_rows - legitimately_root),
        total_root_rows - legitimately_root,
        total_cm_rows
    FROM root_target_categories

    UNION ALL

    -- 2. Root target (in_use): root-target CM rows whose source UUID is in use
    SELECT
        'concept_map_in_use_root',
        'CONCEPT_MAP',
        'In-use source UUIDs not pointing at SNOMED root (138875005)',
        iut.n - r.bad,
        r.bad,
        iut.n
    FROM root_in_use r, in_use_total iut

    UNION ALL

    -- 2 + term match: root-target rows resolvable via SCT_Description term match
    SELECT
        'concept_map_root_term_match',
        'CONCEPT_MAP',
        'Root-targeting rows resolvable via active SCT_Description term exact match (case-insensitive)',
        total_root_rows - fixable_term_match,
        fixable_term_match,
        total_root_rows
    FROM root_term_match

    UNION ALL

    -- 2 breakdown
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

    -- 3. Retired target (catalogue)
    SELECT
        'concept_map_retired_target',
        'CONCEPT_MAP',
        'CONCEPT_MAP rows not pointing at a retired SNOMED concept',
        total - bad,
        bad,
        total
    FROM retired_target

    UNION ALL

    -- 3. Retired target (in_use)
    SELECT
        'concept_map_in_use_retired',
        'CONCEPT_MAP',
        'In-use source UUIDs not pointing at a retired SNOMED concept',
        iut.n - r.bad,
        r.bad,
        iut.n
    FROM retired_in_use r, in_use_total iut

    UNION ALL

    -- 3 + term match: retired-target rows resolvable via SCT_Description term match
    SELECT
        'concept_map_retired_term_match',
        'CONCEPT_MAP',
        'Retired-target rows resolvable via active SCT_Description term exact match (case-insensitive)',
        rt.bad - rtm.fixable,
        rtm.fixable,
        rt.bad
    FROM retired_target rt, retired_term_match rtm

    UNION ALL

    -- 4. Active SNOMED concepts not present as a CONCEPT_MAP target
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
