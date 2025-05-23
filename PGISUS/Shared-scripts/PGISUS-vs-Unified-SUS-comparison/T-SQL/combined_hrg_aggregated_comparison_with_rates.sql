-- Script: combined_hrg_aggregated_comparison_with_rates.sql
-- Purpose: Compares HRGs (Unified SUS/SUS+ vs. PGISUS) for both Outpatients and Inpatients,
--          including match/mismatch percentages, aggregated by Financial Year and Provider.
-- Data Sources: SUS.OP.EncounterDenormalised_DateRange, SUS.IP.EncounterDenormalised_DateRange
-- CORRECTION: Ensured MatchPercentage is calculated correctly as (Total - Mismatched) / Total.

SELECT
    'Outpatient' AS DataType,
	'SUS.OP.EncounterDenormalised_DateRange' as [DataSource],
    dv_FinYear,
    Organisation_Code_Code_of_Provider AS Trust,
    COUNT(1) AS TotalRecords,
    SUM(CASE WHEN [Core_HRG] <> [dv_HRG] -- Counts if Core_HRG is different from dv_HRG (includes one side NULL, other not)
             THEN 1 ELSE 0 END) AS MismatchedRecords,
    CAST(
        (
            (COUNT(1) - SUM(CASE WHEN [Core_HRG] <> [dv_HRG] THEN 1 ELSE 0 END)) * 100.0
        ) / NULLIF(COUNT(1), 0) -- Using NULLIF to prevent division by zero if a group had 0 records
    AS DECIMAL(5,2)) AS MatchPercentage,
    CAST(
        (
            SUM(CASE WHEN [Core_HRG] <> [dv_HRG] THEN 1 ELSE 0 END) * 100.0
        ) / NULLIF(COUNT(1), 0) -- Using NULLIF here too for safety
    AS DECIMAL(5,2)) AS MismatchRate
FROM
    SUS.OP.EncounterDenormalised_DateRange
WHERE
    dv_FinYear IN ('2019/2020','2020/2021','2021/2022', '2022/2023', '2023/2024', '2024/2025')
    AND Organisation_Code_Code_of_Provider IN ('RVR', 'RAX', 'RJ7', 'RPY', 'RJ6')
	AND Attended_Or_Did_Not_Attend in ('5','05','6','06')
GROUP BY
    dv_FinYear,
    Organisation_Code_Code_of_Provider

UNION ALL

SELECT
    'Inpatient' AS DataType,
	'SUS.IP.EncounterDenormalised_DateRange' as [DataSource],
    dv_FinYear,
    Organisation_Code_Code_of_Provider AS Trust,
    COUNT(1) AS TotalRecords,
    SUM(CASE WHEN [Spell_Core_HRG] <> [dv_HRG] -- Counts if Spell_Core_HRG is different from dv_HRG
             THEN 1 ELSE 0 END) AS MismatchedRecords,
    CAST(
        (
            (COUNT(1) - SUM(CASE WHEN [Spell_Core_HRG] <> [dv_HRG] THEN 1 ELSE 0 END)) * 100.0
        ) / NULLIF(COUNT(1), 0)
    AS DECIMAL(5,2)) AS MatchPercentage,
    CAST(
        (
            SUM(CASE WHEN [Spell_Core_HRG] <> [dv_HRG] THEN 1 ELSE 0 END) * 100.0
        ) / NULLIF(COUNT(1), 0)
    AS DECIMAL(5,2)) AS MismatchRate
FROM
    SUS.IP.EncounterDenormalised_DateRange
WHERE
    dv_FinYear IN ('2019/2020','2020/2021','2021/2022','2022/2023', '2023/2024', '2024/2025')
    AND Organisation_Code_Code_of_Provider IN ('RVR', 'RAX', 'RJ7', 'RPY', 'RJ6')
	AND dv_IsSpell = 1
GROUP BY
    dv_FinYear,
    Organisation_Code_Code_of_Provider
ORDER BY
    DataType,
    dv_FinYear,
    Trust;