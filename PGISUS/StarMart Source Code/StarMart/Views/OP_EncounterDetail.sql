CREATE VIEW [StarMart].[OP_EncounterDetail]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	,[CDS_Record_Type] = [OP].[CDS Record Type]
	--
	,[SK_Patient_ID] = [OP_Pseudo].[SK_PatientID]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [OP].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_Code_Of_Provider] = [OP].[Organisation Code (Code Of Provider)]
	--
	,[SK_Organisation_ID_Commissioner] = ISNULL([SK_OrgComm].[SK_OrganisationID], 1) -- [OP].[Organisation Code (Code Of Commissioner)]
	,[SK_Organisation_ID_Provider] = ISNULL([SK_OrgProv].[SK_OrganisationID], 1) -- [OP].[Organisation Code (Code Of Provider)]
	--
	,[dv_Encounter_Start_DateTime] = [OP].[Appointment Date]
	,[dv_Encounter_End_DateTime] = [OP].[Appointment Date]
	--
	--,[SK_Source_Of_Referral_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Source Of Referral For Outpatients]
	--,[SK_Admin_Category_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Administrative Category]
	--,[SK_Attendance_Type_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[First Attendance]
	--,[SK_Attendance_Outcome_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Outcome Of Attendance]
	--,[SK_DNA_Indicator_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Attended Or Did Not Attend]
	--,[SK_Consultant_ID] = TRY_CAST(NULL AS INT) -- [OP].[Consultant Code]
	--,[SK_Age_Band_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Age]
	--,[SK_Priority_Type_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Priority Type]
	--,[SK_Specialty_ID] = TRY_CAST(NULL AS SMALLINT) -- [OP].[Treatment Function Code]
	--,[SK_Consultant_Main_Specialty_ID] = TRY_CAST(NULL AS SMALLINT) -- [OP].[Main Specialty Code]
	--,[SK_Activity_Location_Type_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Location Type Code]
	--,[SK_RTT_Period_Status_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[RTT Status]
	--,[SK_Service_Type_Requested_ID] = TRY_CAST(NULL AS TINYINT) -- [OP].[Service Type Requested]
	--
	,[Age] = [OP].[Age]
	,[Source_Of_Referral_For_Outpatients] = [OP].[Source Of Referral For Outpatients]
	,[Administrative_Category] = [OP].[Administrative Category]
	,[First_Attendance] = [OP].[First Attendance]
	,[Outcome_Of_Attendance] = [OP].[Outcome Of Attendance]
	,[Attended_Or_Did_Not_Attend] = [OP].[Attended Or Did Not Attend]
	,[Consultant_Code] = [OP].[Consultant Code]
	,[Priority_Type] = [OP].[Priority Type]
	,[Treatment_Function_Code] = [OP].[Treatment Function Code]
	,[Main_Specialty_Code] = [OP].[Main Specialty Code]
	,[Local_Sub_Specialty_Code] = [CDS62_OP].[Local Sub Specialty Code]
	,[Location_Type_Code] = [OP].[Location Type Code]
	,[Service_Type_Requested] = [OP].[Service Type Requested]
	,[Direct_Access_Referral_Indicator] = [CDS62_OP].[Direct Access Referral Indicator]
	,[Direct_Access_Tariff_Flag] = [OP].[Direct Access Tariff Flag]
	,[Multi_Professional_or_Multi_Disciplinary_Indication_Code] = [CDS62_OP].[Multi-Professional Or Multi-Disciplinary Indication Code]
	,[Rehabilitation_Assessment_Team_Type] = [CDS62_OP].[Rehabilitation Assessment Team Type]
	,[Consultation_Medium_Used] = [CDS62_OP].[Consultation Medium Used]
	,[Referrer_Code] = [OP].[Referrer Code]
	,[Referring_Org_Code] = [OP].[Referring Organisation Code]
	--
	,[Is_Valid_UBRN] = [OP].[Is Valid UBRN]
	,[UBRN_Occurrence_Count] = [OP].[UBRN Occurrence Count]
	,[Referral_Request_Received_Date] = [OP].[Referral Request Received Date]
	,[Appointment_Time] = [CDS62_OP].[Appointment Time]
	,[Patient_Pathway_ID] = [OP_Pseudo].[RTT Patient Pathway Identifier]
	,[RTT_Status] = [OP].[RTT Status]
	,[RTT_Period_Start_Date] = [OP].[RTT Period Start Date]
	,[RTT_Period_End_Date] = [OP].[RTT Period End Date]
	--
	,[Primary_Procedure] = [OP].[Primary Procedure Code]
	,[Primary_Diagnosis] = [OP].[Primary Diagnosis Code]
	--
	,[Local_Patient_Identifier] = [OP_Pseudo].[Local Patient Identifier]
	,[Attendance_Identifier] = [OP_Pseudo].[Attendance Identifier]
	,[Unique_CDS_Identifier] = [OP_Pseudo].[Unique CDS Identifier]
	,[Commissioning_Serial_No] = [OP_Pseudo].[Commissioning Serial No (Agreement No)]
	,[Provider_Reference_No] = [OP_Pseudo].[Provider Reference No]
	,[NHS_Service_Agreement_Line_No] = [OP_Pseudo].[NHS Service Agreement Line No]
	--
	,[HRG_Submitted] = [OP].[HRG (Submitted)]
	,[SUS_HRG] = [OP].[SUS HRG]
	,[Core_HRG] = [OP].[Core HRG]
	,[Spell_NPOC] = [OP].[Spell NPOC]
	--
	,[SC_Service_Line_Code_National] = [OP].[Spell Service Line]
	--
	,[Local_Site_Code] = [OP].[Site Code Of Treatment]
	,[Clinic_Code] = [CDS62_OP].[Clinic Code]
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
INNER JOIN [Casted].[OP_pbr_preprocess_CDS62_OP] AS [CDS62_OP]
	ON ([OP].[Generated Record ID] = [CDS62_OP].[Generated Record ID])
INNER JOIN [Casted].[OP_pbr_preprocess_OP_Pseudo] AS [OP_Pseudo]
	ON ([OP].[Generated Record ID] = [OP_Pseudo].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgComm]
	ON ([OP].[Organisation Code (Code Of Commissioner)] = [SK_OrgComm].[Organisation_Code])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgProv]
	ON ([OP].[Organisation Code (Code Of Provider)] = [SK_OrgProv].[Organisation_Code]);
