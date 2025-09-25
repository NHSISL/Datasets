CREATE VIEW [StarMart].[OP_EncounterBillingUnbundledRepriced]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	--
	,[dv_Unbundled_Number] = TRY_CAST(ROW_NUMBER() OVER (
			PARTITION BY [OP].[Generated Record ID] ORDER BY [OP_Billing_Unbundled].[dmicTariffHRG] ASC
			) AS INT)
	--
	,[SK_Costing_Algorithm_ID] = [Grouper].[SK_CostingAlgorithmID_OP]
	,[dv_Month] = [OP].[ActivityPeriod]
	--
	,[Organisation_Code_Code_Of_Provider] = [OP].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [OP].[Organisation Code (Code Of Commissioner)]
	--
	,[dv_POD_Description] = [OP_Billing_Unbundled].[dmicLocalPODCode]
	,[dv_HRG_Code] = [OP_Billing_Unbundled].[dmicTariffHRG]
	--
	,[dv_Base_Tariff] = [OP_Billing_Unbundled].[Unrounded Total Tariff]
	,[dv_MFF_Index_Applied] = [OP_Billing_Unbundled].[Market Forces Factor]
	,[dv_MFF_Adjustment] = [OP_Billing_Unbundled].[Market Forces Factor Adjustment]
	,[dv_Total_Cost] = [OP_Billing_Unbundled].[Unrounded Total Tariff Including MFF]
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
INNER JOIN [Casted].[OP_Billing_Unbundled] AS [OP_Billing_Unbundled]
	ON ([OP].[Generated Record ID] = [OP_Billing_Unbundled].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[OP_Billing_Unbundled].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [OP_Billing_Unbundled].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [OP_Billing_Unbundled].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [Grouper].[IsActive] = 1
			)
WHERE [OP].[Attended Or Did Not Attend] IN (5, 6)
	AND NOT (
		[OP_Billing_Unbundled].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
		AND [Grouper].[IsInYearCost] = 1
		);
