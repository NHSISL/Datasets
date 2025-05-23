-- Script: combined_top_mismatched_hrg_pairs.sql
-- Purpose: Identifies the most frequent pairs of mismatched HRGs for both Outpatients and Inpatients
--          where Unified SUS/SUS+ HRGs and PGISUS dv_HRG do not align.
--          Includes DataType and DataSource.
-- Data Sources: SUS.OP.EncounterDenormalised_DateRange, SUS.IP.EncounterDenormalised_DateRange
-- Output: DataType, DataSource, SUS+ HRG, PGISUS dv_HRG, FinYear, Trust, and count of mismatch pair.

SELECT
    'Outpatient' AS DataType,
    'SUS.OP.EncounterDenormalised_DateRange' AS DataSource,
    [Core_HRG] AS SUS_Plus_HRG, -- Generic alias for easier downstream use
    [dv_HRG] AS PGISUS_dv_HRG,
    dv_FinYear,
    Organisation_Code_Code_of_Provider AS Trust,
    COUNT(1) AS CountOfMismatchPair
FROM
    SUS.OP.EncounterDenormalised_DateRange
WHERE
    dv_FinYear IN ('2022/2023', '2023/2024', '2024/2025')
    AND Organisation_Code_Code_of_Provider IN ('RVR', 'RAX', 'RJ7', 'RPY', 'RJ6')
    AND (
        ([Core_HRG] <> [dv_HRG])                           -- Different non-NULL values
        OR ([Core_HRG] IS NULL AND [dv_HRG] IS NOT NULL)   -- SUS+ HRG is NULL, PGISUS is not
        OR ([Core_HRG] IS NOT NULL AND [dv_HRG] IS NULL)   -- SUS+ HRG is not NULL, PGISUS is
    )
	AND Attended_Or_Did_Not_Attend in ('5','05','6','06')
GROUP BY
    [Core_HRG],
    [dv_HRG],
    dv_FinYear,
    Organisation_Code_Code_of_Provider

UNION ALL

SELECT
    'Inpatient' AS DataType,
    'SUS.IP.EncounterDenormalised_DateRange' AS DataSource,
    [Spell_Core_HRG] AS SUS_Plus_HRG, -- Generic alias
    [dv_HRG] AS PGISUS_dv_HRG,
    dv_FinYear,
    Organisation_Code_Code_of_Provider AS Trust,
    COUNT(1) AS CountOfMismatchPair
FROM
    SUS.IP.EncounterDenormalised_DateRange
WHERE
    dv_FinYear IN ('2022/2023', '2023/2024', '2024/2025')
    AND Organisation_Code_Code_of_Provider IN ('RVR', 'RAX', 'RJ7', 'RPY', 'RJ6')
    AND (
        ([Spell_Core_HRG] <> [dv_HRG])
        OR ([Spell_Core_HRG] IS NULL AND [dv_HRG] IS NOT NULL)
        OR ([Spell_Core_HRG] IS NOT NULL AND [dv_HRG] IS NULL)
    )
	AND dv_IsSpell = 1
GROUP BY
    [Spell_Core_HRG],
    [dv_HRG],
    dv_FinYear,
    Organisation_Code_Code_of_Provider

ORDER BY
    CountOfMismatchPair DESC, -- Show most frequent mismatches first overall
    DataType,                 -- Then by DataType
    dv_FinYear,
    Trust,
    SUS_Plus_HRG,             -- Further ordering for consistency if counts are the same
    PGISUS_dv_HRG;