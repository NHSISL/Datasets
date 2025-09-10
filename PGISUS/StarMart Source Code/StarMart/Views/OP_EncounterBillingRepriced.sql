CREATE VIEW [StarMart].[OP_EncounterBillingRepriced]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	--
	,[SK_Costing_Algorithm_ID] = [Grouper].[SK_CostingAlgorithmID_OP]
	,[dv_Month] = [OP].[ActivityPeriod]
	--
	,[Organisation_Code_Code_Of_Provider] = [OP].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [OP].[Organisation Code (Code Of Commissioner)]
	--
	,[dv_POD_Description] = [OP_Billing].[dmicPODCode]
	,[dv_Local_Cost_Code] = [OP_Billing].[dmicBusinessRuleCodes]
	,[dv_HRG_Code] = [OP_Billing].[dmicTariffHRG]
	--
	,[Direct_Access_Tariff_Flag] = [OP].[Direct Access Tariff Flag]
	,[dv_Is_Direct_Access_Indicator] = [OP_Billing].[dmicIsDirectAccessIndicator]
	--
	,[Number_Unbundled_HRGs] = [OP].[Number Unbundled HRGs]
	,[Number_Unbundled_Non_Priced_HRGs] = [OP].[Number Unbundled Non Priced HRGs]
	,[Number_Unbundled_Priced_HRGs] = [OP].[Number Unbundled Priced HRGs]
	--
	,[PBR_Final_Tariff] = [OP].[PbR Final Tariff]
	--
	,[dv_Base_Cost] = ISNULL([OP_Billing].[Unrounded Total Tariff], 0) - ISNULL([OP_Billing].[Unrounded Total Unbundled Tariff], 0)
	,[dv_MFF_Index_Applied] = [OP_Billing].[Market Forces Factor]
	,[dv_Total_Cost] = ISNULL([OP_Billing].[Unrounded Total Tariff Including MFF], 0) - ISNULL([OP_Billing].[Unrounded Total Unbundled Tariff Including MFF], 0) -- CHECK WITH DEREK
	--
	,[dv_Is_Pbr] = CASE 
		WHEN [OP_Billing].[dmicCostType] = 'Tariff'
			THEN 1
		ELSE 0
		END
	--
	,[dv_Is_Specialist_Commissioner] = CASE 
		WHEN COALESCE([OP].[Spell Service Line], [OP_Billing].[dmicSpecialisedServiceLineCode]) IS NULL
			THEN 0
		ELSE 1
		END
	,[Specialist_Commissioning_Service_Line_Code_National] = [OP].[Spell Service Line]
	,[dv_Specialist_Commissioning_Service_Line_Code_Local] = [OP_Billing].[dmicSpecialisedServiceLineCode]
	,[Spell_NPOC] = [OP].[Spell NPOC]
	--
	,[SK_Date_ID] = TRY_CAST(CONVERT(VARCHAR, EOMONTH([OP].[ActivityDate]), 112) AS INT)
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
INNER JOIN [Casted].[OP_Billing] AS [OP_Billing]
	ON ([OP].[Generated Record ID] = [OP_Billing].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[OP_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [OP_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [OP_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [Grouper].[IsActive] = 1
			)
WHERE [OP].[Attended Or Did Not Attend] IN (5, 6)
	AND NOT (
		[OP_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
		AND [Grouper].[IsInYearCost] = 1
		);
