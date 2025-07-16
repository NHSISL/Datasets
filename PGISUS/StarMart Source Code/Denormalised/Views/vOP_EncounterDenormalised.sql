CREATE VIEW [Denormalised].[vOP_EncounterDenormalised]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	,[dv_Extract_Type] = TRY_CAST(CONCAT (
			'SUSPlus Mart OP '
			,STUFF([XX].[FiscalYear], 6, 2, '')
			,' Commissioner - '
			,CASE '$(SUSDataMartID)' /*[SK_SUSDataMartID]*/
				WHEN 12 -- PGISUS Rec/PostRec
					THEN 'PostRec'
				WHEN 13 -- PGISUS DateRange
					THEN 'Date Range'
				END
			) AS VARCHAR(200))
	,[dv_Query_ID] = TRY_CAST('OP_MAIN' AS VARCHAR(7))
	,[dv_Fiscal_Year] = TRY_CAST([XX].[FiscalYear] AS VARCHAR(30))
	,[dv_Fiscal_Month] = TRY_CAST(MONTH([XX].[FiscalActivityDate]) AS TINYINT)
	,[dv_Activity_Period_Date] = TRY_CAST(CONVERT(VARCHAR, [OP].[ActivityDate], 112) AS INT)
	--
	,[Spell_Identifier] = [OP].[Spell Identifier]
	,[Unique_CDS_Identifier] = TRY_CAST([PID].[Unique CDS Identifier] AS VARCHAR(35))
	,[Attendance_Identifier] = TRY_CAST([PID].[Attendance Identifier] AS VARCHAR(15))
	--
	,[Referrer_Code] = [OP].[Referrer Code]
	,[Referring_Organisation_Code] = [OP].[Referring Organisation Code]
	,[Organisation_Code_Patient_Pathway_Identifier] = [OP].[Organisation Code Patient Pathway Identifier]
	,[RTT_Patient_Pathway_Identifier] = TRY_CAST([PID].[RTT Patient Pathway Identifier] AS VARCHAR(20))
	,[RTT_Period_Start_Date] = [OP].[RTT Period Start Date]
	,[RTT_Period_End_Date] = [OP].[RTT Period End Date]
	,[RTT_Length_Derived] = [OP].[RTT Length (Derived)] -- Note: Not actually dv_ anymore
	,[RTT_Status] = [OP].[RTT Status]
	--
	,[Referral_Request_Received_Date] = [OP].[Referral Request Received Date]
	,[Priority_Type] = [OP].[Priority Type]
	,[Service_Type_Requested] = [OP].[Service Type Requested]
	,[Source_Of_Referral_For_Outpatients] = [OP].[Source Of Referral For Outpatients]
	,[Is_Valid_UBRN] = [OP].[Is Valid UBRN]
	,[UBRN_Occurrence_Count] = [OP].[UBRN Occurrence Count]
	--
	,[Appointment_Date] = [OP].[Appointment Date]
	,[Appointment_Time] = [CDS62_OP].[Appointment Time]
	,[CDS_Activity_Date] = [OP].[CDS Activity Date] -- Note: Not actually dv_ anymore
	,[Earliest_Reasonable_Offer_Date] = [CDS62_OP].[Earliest Reasonable Offer Date]
	,[Earliest_Clinically_Appropriate_Date] = [CDS62_OP].[Earliest Clinically Appropriate Date]
	,[Expected_Duration_of_Appointment] = [CDS62_OP].[Expected Duration Of Appointment]
	--
	,[Administrative_Category] = [OP].[Administrative Category]
	,[First_Attendance] = [OP].[First Attendance]
	,[Attended_Or_Did_Not_Attend] = [OP].[Attended Or Did Not Attend]
	,[Outcome_Of_Attendance] = [OP].[Outcome Of Attendance]
	,[Medical_Staff_Type_Seeing_Patient] = [OP].[Medical Staff Type Seeing Patient]
	,[Location_Type_Code] = [OP].[Location Type Code]
	,[Direct_Access_Referral_Indicator] = [CDS62_OP].[Direct Access Referral Indicator]
	,[Direct_Access_Tariff_Flag] = [OP].[Direct Access Tariff Flag]
	,[Multi_Professional_or_Multi_Disciplinary_Indication_Code] = [CDS62_OP].[Multi-Professional Or Multi-Disciplinary Indication Code]
	,[Rehabilitation_Assessment_Team_Type] = [CDS62_OP].[Rehabilitation Assessment Team Type]
	,[Consultation_Medium_Used] = [CDS62_OP].[Consultation Medium Used]
	--
	,[SK_Patient_ID] = TRY_CAST([PID].[SK_PatientID] AS INT)
	,[Withheld_Identity_Reason] = [CDS62_OP].[Withheld Identity Reason]
	,[Confidentiality_Category] = [OP].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [OP].[NHS Number Status Indicator]
	--
	,[Local_Patient_Identifier] = TRY_CAST([PID].[Local Patient Identifier] AS VARCHAR(10))
	,[Ethnic_Category_Code] = [OP].[Ethnic Category Code]
	,[Age] = [OP].[Age]
	,[Birth_Date] = TRY_CAST([PID].[dv_Birth Date (Rounded)] AS DATE)
	,[dv_Birth_Year] = TRY_CAST(YEAR([OP].[Birth Date]) AS SMALLINT)
	,[Gender_Code] = TRY_CAST([OP].[Gender Code] AS CHAR(1))
	,[Postcode_Of_Usual_Address] = TRY_CAST([PID].[dv_Pseudo_Postcode] AS VARCHAR(8))
	,[dv_LSOA_Code] = TRY_CAST([PID].[dv_LSOA] AS VARCHAR(9))
	--
	,[GP_Code] = [OP].[GP Code]
	,[GP_Practice_Code_Original_Data] = [OP].[GP Practice Code (Original Data)]
	,[GP_Practice_Code_Derived] = [OP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = TRY_CAST([OP].[GP Practice Derived From PDS] AS BIT)
	--
	,[Provider_Reference_No] = TRY_CAST([PID].[Provider Reference No] AS VARCHAR(17))
	,[Commissioner_Reference_No] = TRY_CAST([PID].[Commissioner Reference No] AS VARCHAR(17))
	,[Commissioning_Serial_No_Agreement_No] = TRY_CAST([PID].[Commissioning Serial No (Agreement No)] AS VARCHAR(6))
	,[NHS_Service_Agreement_Line_No] = TRY_CAST([PID].[NHS Service Agreement Line No] AS VARCHAR(10))
	--
	,[Consultant_Code] = [OP].[Consultant Code]
	,[Main_Specialty_Code] = [OP].[Main Specialty Code]
	,[Treatment_Function_Code] = [OP].[Treatment Function Code]
	,[Local_Sub_Specialty_Code] = [CDS62_OP].[Local Sub Specialty Code]
	,[Clinic_Code] = [CDS62_OP].[Clinic Code]
	--
	,[dv_Specialist_Commissioning_Service_Code_National] = [OP].[Spell Service Line]
	,[dv_Specialist_Commissioning_Service_Code_Local] = [OP_Billing].[dmicSpecialisedServiceLineCode]
	,[Spell_NPOC] = [OP].[Spell NPOC]
	--,[Programme_Budgeting_Category] = [OP].[Programme Budgeting Category] --Not available in OP outside of billing table
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_OP].[OSV Status Classification At CDS Activity Date]
	--
	,[Provider_Site_Code] = [OP].[Provider Site Code]
	,[Organisation_Code_Code_Of_Provider] = [OP].[Organisation Code (Code Of Provider)]
	,[Site_Code_Of_Treatment] = [OP].[Site Code Of Treatment]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [OP].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_PCT_Of_Residence] = [OP].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_Original_Data] = [OP].[Commissioner Code (Original Data)]
	,[PCT_Derived_From_GP_Practice] = [OP].[PCT Derived From GP Practice]
	,[Patient_Postcode_Derived_PCT] = [OP].[Patient Postcode Derived PCT]
	,[Derived_Commissioner] = [OP].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [OP].[Derived Commissioner Type]
	--
	,[dv_Commissioner_Code_Of_Residence] = TRY_CAST([OP].[Organisation Code (PCT Of Residence)] AS VARCHAR(15))
	,[dv_Purchaser_ID] = TRY_CAST([OP].[Organisation Code (Code Of Commissioner)] AS VARCHAR(15))
	--
	,[Core_HRG] = [OP].[Core HRG]
	,[HRG_Used_For_Tariff] = [OP].[HRG Used For Tariff] -- Note: Not actually dv_ anymore
	--
	,[dv_HRG] = TRY_CAST([OP_Billing].[dmicTariffHRG] AS VARCHAR(5))
	,[dv_Local_Cost_Code] = TRY_CAST([OP_Billing].[dmicBusinessRuleCodes] AS VARCHAR(30))
	,[Spell_In_PbR_Not_In_PbR] = [OP].[Spell In PbR/Not In PbR]
	--
	,[dv_Is_PBR] = TRY_CAST(CASE 
			WHEN [OP_Billing].[dmicCostType] = 'Tariff'
				THEN 1
			ELSE 0
			END AS BIT)
	,[dv_Applicable_Tariff] = TRY_CAST(NULL AS REAL) -- Always NULL
	,[dv_Base_Cost] = TRY_CAST(ISNULL([OP_Billing].[Unrounded Total Tariff], 0) - ISNULL([OP_Billing].[Unrounded Total Unbundled Tariff], 0) AS REAL)
	,[dv_MFF_Index_Applied] = TRY_CAST([OP_Billing].[Market Forces Factor] AS REAL)
	,[Tariff_Initial_Amount_National] = [OP].[Tariff Initial Amount National]
	,[Tariff_Pre_MFF_Adjusted_National] = [OP].[Tariff Pre MFF Adjusted National]
	,[Tariff_Total_Payment_National] = [OP].[Tariff Total Payment National]
	,[PbR_Final_Tariff] = [OP].[PbR Final Tariff]
	,[dv_Total_Cost_Inc_MFF] = TRY_CAST(ISNULL([OP_Billing].[Unrounded Total Tariff Including MFF], 0) - ISNULL([OP_Billing].[Unrounded Total Unbundled Tariff Including MFF], 0) AS REAL)
	--
	,[Number_Diagnosis] = [OP].[Number Diagnosis]
	,[Primary_Diagnosis_Code] = [OP].[Primary Diagnosis Code]
	,[Secondary_Diagnosis_Code_1] = [OP].[Secondary Diagnosis Code 1]
	,[Secondary_Diagnosis_Code_2] = [OP].[Secondary Diagnosis Code 2]
	,[Secondary_Diagnosis_Code_3] = [OP].[Secondary Diagnosis Code 3]
	,[Secondary_Diagnosis_Code_4] = [OP].[Secondary Diagnosis Code 4]
	,[Secondary_Diagnosis_Code_5] = [OP].[Secondary Diagnosis Code 5]
	,[Secondary_Diagnosis_Code_6] = [OP].[Secondary Diagnosis Code 6]
	,[Secondary_Diagnosis_Code_7] = [OP].[Secondary Diagnosis Code 7]
	,[Secondary_Diagnosis_Code_8] = [OP].[Secondary Diagnosis Code 8]
	,[Secondary_Diagnosis_Code_9] = [OP].[Secondary Diagnosis Code 9]
	,[Secondary_Diagnosis_Code_10] = [OP].[Secondary Diagnosis Code 10]
	,[Secondary_Diagnosis_Code_11] = [OP].[Secondary Diagnosis Code 11]
	,[Secondary_Diagnosis_Code_12] = [OP].[Secondary Diagnosis Code 12]
	--
	,[Operation_Status] = [OP].[Operation Status]
	,[Number_Procedures] = [OP].[Number Procedures]
	,[Primary_Procedure_Code] = [OP].[Primary Procedure Code]
	,[Primary_Procedure_Date] = [OP].[Primary Procedure Date]
	,[Secondary_Procedure_Code_1] = [OP].[Secondary Procedure Code 1]
	,[Secondary_Procedure_Date_1] = [OP].[Secondary Procedure Date 1]
	,[Secondary_Procedure_Code_2] = [OP].[Secondary Procedure Code 2]
	,[Secondary_Procedure_Date_2] = [OP].[Secondary Procedure Date 2]
	,[Secondary_Procedure_Code_3] = [OP].[Secondary Procedure Code 3]
	,[Secondary_Procedure_Date_3] = [OP].[Secondary Procedure Date 3]
	,[Secondary_Procedure_Code_4] = [OP].[Secondary Procedure Code 4]
	,[Secondary_Procedure_Date_4] = [OP].[Secondary Procedure Date 4]
	,[Secondary_Procedure_Code_5] = [OP].[Secondary Procedure Code 5]
	,[Secondary_Procedure_Date_5] = [OP].[Secondary Procedure Date 5]
	,[Secondary_Procedure_Code_6] = [OP].[Secondary Procedure Code 6]
	,[Secondary_Procedure_Date_6] = [OP].[Secondary Procedure Date 6]
	,[Secondary_Procedure_Code_7] = [OP].[Secondary Procedure Code 7]
	,[Secondary_Procedure_Date_7] = [OP].[Secondary Procedure Date 7]
	,[Secondary_Procedure_Code_8] = [OP].[Secondary Procedure Code 8]
	,[Secondary_Procedure_Date_8] = [OP].[Secondary Procedure Date 8]
	,[Secondary_Procedure_Code_9] = [OP].[Secondary Procedure Code 9]
	,[Secondary_Procedure_Date_9] = [OP].[Secondary Procedure Date 9]
	,[Secondary_Procedure_Code_10] = [OP].[Secondary Procedure Code 10]
	,[Secondary_Procedure_Date_10] = [OP].[Secondary Procedure Date 10]
	,[Secondary_Procedure_Code_11] = [OP].[Secondary Procedure Code 11]
	,[Secondary_Procedure_Date_11] = [OP].[Secondary Procedure Date 11]
	,[Secondary_Procedure_Code_12] = [OP].[Secondary Procedure Code 12]
	,[Secondary_Procedure_Date_12] = [OP].[Secondary Procedure Date 12]
	--
	,[Unbundled_HRG_1] = [OP].[Unbundled HRG 1] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_2] = [OP].[Unbundled HRG 2] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_3] = [OP].[Unbundled HRG 3] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_4] = [OP].[Unbundled HRG 4] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_5] = [OP].[Unbundled HRG 5] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_6] = [OP].[Unbundled HRG 6] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_7] = [OP].[Unbundled HRG 7] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_8] = [OP].[Unbundled HRG 8] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_9] = [OP].[Unbundled HRG 9] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_10] = [OP].[Unbundled HRG 10] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_11] = [OP].[Unbundled HRG 11] -- Note: Not actually dv_ anymore
	,[Unbundled_HRG_12] = [OP].[Unbundled HRG 12] -- Note: Not actually dv_ anymore
	,[Number_Unbundled_HRGs] = [OP].[Number Unbundled HRGs] -- Note: Not actually dv_ anymore
	,[Number_Unbundled_Non_Priced_HRGs] = [OP].[Number Unbundled Non Priced HRGs] -- Note: Not actually dv_ anymore
	,[Number_Unbundled_Priced_HRGs] = [OP].[Number Unbundled Priced HRGs] -- Note: Not actually dv_ anymore
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
INNER JOIN [Casted].[OP_pbr_preprocess_OP_Pseudo] AS [PID]
	ON ([OP].[Generated Record ID] = [PID].[Generated Record ID])
-- OP Records may have a billing record, if they do it must be the In Year Cost.
LEFT JOIN (
	SELECT [OP_Billing].*
	FROM [Casted].[OP_Billing] AS [OP_Billing]
	INNER JOIN [dbo].[Grouper] AS [Grouper]
		ON (
				[OP_Billing].[dmicPSSGrouperVersion] = [Grouper].[dmicPSSGrouperVersion]
				AND [OP_Billing].[dmicGrouperVersion] = [Grouper].[dmicGrouperVersion]
				AND [OP_Billing].[dmicRuleFinancialYear] = [Grouper].[dmicRuleFinancialYear]
				AND [OP_Billing].[ActivityPeriod] BETWEEN [Grouper].[PeriodFrom] AND [Grouper].[PeriodTo]
				AND [Grouper].[IsInYearCost] = 1
				)
	) AS [OP_Billing]
	ON ([OP].[Generated Record ID] = [OP_Billing].[Generated Record ID])
LEFT JOIN [Casted].[OP_pbr_preprocess_CDS62_OP] AS [CDS62_OP]
	ON ([OP].[Generated Record ID] = [CDS62_OP].[Generated Record ID])
CROSS APPLY (
	SELECT *
		,[FiscalYear] = CONCAT (
			YEAR([FiscalActivityDate])
			,'/'
			,YEAR([FiscalActivityDate]) + 1
			)
	FROM (
		SELECT [FiscalActivityDate] = DATEADD(MM, - 3, [OP].[ActivityDate])
		) X
	) AS [XX];
