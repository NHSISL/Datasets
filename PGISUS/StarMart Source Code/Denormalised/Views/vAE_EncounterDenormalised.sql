CREATE VIEW [Denormalised].[vAE_EncounterDenormalised]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_Encounter_ID] = [EM].[Generated Record ID]
	,[dv_Extract_Type] = TRY_CAST(CONCAT (
			'SUSPlus Mart AE '
			,STUFF([XX].[FiscalYear], 6, 2, '')
			,' Commissioner - '
			,CASE '$(SUSDataMartID)' /*[SK_SUSDataMartID]*/
				WHEN 12 -- PGISUS Rec/PostRec
					THEN 'PostRec'
				WHEN 13 -- PGISUS DateRange
					THEN 'Date Range'
				END
			) AS VARCHAR(200))
	,[dv_Query_ID] = TRY_CAST('EM_MAIN' AS VARCHAR(7))
	,[dv_Fiscal_Year] = TRY_CAST([XX].[FiscalYear] AS VARCHAR(30))
	,[dv_Fiscal_Month] = TRY_CAST(MONTH([XX].[FiscalActivityDate]) AS TINYINT)
	,[dv_Activity_Period_Date] = TRY_CAST(CONVERT(VARCHAR, [EM].[ActivityDate], 112) AS INT)
	--
	,[CDS_Record_Type] = [EM].[CDS Record Type]
	,[Spell_Identifier] = [EM].[Spell Identifier]
	,[Unique_CDS_Identifier] = TRY_CAST([PID].[Unique CDS Identifier] AS VARCHAR(35))
	,[EM_Attendance_Number] = TRY_CAST([PID].[EM Attendance Number] AS VARCHAR(12))
	,[Ambulance_Incident_Number] = [CDS62_EC].[Ambulance Incident Number]
	--
	,[Arrival_Date] = TRY_CAST([EM].[Arrival Date] AS DATE)
	,[Arrival_Time] = TRY_CAST([EM].[Arrival Time] AS TIME(0))
	,[EM_Referral_Source] = [EM].[EM Referral Source]
	,[EM_Mode_Of_Arrival] = [EM].[EM Mode Of Arrival]
	,[EM_Department_Type] = [EM].[EM Department Type]
	,[EM_Attendance_Category] = [EM].[EM Attendance Category]
	,[EM_Incident_Location_Type] = [EM].[EM Incident Location Type]
	,[EM_Patient_Group] = [EM].[EM Patient Group]
	,[EM_Staff_Member_Code] = [EM].[EM Staff Member Code]
	,[EM_Attendance_Disposal] = [EM].[EM Attendance Disposal]
	,[EM_Initial_Assessment_Date] = [CDS62_EC].[EM Initial Assessment Date] -- Note: Not actually dv_ anymore
	,[EM_Initial_Assessment_Time] = [EM].[EM Initial Assessment Time]
	,[EM_Date_Seen_For_Treatment] = [CDS62_EC].[EM Date Seen For Treatment] -- Note: Not actually dv_ anymore
	,[EM_Time_Seen_For_Treatment] = [EM].[EM Time Seen For Treatment]
	,[EM_Attendance_Conclusion_Date] = [CDS62_EC].[EM Attendance Conclusion Date] -- Note: Not actually dv_ anymore
	,[EM_Attendance_Conclusion_Time] = [EM].[EM Attendance Conclusion Time]
	,[EM_Departure_Date] = [CDS62_EC].[EM Departure Date]
	,[EM_Departure_Time] = [EM].[EM Departure Time]
	--
	,[dv_EM_Assessment_Waiting_Time] = DATEDIFF(MINUTE, TRY_CAST([EM].[Arrival Date] AS DATETIME) + TRY_CAST([EM].[Arrival Time] AS DATETIME), TRY_CAST([CDS62_EC].[EM Initial Assessment Date] AS DATETIME) + TRY_CAST([EM].[EM Initial Assessment Time] AS DATETIME))
	,[dv_EM_Treatment_Wait_Time] = DATEDIFF(MINUTE, TRY_CAST([EM].[Arrival Date] AS DATETIME) + TRY_CAST([EM].[Arrival Time] AS DATETIME), TRY_CAST([CDS62_EC].[EM Date Seen For Treatment] AS DATETIME) + TRY_CAST([EM].[EM Time Seen For Treatment] AS DATETIME))
	,[dv_EM_Conclusion_Waiting_Time] = DATEDIFF(MINUTE, TRY_CAST([EM].[Arrival Date] AS DATETIME) + TRY_CAST([EM].[Arrival Time] AS DATETIME), TRY_CAST([CDS62_EC].[EM Attendance Conclusion Date] AS DATETIME) + TRY_CAST([EM].[EM Attendance Conclusion Time] AS DATETIME))
	,[dv_EM_Duration_Time] = DATEDIFF(MINUTE, TRY_CAST([EM].[Arrival Date] AS DATETIME) + TRY_CAST([EM].[Arrival Time] AS DATETIME), TRY_CAST([CDS62_EC].[EM Departure Date] AS DATETIME) + TRY_CAST([EM].[EM Departure Time] AS DATETIME)) -- Note: Now dv_
	--
	,[Number_Diagnosis] = [EM].[Number Diagnosis]
	,[Number_Procedures] = [EM].[Number Procedures]
	,[Number_EM_Investigations] = [EM].[Number EM Investigations]
	,[Number_EM_Treatments] = [EM].[Number EM Treatments]
	--
	,[SK_Patient_ID] = TRY_CAST([PID].[SK_PatientID] AS INT)
	,[Withheld_Identity_Reason] = [CDS62_EC].[Withheld Identity Reason]
	,[Confidentiality_Category] = [EM].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [EM].[NHS Number Status Indicator]
	--
	,[Local_Patient_Identifier] = TRY_CAST([PID].[Local Patient Identifier] AS VARCHAR(10))
	,[Carer_Support_Indicator] = [EM].[Carer Support Indicator]
	,[Ethnic_Category_Code] = [EM].[Ethnic Category Code]
	,[Age_At_CDS_Activity_Date] = [EM].[Age At CDS Activity Date]
	,[Birth_Date] = TRY_CAST([PID].[dv_Birth Date (Rounded)] AS DATE)
	,[dv_Birth_Year] = TRY_CAST(YEAR([PID].[dv_Birth Date (Rounded)]) AS INT)
	,[Gender_Code] = TRY_CAST([EM].[Gender Code] AS CHAR(1))
	,[Postcode_Of_Usual_Address] = TRY_CAST([PID].[dv_Pseudo_Postcode] AS VARCHAR(8))
	,[dv_LSOA_Code] = TRY_CAST([PID].[dv_LSOA] AS VARCHAR(9))
	--
	,[Registered_GMP_Code_Original_Data] = [EM].[Registered GMP Code (Original Data)]
	,[GP_Practice_Code_Original_Data] = [EM].[GP Practice Code (Original Data)]
	,[GP_Practice_Code] = [EM].[GP Practice Code] --Naming mismatch with EP/OP is mirrored within SUS extracts
	,[Is_GP_Practice_Derived_from_PDS] = TRY_CAST([EM].[GP Practice Derived From PDS] AS BIT)
	--
	,[Provider_Reference_No] = TRY_CAST([PID].[Provider Reference No] AS VARCHAR(17))
	,[Commissioner_Reference_No] = TRY_CAST([PID].[Commissioner Reference No] AS VARCHAR(17))
	,[Commissioning_Serial_No_Agreement_No] = TRY_CAST([PID].[Commissioning Serial No (Agreement No)] AS VARCHAR(6))
	,[NHS_Service_Agreement_Line_No] = TRY_CAST([PID].[NHS Service Agreement Line No] AS VARCHAR(10))
	--
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_EC].[OSV Status Classification At CDS Activity Date]
	--
	,[Organiastion_Code_Conveying_Ambulance_Trust] = [CDS62_EC].[Organisation Code (Conveying Ambulance Trust)]
	,[Provider_Code_Original_Data] = [EM].[Provider Code (Original Data)]
	,[Organisation_Code_Code_Of_Provider] = [EM].[Organisation Code (Code Of Provider)]
	,[Provider_Site_Code] = [EM].[Provider Site Code]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [EM].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_PCT_Of_Residence] = [EM].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_Original_Data] = [EM].[Commissioner Code (Original Data)]
	,[PCT_Derived_From_GP_Practice] = [EM].[PCT Derived From GP Practice]
	,[Patient_Postcode_Derived_PCT] = [EM].[Patient Postcode Derived PCT]
	,[PCT_Of_Residence_Original] = [EM].[PCT Of Residence (Original)]
	,[PCT_Responsible] = [EM].[PCT Responsible]
	,[Derived_Commissioner] = [EM].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [EM].[Derived Commissioner Type]
	--
	,[dv_Commissioner_Code_Of_Residence] = TRY_CAST([EM].[Organisation Code (PCT Of Residence)] AS INT)
	,[dv_Purchaser_ID] = TRY_CAST([EM].[Organisation Code (Code Of Commissioner)] AS VARCHAR(15))
	--
	,[Core_HRG] = [EM].[Core HRG]
	--
	,[dv_HRG] = TRY_CAST(COALESCE([AE_Billing].[dmicTariffHRG], [AE_Billing].[dmicNonStreamingHrgCode]) AS VARCHAR(5))
	,[dv_Local_Cost_Code] = TRY_CAST([AE_Billing].[dmicBusinessRuleCodes] AS VARCHAR(30))
	,[dv_Is_PBR] = TRY_CAST(CASE 
			WHEN [AE_Billing].[dmicCostType] = 'Tariff'
				THEN 1
			ELSE 0
			END AS BIT)
	,[dv_Base_Cost] = TRY_CAST([AE_Billing].[Unrounded Total Tariff] AS MONEY)
	,[dv_MFF_Index_Applied] = TRY_CAST([AE_Billing].[Market Forces Factor] AS REAL)
	--
	,[Tariff_Initial_Amount_National] = [EM].[Tariff Initial Amount National]
	,[Tariff_Pre_MFF_Adjusted_National] = [EM].[Tariff Pre MFF Adjusted National]
	,[Applied_MFF_National] = [EM].[Applied MFF National]
	,[MFF_Adjustment] = [EM].[MFF Adjustment]
	,[Tariff_Total_Payment_National] = [EM].[Tariff Total Payment National]
	,[PBR_Final_Tariff] = [EM].[PbR Final Tariff]
	--
	,[dv_Total_Cost_Inc_MFF] = TRY_CAST([AE_Billing].[Unrounded Total Tariff Including MFF] AS MONEY)
	--
	-- A&E diagnoses removed as now defunct
	--,[EM_Diagnosis_First] = [EM].[EM Diagnosis First] --TODO: Replace/Supplement with SNOMEDs
	--,[EM_Diagnosis_Second_1] = [EM].[EM Diagnosis Second 1]
	--,[EM_Diagnosis_Second_2] = [EM].[EM Diagnosis Second 2]
	--,[EM_Diagnosis_Second_3] = [EM].[EM Diagnosis Second 3]
	--,[EM_Diagnosis_Second_4] = [EM].[EM Diagnosis Second 4]
	--,[EM_Diagnosis_Second_5] = [EM].[EM Diagnosis Second 5]
	--,[EM_Diagnosis_Second_6] = [EM].[EM Diagnosis Second 6]
	--,[EM_Diagnosis_Second_7] = [EM].[EM Diagnosis Second 7]
	--,[EM_Diagnosis_Second_8] = [EM].[EM Diagnosis Second 8]
	--,[EM_Diagnosis_Second_9] = [EM].[EM Diagnosis Second 9]
	--,[EM_Diagnosis_Second_10] = [EM].[EM Diagnosis Second 10]
	--,[EM_Diagnosis_Second_11] = [EM].[EM Diagnosis Second 11]
	--,[EM_Diagnosis_Second_12] = [EM].[EM Diagnosis Second 12]
	--
	,[ECDS_diagnosis_code_01] = [pivot_diagnosis].[ECDS_diagnosis_code_01]
	,[ECDS_diagnosis_code_02] = [pivot_diagnosis].[ECDS_diagnosis_code_02]
	,[ECDS_diagnosis_code_03] = [pivot_diagnosis].[ECDS_diagnosis_code_03]
	,[ECDS_diagnosis_code_04] = [pivot_diagnosis].[ECDS_diagnosis_code_04]
	,[ECDS_diagnosis_code_05] = [pivot_diagnosis].[ECDS_diagnosis_code_05]
	,[ECDS_diagnosis_code_06] = [pivot_diagnosis].[ECDS_diagnosis_code_06]
	,[ECDS_diagnosis_code_07] = [pivot_diagnosis].[ECDS_diagnosis_code_07]
	,[ECDS_diagnosis_code_08] = [pivot_diagnosis].[ECDS_diagnosis_code_08]
	,[ECDS_diagnosis_code_09] = [pivot_diagnosis].[ECDS_diagnosis_code_09]
	,[ECDS_diagnosis_code_10] = [pivot_diagnosis].[ECDS_diagnosis_code_10]
	,[ECDS_diagnosis_code_11] = [pivot_diagnosis].[ECDS_diagnosis_code_11]
	,[ECDS_diagnosis_code_12] = [pivot_diagnosis].[ECDS_diagnosis_code_12]
	--
	,[ECDS_investigation_code_01] = [pivot_investigation].[ECDS_investigation_code_01]
	,[ECDS_investigation_code_02] = [pivot_investigation].[ECDS_investigation_code_02]
	,[ECDS_investigation_code_03] = [pivot_investigation].[ECDS_investigation_code_03]
	,[ECDS_investigation_code_04] = [pivot_investigation].[ECDS_investigation_code_04]
	,[ECDS_investigation_code_05] = [pivot_investigation].[ECDS_investigation_code_05]
	,[ECDS_investigation_code_06] = [pivot_investigation].[ECDS_investigation_code_06]
	,[ECDS_investigation_code_07] = [pivot_investigation].[ECDS_investigation_code_07]
	,[ECDS_investigation_code_08] = [pivot_investigation].[ECDS_investigation_code_08]
	,[ECDS_investigation_code_09] = [pivot_investigation].[ECDS_investigation_code_09]
	,[ECDS_investigation_code_10] = [pivot_investigation].[ECDS_investigation_code_10]
	,[ECDS_investigation_code_11] = [pivot_investigation].[ECDS_investigation_code_11]
	,[ECDS_investigation_code_12] = [pivot_investigation].[ECDS_investigation_code_12]
	--	
	,[ECDS_procedure_code_01] = [pivot_procedure].[ECDS_procedure_code_01]
	,[ECDS_procedure_code_02] = [pivot_procedure].[ECDS_procedure_code_02]
	,[ECDS_procedure_code_03] = [pivot_procedure].[ECDS_procedure_code_03]
	,[ECDS_procedure_code_04] = [pivot_procedure].[ECDS_procedure_code_04]
	,[ECDS_procedure_code_05] = [pivot_procedure].[ECDS_procedure_code_05]
	,[ECDS_procedure_code_06] = [pivot_procedure].[ECDS_procedure_code_06]
	,[ECDS_procedure_code_07] = [pivot_procedure].[ECDS_procedure_code_07]
	,[ECDS_procedure_code_08] = [pivot_procedure].[ECDS_procedure_code_08]
	,[ECDS_procedure_code_09] = [pivot_procedure].[ECDS_procedure_code_09]
	,[ECDS_procedure_code_10] = [pivot_procedure].[ECDS_procedure_code_10]
	,[ECDS_procedure_code_11] = [pivot_procedure].[ECDS_procedure_code_11]
	,[ECDS_procedure_code_12] = [pivot_procedure].[ECDS_procedure_code_12]
	--	
	--Emergency Medicine Investigation Codes (backwards compatible for pricing rules)
	,[EM_Investigation_First] = [EM].[EM Investigation First]
	,[EM_Investigation_Second_1] = [EM].[EM Investigation Second 1]
	,[EM_Investigation_Second_2] = [EM].[EM Investigation Second 2]
	,[EM_Investigation_Second_3] = [EM].[EM Investigation Second 3]
	,[EM_Investigation_Second_4] = [EM].[EM Investigation Second 4]
	,[EM_Investigation_Second_5] = [EM].[EM Investigation Second 5]
	,[EM_Investigation_Second_6] = [EM].[EM Investigation Second 6]
	,[EM_Investigation_Second_7] = [EM].[EM Investigation Second 7]
	,[EM_Investigation_Second_8] = [EM].[EM Investigation Second 8]
	,[EM_Investigation_Second_9] = [EM].[EM Investigation Second 9]
	,[EM_Investigation_Second_10] = [EM].[EM Investigation Second 10]
	,[EM_Investigation_Second_11] = [EM].[EM Investigation Second 11]
	,[EM_Investigation_Second_12] = [EM].[EM Investigation Second 12]
	--Emergency Medicine Treatment Codes (backwards compatible for pricing rules)
	,[EM_Treatment_First] = [EM].[EM Treatment First]
	,[EM_Treatment_Second_1] = [EM].[EM Treatment Second 1]
	,[EM_Treatment_Second_2] = [EM].[EM Treatment Second 2]
	,[EM_Treatment_Second_3] = [EM].[EM Treatment Second 3]
	,[EM_Treatment_Second_4] = [EM].[EM Treatment Second 4]
	,[EM_Treatment_Second_5] = [EM].[EM Treatment Second 5]
	,[EM_Treatment_Second_6] = [EM].[EM Treatment Second 6]
	,[EM_Treatment_Second_7] = [EM].[EM Treatment Second 7]
	,[EM_Treatment_Second_8] = [EM].[EM Treatment Second 8]
	,[EM_Treatment_Second_9] = [EM].[EM Treatment Second 9]
	,[EM_Treatment_Second_10] = [EM].[EM Treatment Second 10]
	,[EM_Treatment_Second_11] = [EM].[EM Treatment Second 11]
	,[EM_Treatment_Second_12] = [EM].[EM Treatment Second 12]
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM]
INNER JOIN [Casted].[AE_pbr_preprocess_EM_Pseudo] AS [PID]
	ON ([EM].[Generated Record ID] = [PID].[Generated Record ID])
-- AE Records must have an In Year billing record.
INNER JOIN [Casted].[AE_Billing] AS [AE_Billing]
	ON ([EM].[Generated Record ID] = [AE_Billing].[Generated Record ID])
INNER JOIN [dbo].[Grouper] AS [Grouper]
	ON (
			[AE_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
			AND [AE_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
			AND [AE_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
			AND [AE_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
			AND [Grouper].[IsInYearCost] = 1
			)
LEFT JOIN [Casted].[AE_pbr_preprocess_CDS62_EC] AS [CDS62_EC]
	ON ([EM].[Generated Record ID] = [CDS62_EC].[Generated Record ID])
--Snomed diagnoses, investigations and procedures (pivoted)
LEFT JOIN [Casted].[AE_pbr_preprocess_SUPP_EC_Diagnosis_Pivot] [pivot_diagnosis]
	ON ([EM].[Generated Record ID] = [pivot_diagnosis].[Generated Record ID])
LEFT JOIN [Casted].[AE_pbr_preprocess_SUPP_EC_Investigation_Pivot] [pivot_investigation]
	ON ([EM].[Generated Record ID] = [pivot_investigation].[Generated Record ID])
LEFT JOIN [Casted].[AE_pbr_preprocess_SUPP_EC_Procedure_Pivot] [pivot_procedure]
	ON ([EM].[Generated Record ID] = [pivot_procedure].[Generated Record ID])
CROSS APPLY (
	SELECT *
		,[FiscalYear] = CONCAT (
			YEAR([FiscalActivityDate])
			,'/'
			,YEAR([FiscalActivityDate]) + 1
			)
	FROM (
		SELECT [FiscalActivityDate] = DATEADD(MM, - 3, [EM].[ActivityDate])
		) X
	) AS [XX];
