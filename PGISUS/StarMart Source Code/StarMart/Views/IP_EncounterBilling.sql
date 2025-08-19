CREATE VIEW [StarMart].[IP_EncounterBilling]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID] -- for backwards compatibility
	,[Spell_Identifier] = [EP].[Spell Identifier]
	--
	,[SK_Costing_Algorithm_ID] = [Grouper].[SK_CostingAlgorithmID_IP]
	,[dv_Month] = [EP].[ActivityPeriod]
	--
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [EP].[Organisation Code (Code Of Commissioner)]
	--
	,[dv_POD_Description] = [IP_Billing].[dmicLocalPODCode]
	,[dv_Local_Cost_Code] = [IP_Billing].[dmicBusinessRuleCodes]
	,[dv_HRG_Code] = [IP_Billing].[dmicTariffHRG]
	,[dv_Special_Service_Code] = [IP_Billing].[dmicSSCCode]
	,[dv_Best_Practice_Tariff_Code] = [IP_Billing].[dmicBestPracticeCode]
	--
	,[dv_Is_Short_Stay] = TRY_CAST(CASE 
			WHEN [IP_Billing].[dmicNationalPODCode] LIKE 'NELST%'
				THEN 1
			ELSE 0
			END AS BIT)
	--
	,[dv_Excess_Bed_Days] = COALESCE([IP_Billing].[dmicExcessBedDays], [IP_Billing].[dmicPbRExcessBedDays])
	,[dv_Special_Palliative_Care_Days] = [IP_Billing].[SpecialCareDays]
	,[dv_Rehabilitation_Days] = [IP_Billing].[RehabilitationDays]
	,[dv_Critical_Care_Days] = TRY_CAST(CASE 
			WHEN [CC].[dv_AnyCCExclusionsInSpell] = 1
				THEN [IP_Billing].[dmicAdultCriticalCareDays]
			ELSE [CC].[dv_Total_ACC_Days_For_LOS]
			END AS INT)
	,[dv_Adjusted_Final_Length_Of_Stay] = [IP_Billing].[dmicSpellLengthOfStay]
	--
	,[dv_Ward_Code_At_Admission] = [IP_Billing].[dmicAdmissionWardCode]
	,[dv_Ward_Code_At_Discharge] = [IP_Billing].[dmicDischargeWardCode]
	--
	,[Number_Unbundled_HRGs] = [EP].[Number Unbundled HRGs]
	,[Number_Unbundled_Non_Priced_HRGs] = [EP].[Number Unbundled Non Priced HRGs]
	,[Number_Unbundled_Priced_HRGs] = [EP].[Number Unbundled Priced HRGs]
	--
	,[dv_Delayed_Discharge_Adjustment] = [IP_Billing].[dmicDelayedDischargeAdjustment]
	,[dv_Excess_Bed_Days_Adjustment] = ROUND([IP_Billing].[Excess Bed Days Adjustment] * [IP_Billing].[Market Forces Factor], 0)
	,[dv_Service_Adjustment_Applied] = [IP_Billing].[SSC Tariff Adjustment] * [IP_Billing].[Market Forces Factor]
	,[dv_Applicable_Tariff] = [IP_Billing].[Base National Tariff]
	,[PBR_Final_Tariff] = [EP].[PbR Final Tariff]
	--
	,[dv_Base_Cost] = [IP_Billing].[Base National Tariff]
	,[dv_MFF_Index_Applied] = [IP_Billing].[Market Forces Factor]
	,[dv_Total_Cost] = [IP_Billing].[Unrounded Total Tariff Excluding Unbundled Including MFF]
	--
	,[dv_Is_Pbr] = CASE 
		WHEN [IP_Billing].[dmicCostType] = 'Tariff'
			THEN 1
		ELSE 0
		END
	--
	,[dv_Is_Specialist_Commissioner] = CASE 
		WHEN COALESCE([EP].[Spell Service Line], [IP_Billing].[dmicSpellSpecialisedServiceLine]) IS NULL
			THEN 0
		ELSE 1
		END
	,[SC_Service_Line_Code_National] = [EP].[FCE Service Line]
	,[SC_Service_Line_Code_National_Spell] = [EP].[Spell Service Line]
	,[dv_SC_Service_Line_Code_Local] = [IP_Billing].[dmicSpecialisedServiceLineCode]
	,[dv_SC_Service_Line_Code_Local_Spell] = [IP_Billing].[dmicSpellSpecialisedServiceLine]
	,[Spell_NPOC] = [EP].[Spell NPOC]
	--
	,[SK_Date_ID] = TRY_CAST(CONVERT(VARCHAR, EOMONTH([EP].[ActivityDate]), 112) AS INT)
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_EP_SpellRecordCount] AS [SS]
	ON ([EP].[Spell Identifier] = [SS].[Spell Identifier])
INNER JOIN [Casted].[IP_Billing] AS [IP_Billing]
	ON ([EP].[Generated Record ID] = [IP_Billing].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[IP_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [IP_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [IP_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [IP_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
			AND [Grouper].[IsInYearCost] = 1
			)
OUTER APPLY (
	SELECT [dv_AnyCCExclusionsInSpell] = TRY_CAST(MAX(CASE 
					WHEN [CC].[PBR CC Indicator] IS NOT NULL
						OR [CC].[Excluded Reason] IS NOT NULL
						THEN 1
					ELSE 0
					END) AS BIT)
		,[dv_Total_ACC_Days_For_LOS] = SUM([CC].[CC Days For LOS])
	FROM [Casted].[IP_pbr_preprocess_CC] AS [CC]
	WHERE [CC].[Critical Care Type] = 'ACC'
		AND [CC].[Spell Identifier] = [EP].[Generated Record ID]
	) AS [CC]
WHERE (
		(
			[EP].[Generated Record ID] = [SS].[Spell Identifier]
			AND [SS].[SpellRecordCount] > 1
			)
		OR [SS].[SpellRecordCount] = 1
		);
