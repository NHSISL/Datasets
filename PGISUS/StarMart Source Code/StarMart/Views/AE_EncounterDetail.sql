CREATE VIEW [StarMart].[AE_EncounterDetail]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_Encounter_ID] = [EM].[Generated Record ID]
	,[CDS_Record_Type] = [EM].[CDS Record Type]
	--
	,[SK_Patient_ID] = [EM_Pseudo].[SK_PatientID]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [EM].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_Code_Of_Provider] = [EM].[Organisation Code (Code Of Provider)]
	--
	,[SK_Organisation_ID_Commissioner] = ISNULL([SK_OrgComm].[SK_OrganisationID], 1)
	,[SK_Organisation_ID_Provider] = ISNULL([SK_OrgProv].[SK_OrganisationID], 1)
	--
	,[dv_Encounter_Start_DateTime] = TRY_CAST([EM].[Arrival Date] AS SMALLDATETIME) + TRY_CAST([EM].[Arrival Time] AS SMALLDATETIME)
	,[dv_Encounter_End_DateTime] = TRY_CAST([CDS62_EC].[EM Departure Date] AS SMALLDATETIME) + TRY_CAST([EM].[EM Departure Time] AS SMALLDATETIME)
	--
	--,[SK_Arrival_Mode_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[EM Mode Of Arrival], 1 )
	--,[SK_Attendance_Category_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[EM Attendance Category], 1 )
	--,[SK_Attendance_Disposal_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[EM Attendance Disposal], 1 )
	--,[SK_Incident_Location_Type_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[EM Incident Location Type], 1 )
	--,[SK_Source_Of_Referral_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[EM Referral Source], 1 )
	--,[SK_Age_Band_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- [EM].[Age At CDS Activity Date]
	--,[SK_Department_Type_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- [EM].[EM Department Type]
	--
	,[Age_At_CDS_Activity_Date] = [EM].[Age At CDS Activity Date]
	,[EM_Mode_of_Arrival] = [EM].[EM Mode Of Arrival]
	,[EM_Attendance_Category] = [EM].[EM Attendance Category]
	,[EM_Attendance_Disposal] = [EM].[EM Attendance Disposal]
	,[EM_Incident_Location_Type] = [EM].[EM Incident Location Type]
	,[EM_Referral_Source] = [EM].[EM Referral Source]
	,[EM_Patient_Group] = [EM].[EM Patient Group]
	,[EM_Department_Type] = [EM].[EM Department Type]
	,[EM_Staff_Member_Code] = [EM].[EM Staff Member Code]
	--
	,[dv_Initial_Assessment_DateTime] = TRY_CAST([CDS62_EC].[EM Initial Assessment Date] AS DATETIME) + TRY_CAST([EM].[EM Initial Assessment Time] AS DATETIME)
	,[dv_Treatment_DateTime] = TRY_CAST([CDS62_EC].[EM Date Seen For Treatment] AS DATETIME) + TRY_CAST([EM].[EM Time Seen For Treatment] AS DATETIME)
	,[dv_Attendance_Conclusion_DateTime] = TRY_CAST([CDS62_EC].[EM Attendance Conclusion Date] AS DATETIME) + TRY_CAST([EM].[EM Attendance Conclusion Time] AS DATETIME)
	--
	,[Primary_Investigation] = [EM].[EM Investigation First]
	,[Primary_Diagnosis] = [EM].[EM Diagnosis First]
	,[Primary_Treatment] = [EM].[EM Treatment First]
	,[Diagnosis_Scheme_In_Use] = [EM].[Diagnosis Scheme In Use]
	,[Investigation_Scheme_In_Use] = [EM].[Investigation Scheme In Use]
	--
	,[Local_Patient_Identifier] = [EM_Pseudo].[Local Patient Identifier]
	,[EM_Attendance_Number] = [EM_Pseudo].[EM Attendance Number]
	,[Unique_CDS_Identifier] = [EM_Pseudo].[Unique CDS Identifier]
	,[Commissioning_Serial_No] = [EM_Pseudo].[Commissioning Serial No (Agreement No)]
	,[Commissioner_Reference_No] = [EM_Pseudo].[Commissioner Reference No]
	,[Provider_Reference_No] = [EM_Pseudo].[Provider Reference No]
	,[NHS_Service_Agreement_Line_No] = [EM_Pseudo].[NHS Service Agreement Line No]
	--
	,[Core_HRG] = [EM].[Core HRG]
	--
	,[Provider_Site_Code] = [EM].[Provider Site Code]
	,[EM_Site_Code_Of_Treatment] = [CDS62_EC].[EM Site Code (Of Treatment)]
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM]
INNER JOIN [Casted].[AE_pbr_preprocess_EM_Pseudo] AS [EM_Pseudo]
	ON ([EM].[Generated Record ID] = [EM_Pseudo].[Generated Record ID])
INNER JOIN [Casted].[AE_pbr_preprocess_CDS62_EC] AS [CDS62_EC]
	ON ([EM].[Generated Record ID] = [CDS62_EC].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgComm]
	ON ([EM].[Organisation Code (Code Of Commissioner)] = [SK_OrgComm].[Organisation_Code])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgProv]
	ON ([EM].[Organisation Code (Code Of Provider)] = [SK_OrgProv].[Organisation_Code]);
