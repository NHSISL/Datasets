CREATE VIEW [StarMart].[IP_EncounterBillingRepricedUnbundled]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID] -- for backwards compatibility
	,[Spell_Identifier] = [EP].[Spell Identifier]
	--
	,[dv_Unbundled_Number] = TRY_CAST(ROW_NUMBER() OVER (
			PARTITION BY [EP].[Generated Record ID] ORDER BY [IP_Billing_Unbundled].[dmicTariffHRG] ASC
			) AS INT)
	--
	,[SK_Costing_Algorithm_ID] = [Grouper].[SK_CostingAlgorithmID_IP]
	,[dv_Month] = [EP].[ActivityPeriod]
	--
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [EP].[Organisation Code (Code Of Commissioner)]
	--
	,[dv_POD_Description] = [IP_Billing_Unbundled].[dmicLocalPODCode]
	,[dv_HRG_Code] = [IP_Billing_Unbundled].[dmicTariffHRG]
	,[dv_Number_Of_Days] = [IP_Billing_Unbundled].[Days]
	--
	,[dv_Base_Tariff] = [IP_Billing_Unbundled].[Unrounded Total Tariff]
	,[dv_MFF_Index_Applied] = [IP_Billing_Unbundled].[Market Forces Factor]
	,[dv_MFF_Adjustment] = [IP_Billing_Unbundled].[Market Forces Factor Adjustment]
	,[dv_Total_Cost] = [IP_Billing_Unbundled].[Unrounded Total Tariff Including MFF]
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_EP_SpellRecordCount] AS [SS]
	ON ([EP].[Spell Identifier] = [SS].[Spell Identifier])
INNER JOIN [Casted].[IP_Billing_Unbundled] AS [IP_Billing_Unbundled]
	ON ([EP].[Generated Record ID] = [IP_Billing_Unbundled].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[IP_Billing_Unbundled].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [IP_Billing_Unbundled].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [IP_Billing_Unbundled].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [Grouper].[IsActive] = 1
			)
WHERE (
		(
			[EP].[Generated Record ID] = [SS].[Spell Identifier]
			AND [SS].[SpellRecordCount] > 1
			)
		OR [SS].[SpellRecordCount] = 1
		)
	AND NOT (
		[IP_Billing_Unbundled].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
		AND [Grouper].[IsInYearCost] = 1
		);
