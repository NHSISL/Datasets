CREATE VIEW [StarMart].[AE_EncounterBillingRepriced]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_Encounter_ID] = [EM].[Generated Record ID] -- for backwards compatibility
	--
	,[SK_Costing_Algorithm_ID] = [Grouper].[SK_CostingAlgorithmID_AE]
	,[dv_Month] = [EM].[ActivityPeriod]
	--
	,[Organisation_Code_Code_Of_Provider] = [EM].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [EM].[Organisation Code (Code Of Commissioner)]
	--
	,[AE_Department_Type] = [EM].[EM Department Type]
	,[dv_POD_Description] = [AE_Billing].[dmicLocalPODCode]
	,[dv_Local_Cost_Code] = [AE_Billing].[dmicBusinessRuleCodes]
	,[dv_HRG_Code] = TRY_CAST(COALESCE([AE_Billing].[dmicTariffHRG], [AE_Billing].[dmicNonStreamingHrgCode]) AS VARCHAR(5))
	--
	,[Tariff_Total_Payment_National] = [EM].[Tariff Total Payment National]
	--
	,[dv_Base_Cost] = [AE_Billing].[Unrounded Total Tariff]
	,[dv_MFF_Index_Applied] = [AE_Billing].[Market Forces Factor]
	,[dv_Total_Cost] = [AE_Billing].[Unrounded Total Tariff Including MFF]
	--
	,[dv_Is_Pbr] = TRY_CAST(CASE 
			WHEN [AE_Billing].[dmicCostType] = 'Tariff'
				THEN 1
			ELSE 0
			END AS BIT)
	--
	,[SK_DateID] = TRY_CAST(CONVERT(VARCHAR, EOMONTH([EM].[ActivityDate]), 112) AS INT)
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM]
INNER JOIN [Casted].[AE_Billing] AS [AE_Billing]
	ON ([EM].[Generated Record ID] = [AE_Billing].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[AE_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [AE_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [AE_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [Grouper].[IsActive] = 1
			)
WHERE NOT (
		[AE_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
		AND [Grouper].[IsInYearCost] = 1
		);
