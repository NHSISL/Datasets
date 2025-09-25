CREATE VIEW [Casted].[IP_pbr_preprocess_EP_SpellRecordCount]
AS
SELECT [EP].[Spell Identifier]
	,COUNT([EP].[Generated Record ID]) AS [SpellRecordCount]
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_Billing] AS [BI]
	ON ([EP].[Generated Record ID] = [BI].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[BI].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [BI].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [BI].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [BI].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
			AND [Grouper].[IsInYearCost] = 1
			)
GROUP BY [EP].[Spell Identifier];
