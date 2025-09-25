CREATE VIEW [Denormalised].[vIP_EncounterDenormalised]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[dv_Extract_Type] = TRY_CAST(CONCAT (
			'SUSPlus Mart IP '
			,STUFF([XX].[FiscalYear], 6, 2, '')
			,' Commissioner - '
			,CASE '$(SUSDataMartID)' /*[SK_SUSDataMartID]*/
				WHEN 12 -- PGISUS Rec/PostRec
					THEN 'PostRec'
				WHEN 13 -- PGISUS DateRange
					THEN 'Date Range'
				END
			) AS VARCHAR(200))
	,[dv_Query_ID] = TRY_CAST('APCEP_MAIN' AS VARCHAR(10))
	,[dv_Fiscal_Year] = TRY_CAST([XX].[FiscalYear] AS VARCHAR(30))
	,[dv_Fiscal_Month] = TRY_CAST(MONTH([XX].[FiscalActivityDate]) AS TINYINT)
	,[dv_Activity_Period_Date] = TRY_CAST(CONVERT(VARCHAR, [EP].[ActivityDate], 112) AS INT)
	--
	,[CDS_Record_Type] = [EP].[CDS Record Type]
	,[Spell_Identifier] = [EP].[Spell Identifier]
	,[Unique_CDS_Identifier] = TRY_CAST([PID].[Unique CDS Identifier] AS VARCHAR(35))
	,[Hospital_Provider_Spell_No] = TRY_CAST([PID].[Hospital Provider Spell No] AS VARCHAR(20))
	,[Ambulance_Incident_Number] = [CDS62_EP].[Ambulance Incident Number]
	--
	,[Referrer_Code] = [EP].[Referrer Code]
	,[Referring_Organisation_Code] = [EP].[Referring Organisation Code]
	,[Organisation_Code_Patient_Pathway_Identifier] = [EP].[Organisation Code Patient Pathway Identifier]
	,[RTT_Patient_Pathway_Identifier] = TRY_CAST([PID].[RTT Patient Pathway Identifier] AS VARCHAR(20)) -- NULL'd on Prem
	,[RTT_Period_Start_Date] = [EP].[RTT Period Start Date]
	,[RTT_Period_End_Date] = [EP].[RTT Period End Date]
	,[RTT_Length_Derived] = [EP].[RTT Length (Derived)] -- Note: Not actually dv_ anymore
	,[RTT_Status] = [EP].[RTT Status]
	--
	,[Decided_To_Admit_Date] = [EP].[Decided To Admit Date]
	,[Episode_Start_Date] = [EP].[Episode Start Date]
	,[Episode_End_Date] = [EP].[Episode End Date]
	,[dv_Episode_Gross_Length_Of_Stay] = TRY_CAST(DATEDIFF(DD, [EP].[Episode Start Date], [EP].[Episode End Date]) AS INT) -- Is non-dv available?
	,[Episode_Number] = [EP].[Episode Number]
	,[Last_Episode_In_Spell_Indicator] = [EP].[Last Episode In Spell Indicator]
	,[Start_Date_Hospital_Provider_Spell] = [EP].[Start Date (Hospital Provider Spell)]
	,[Start_Time_Hospital_Provider_Spell] = [CDS62_EP].[Start Time (Hospital Provider Spell)]
	,[End_Date_Hospital_Provider_Spell] = [EP].[End Date (Hospital Provider Spell)]
	,[Discharge_Time_Hospital_Provider_Spell] = [CDS62_EP].[Discharge Time (Hospital Provider Spell)]
	,[Ready_For_Discharge_Date] = [EP].[Ready For Discharge Date]
	,[dv_Spell_Gross_Length_Of_Stay] = TRY_CAST([EP].[Length Of Stay (Hospital Provider Spell)] AS INT) -- Name Change? ([Length_Of_Stay_Hospital_Provider_Spell])
	,[CDS_Activity_Date] = [EP].[CDS Activity Date] -- Note: Not actually dv_ anymore
	--
	,[Source_Of_Admission_Hospital_Provider_Spell] = [EP].[Source Of Admission (Hospital Provider Spell)]
	,[Discharge_Destination_Hospital_Provider_Spell] = [EP].[Discharge Destination (Hospital Provider Spell)]
	,[Discharge_Method_Hospital_Provider_Spell] = [EP].[Discharge Method (Hospital Provider Spell)]
	,[Discharged_To_HaH_Service_Indicator] = [CDS62_EP].[Discharged To HaH Service Indicator]
	,[Administrative_Category_On_Admission] = [EP].[Administrative Category (On Admission)]
	,[First_Regular_Day_Night_Admission] = [EP].[First Regular Day Night Admission]
	,[Intended_Management] = [EP].[Intended Management]
	,[Patient_Classification] = [EP].[Patient Classification]
	,[Admission_Method_Hospital_Provider_Spell] = [EP].[Admission Method (Hospital Provider Spell)]
	,[Age_Group_Intended_At_Epiend] = [EP].[Age Group Intended At Epiend]
	,[Neonatal_Level_Of_Care] = [EP].[Neonatal Level Of Care]
	,[Legal_Status_Classification_Code] = [EP].[Legal Status Classification Code]
	,[Rehabilitation_Assessment_Team_Type] = [CDS62_EP].[Rehabilitation Assessment Team Type]
	,[Psychiatric_Patient_Status_Code] = [CDS62_EP].[Psychiatric Patient Status Code]
	--
	,[Number_Diagnoses] = [EP].[Number Diagnosis] -- Note: Not actually dv_ anymore
	,[Number_Procedures] = [EP].[Number Procedures] -- Note: Not actually dv_ anymore
	,[Number_Unbundled_HRGs] = [EP].[Number Unbundled HRGs] -- Note: Not actually dv_ anymore
	--
	,[SK_Patient_ID] = TRY_CAST([PID].[SK_PatientID] AS INT)
	,[Withheld_Identity_Reason] = [CDS62_EP].[Withheld Identity Reason]
	,[Confidentiality_Category] = [EP].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [EP].[NHS Number Status Indicator]
	--
	,[Local_Patient_Identifier] = TRY_CAST([PID].[Local Patient Identifier] AS VARCHAR(30))
	,[Carer_Support_Indicator] = [EP].[Carer Support Indicator]
	,[Ethnic_Category_Code] = [EP].[Ethnic Category Code]
	,[Age_At_CDS_Activity_Date] = [EP].[Age At CDS Activity Date]
	,[Birth_Date] = TRY_CAST([PID].[dv_Birth Date (Rounded)] AS DATE)
	,[dv_Birth_Year] = TRY_CAST(YEAR([PID].[dv_Birth Date (Rounded)]) AS INT)
	,[Gender_Code] = [EP].[Gender Code]
	,[Postcode_Of_Usual_Address] = TRY_CAST([PID].[dv_Pseudo_Postcode] AS VARCHAR(8))
	,[dv_LSOA_Code] = TRY_CAST([PID].[dv_LSOA] AS VARCHAR(9))
	--
	,[GP_Code_Original_Data] = [EP].[GP Code (Original Data)]
	,[GP_Practice_Code_Original_Data] = [EP].[GP Practice Code (Original Data)]
	,[GP_Practice_Code_Derived] = [EP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = TRY_CAST([EP].[GP Practice Derived From PDS] AS BIT)
	--
	,[Provider_Reference_No] = TRY_CAST([PID].[Provider Reference No] AS VARCHAR(17))
	,[Commissioner_Reference_No] = TRY_CAST([PID].[Commissioner Reference No] AS VARCHAR(17))
	,[Commissioner_Serial_No_Agreement_No] = TRY_CAST([PID].[Commissioning Serial No (Agreement No)] AS VARCHAR(6))
	,[NHS_Service_Agreement_Line_No] = TRY_CAST([PID].[NHS Service Agreement Line No] AS VARCHAR(10))
	--
	,[Consultant_Code] = [EP].[Consultant Code]
	,[Main_Specialty_Code] = [EP].[Main Specialty Code]
	,[Treatment_Function_Code] = [EP].[Treatment Function Code]
	,[Local_Sub_Specialty_Code] = [CDS62_EP].[Local Sub Specialty Code]
	,[Ward_Code_At_Episode_Start_Date] = [EP].[Ward Code At Episode Start Date]
	,[Ward_Code_At_Episode_End_Date] = [EP].[Ward Code At Episode End Date]
	,[dv_Ward_Code_At_Admission] = [IP_Billing].[dmicAdmissionWardCode]
	,[dv_Ward_Code_At_Discharge] = [IP_Billing].[dmicDischargeWardCode]
	--
	,[dv_Specialist_Commissioning_Service_Code_National_Episode] = [EP].[FCE Service Line]
	,[dv_Specialist_Commissioning_Service_Code_National_Spell] = [EP].[Spell Service Line]
	,[dv_Specialist_Commissioning_Service_Code_Local_Episode] = [IP_Billing].[dmicSpecialisedServiceLineCode]
	,[dv_Specialist_Commissioning_Service_Code_Local_Spell] = [IP_Billing].[dmicSpellSpecialisedServiceLine]
	,[Spell_NPOC] = [EP].[Spell NPOC]
	,[Programme_Budgeting_Category] = [EP].[Programme Budgeting Category]
	--
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_EP].[OSV Status Classification At CDS Activity Date]
	,[OSV_Status_Classification_1] = [CDS62_EP].[OSV Status Classification 1]
	,[OSV_Status_Classification_2] = [CDS62_EP].[OSV Status Classification 2]
	,[OSV_Status_Classification_3] = [CDS62_EP].[OSV Status Classification 3]
	,[OSV_Status_Classification_4] = [CDS62_EP].[OSV Status Classification 4]
	,[OSV_Status_Classification_5] = [CDS62_EP].[OSV Status Classification 5]
	--
	,[Organiastion_Code_Conveying_Ambulance_Trust] = [CDS62_EP].[Organisation Code (Conveying Ambulance Trust)]
	,[Provider_Code_Original_Data] = [EP].[Provider Code (Original Data)]
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	,[Site_Code_Of_Treatment_At_Start_Of_Episode] = [EP].[Site Code Of Treatment (At Start Of Episode)]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [EP].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_PCT_Of_Residence] = [EP].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_Original_Data] = [EP].[Commissioner Code (Original Data)]
	,[PCT_Derived_From_GP_Practice] = [EP].[PCT Derived From GP Practice]
	,[Patient_Postcode_Derived_PCT] = [EP].[Patient Postcode Derived PCT]
	,[Derived_Commissioner] = [EP].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [EP].[Derived Commissioner Type]
	--
	,[dv_Commissioner_Code_Of_Residence] = TRY_CAST([EP].[Organisation Code (PCT Of Residence)] AS INT)
	,[dv_Purchaser_ID] = TRY_CAST([EP].[Organisation Code (Code Of Commissioner)] AS VARCHAR(15))
	--
	,[Core_HRG_Calculated] = [EP].[Core HRG (Calculated)]
	,[Spell_Core_HRG] = [EP].[Spell Core HRG]
	--
	,[dv_HRG] = TRY_CAST([IP_Billing].[dmicTariffHRG] AS VARCHAR(5))
	,[dv_Local_Cost_Code] = TRY_CAST([IP_Billing].[dmicBusinessRuleCodes] AS VARCHAR(30))
	,[Spell_In_Pbr_Not_In_Pbr] = [EP].[Spell In PbR/Not In PbR]
	--
	,[dv_Is_PBR] = TRY_CAST(CASE 
			WHEN [IP_Billing].[dmicCostType] = 'Tariff'
				THEN 1
			ELSE 0
			END AS BIT)
	,[dv_Applicable_Tariff] = TRY_CAST([IP_Billing].[Base National Tariff] AS REAL)
	,[dv_Base_Cost] = TRY_CAST([IP_Billing].[Base National Tariff] AS REAL)
	,[dv_Is_Short_Stay] = TRY_CAST(CASE 
			WHEN [IP_Billing].[dmicNationalPODCode] LIKE 'NELST%'
				THEN 1
			ELSE 0
			END AS BIT)
	,[dv_Special_Service_Code] = TRY_CAST([IP_Billing].[dmicSSCCode] AS VARCHAR(5))
	,[dv_Service_Adjustment_Cost] = TRY_CAST([IP_Billing].[SSC Tariff Adjustment] * [IP_Billing].[Market Forces Factor] AS REAL)
	,[dv_Best_Practice_Tariff_Code] = TRY_CAST([IP_Billing].[dmicBestPracticeCode] AS VARCHAR(5))
	,[dv_Specialist_Palliative_Care_Days] = TRY_CAST([IP_Billing].[SpecialCareDays] AS INT)
	,[dv_Rehabilitation_Days] = TRY_CAST([IP_Billing].[RehabilitationDays] AS INT)
	,[dv_Delayed_Discharge_Days] = TRY_CAST([IP_Billing].[dmicDelayedDischargeAdjustment] AS INT)
	,[dv_Tariff_Type] = TRY_CAST('SUS+' AS VARCHAR(5))
	,[dv_Length_Of_Stay_Net] = TRY_CAST([IP_Billing].[dmicSpellLengthOfStay] AS SMALLINT)
	,[dv_Excess_Bed_Days] = TRY_CAST(COALESCE([IP_Billing].[dmicExcessBedDays], [IP_Billing].[dmicPbRExcessBedDays]) AS INT)
	,[dv_Excess_Bed_Days_Cost] = TRY_CAST([IP_Billing].[Excess Bed Days Adjustment] * [IP_Billing].[Market Forces Factor] AS REAL)
	,[dv_MFF_Index_Applied] = TRY_CAST([IP_Billing].[Market Forces Factor] AS REAL)
	,[PbR_Final_Tariff] = [EP].[PbR Final Tariff]
	,[dv_Total_Cost_Inc_MFF] = TRY_CAST([IP_Billing].[Unrounded Total Tariff Excluding Unbundled Including MFF] AS MONEY)
	,[dv_Is_Spell] = TRY_CAST(CASE 
			WHEN [IP_Billing].[Unrounded Total Tariff Excluding Unbundled Including MFF] IS NOT NULL
				THEN 1
			ELSE 0
			END AS BIT)
	--
	,[Primary_Diagnosis_Code] = [EP].[Primary Diagnosis Code]
	,[Secondary_Diagnosis_Code_1] = [EP].[Secondary Diagnosis Code 1]
	,[Secondary_Diagnosis_Code_2] = [EP].[Secondary Diagnosis Code 2]
	,[Secondary_Diagnosis_Code_3] = [EP].[Secondary Diagnosis Code 3]
	,[Secondary_Diagnosis_Code_4] = [EP].[Secondary Diagnosis Code 4]
	,[Secondary_Diagnosis_Code_5] = [EP].[Secondary Diagnosis Code 5]
	,[Secondary_Diagnosis_Code_6] = [EP].[Secondary Diagnosis Code 6]
	,[Secondary_Diagnosis_Code_7] = [EP].[Secondary Diagnosis Code 7]
	,[Secondary_Diagnosis_Code_8] = [EP].[Secondary Diagnosis Code 8]
	,[Secondary_Diagnosis_Code_9] = [EP].[Secondary Diagnosis Code 9]
	,[Secondary_Diagnosis_Code_10] = [EP].[Secondary Diagnosis Code 10]
	,[Secondary_Diagnosis_Code_11] = [EP].[Secondary Diagnosis Code 11]
	,[Secondary_Diagnosis_Code_12] = [EP].[Secondary Diagnosis Code 12]
	--
	,[Operation_Status] = [EP].[Operation Status]
	,[Primary_Procedure_Code] = [EP].[Primary Procedure Code]
	,[Primary_Procedure_Date] = [EP].[Primary Procedure Date]
	,[Secondary_Procedure_Code_1] = [EP].[Secondary Procedure Code 1]
	,[Secondary_Procedure_Date_1] = [EP].[Secondary Procedure Date 1]
	,[Secondary_Procedure_Code_2] = [EP].[Secondary Procedure Code 2]
	,[Secondary_Procedure_Date_2] = [EP].[Secondary Procedure Date 2]
	,[Secondary_Procedure_Code_3] = [EP].[Secondary Procedure Code 3]
	,[Secondary_Procedure_Date_3] = [EP].[Secondary Procedure Date 3]
	,[Secondary_Procedure_Code_4] = [EP].[Secondary Procedure Code 4]
	,[Secondary_Procedure_Date_4] = [EP].[Secondary Procedure Date 4]
	,[Secondary_Procedure_Code_5] = [EP].[Secondary Procedure Code 5]
	,[Secondary_Procedure_Date_5] = [EP].[Secondary Procedure Date 5]
	,[Secondary_Procedure_Code_6] = [EP].[Secondary Procedure Code 6]
	,[Secondary_Procedure_Date_6] = [EP].[Secondary Procedure Date 6]
	,[Secondary_Procedure_Code_7] = [EP].[Secondary Procedure Code 7]
	,[Secondary_Procedure_Date_7] = [EP].[Secondary Procedure Date 7]
	,[Secondary_Procedure_Code_8] = [EP].[Secondary Procedure Code 8]
	,[Secondary_Procedure_Date_8] = [EP].[Secondary Procedure Date 8]
	,[Secondary_Procedure_Code_9] = [EP].[Secondary Procedure Code 9]
	,[Secondary_Procedure_Date_9] = [EP].[Secondary Procedure Date 9]
	,[Secondary_Procedure_Code_10] = [EP].[Secondary Procedure Code 10]
	,[Secondary_Procedure_Date_10] = [EP].[Secondary Procedure Date 10]
	,[Secondary_Procedure_Code_11] = [EP].[Secondary Procedure Code 11]
	,[Secondary_Procedure_Date_11] = [EP].[Secondary Procedure Date 11]
	,[Secondary_Procedure_Code_12] = [EP].[Secondary Procedure Code 12]
	,[Secondary_Procedure_Date_12] = [EP].[Secondary Procedure Date 12]
	--
	,[Unbundled_HRG_1] = [EP].[Unbundled HRG 1] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_2] = [EP].[Unbundled HRG 2] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_3] = [EP].[Unbundled HRG 3] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_4] = [EP].[Unbundled HRG 4] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_5] = [EP].[Unbundled HRG 5] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_6] = [EP].[Unbundled HRG 6] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_7] = [EP].[Unbundled HRG 7] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_8] = [EP].[Unbundled HRG 8] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_9] = [EP].[Unbundled HRG 9] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_10] = [EP].[Unbundled HRG 10] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_11] = [EP].[Unbundled HRG 11] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_12] = [EP].[Unbundled HRG 12] -- Note: Not actually dv_ anymore
	--
	,[dv_Unbundled_Days_Total] = TRY_CAST([IP_Billing_Unbundled_AGG].[dv_Unbundled_Days_Total] AS INT)
	,[dv_Unbundled_Cost_Total] = TRY_CAST([IP_Billing_Unbundled_AGG].[dv_Unbundled_Cost_Total] AS INT)
	,[dv_Critical_Care_Day_Count] = TRY_CAST([IP_Billing].[dmicAdultCriticalCareDays] AS INT)
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_EP_SpellRecordCount] AS [SS]
	ON ([EP].[Spell Identifier] = [SS].[Spell Identifier])
INNER JOIN [Casted].[IP_pbr_preprocess_EP_Pseudo] AS [PID]
	ON ([EP].[Generated Record ID] = [PID].[Generated Record ID])
-- IP Records may have a billing record, if they do it must be the In Year Cost.
LEFT JOIN (
	SELECT [IP_Billing].*
	FROM [Casted].[IP_Billing] AS [IP_Billing]
	INNER JOIN [dbo].[Grouper] AS [Grouper]
		ON (
				[IP_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
				AND [IP_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
				AND [IP_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
				AND [IP_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
				AND [Grouper].[IsInYearCost] = 1
				)
	) AS [IP_Billing]
	ON ([EP].[Generated Record ID] = [IP_Billing].[Generated Record ID])
OUTER APPLY (
	SELECT [dv_Unbundled_Days_Total] = SUM(ISNULL([Days], 0))
		,[dv_Unbundled_Cost_Total] = SUM(ISNULL([Unrounded Total Tariff Including MFF], 0))
	FROM [Casted].[IP_Billing_Unbundled] AS [IP_Billing_Unbundled]
	WHERE [EP].[Generated Record ID] = [IP_Billing_Unbundled].[Generated Record ID]
		AND [IP_Billing].[dmicPSSGrouperVersion] = [IP_Billing_Unbundled].[dmicPSSGrouperVersion]
		AND [IP_Billing].[dmicGrouperVersion] = [IP_Billing_Unbundled].[dmicGrouperVersion]
		AND [IP_Billing].[dmicRuleFinancialYear] = [IP_Billing_Unbundled].[dmicRuleFinancialYear]
	GROUP BY [Generated Record ID]
		,[dmicPSSGrouperVersion]
		,[dmicGrouperVersion]
		,[dmicRuleFinancialYear]
	) AS [IP_Billing_Unbundled_AGG]
LEFT JOIN [Casted].[IP_pbr_preprocess_CDS62_EP] AS [CDS62_EP]
	ON ([EP].[Generated Record ID] = [CDS62_EP].[Generated Record ID])
--LEFT JOIN [Casted].[IP_pbr_preprocess_SP] AS [SP]
--	ON ([SP].[Generated Record ID] = [EP].[Generated Record ID])
CROSS APPLY (
	SELECT *
		,[FiscalYear] = CONCAT (
			YEAR([FiscalActivityDate])
			,'/'
			,YEAR([FiscalActivityDate]) + 1
			)
	FROM (
		SELECT [FiscalActivityDate] = DATEADD(MM, - 3, [EP].[ActivityDate])
		) X
	) AS [XX]
WHERE (
		(
			[EP].[Generated Record ID] = [SS].[Spell Identifier]
			AND [SS].[SpellRecordCount] > 1
			)
		OR [SS].[SpellRecordCount] = 1
		);
