CREATE VIEW [StarMart].[IP_EncounterDetail]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[Spell_Identifier] = [EP].[Spell Identifier]
	,[CDS_Record_Type] = [EP].[CDS Record Type]
	--
	,[SK_Patient_ID] = [EP_Pseudo].[SK_PatientID]
	--
	,[Organisation_Code_Code_Of_Commissioner] = [EP].[Organisation Code (Code Of Commissioner)]
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	--
	,[SK_Organisation_ID_Commissioner] = ISNULL([SK_OrgComm].[SK_OrganisationID], 1)
	,[SK_Organisation_ID_Provider] = ISNULL([SK_OrgProv].[SK_OrganisationID], 1)
	--
	,[dv_Encounter_Start_DateTime] = [EP].[Episode Start Date]
	,[dv_Encounter_End_DateTime] = [EP].[Episode End Date]
	--
	--,[SK_Admission_Method_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Admission Method (Hospital Provider Spell)]
	--,[SK_Admission_Source_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Source Of Admission (Hospital Provider Spell)]
	--,[SK_Specialty_ID] = TRY_CAST(NULL AS SMALLINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Main Specialty Code]
	--,[SK_Consultant_ID] = TRY_CAST(NULL AS INT) -- TODO -- ISNULL( , 1 ) -- [EP].[Consultant Code]
	--,[SK_Treatment_Function_Code] = TRY_CAST(NULL AS SMALLINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Treatment Function Code]
	--,[SK_Admin_Category_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Administrative Category (On Admission)]
	--,[SK_Discharge_Method_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Discharge Method (Hospital Provider Spell)]
	--,[SK_Discharge_Destination_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Discharge Destination (Hospital Provider Spell)]
	--,[SK_Patient_Classification_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Patient Classification]
	--,[SK_Age_Band_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Age At CDS Activity Date]
	--,[SK_RTT_Period_Status_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[RTT Status]
	--,[SK_Legal_Status_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Legal Status Classification Code]
	--,[SK_Intended_Management_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( , 1 ) -- [EP].[Intended Management]
	--,[SK_Operation_Status_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- [EP].[Operation Status]
	--
	,[Age_At_CDS_Activity_Date] = [EP].[Age At CDS Activity Date]
	,[Admission_Method_Hospital_Provider_Spell] = [EP].[Admission Method (Hospital Provider Spell)]
	,[Source_Of_Admission_Hospital_Provider_Spell] = [EP].[Source Of Admission (Hospital Provider Spell)]
	,[Main_Specialty_Code] = [EP].[Main Specialty Code]
	,[Consultant_Code] = [EP].[Consultant Code]
	,[Treatment_Function_Code] = [EP].[Treatment Function Code]
	,[Administrative_Category_On_Admission] = [EP].[Administrative Category (On Admission)]
	,[Discharge_Method_Hospital_Provider_Spell] = [EP].[Discharge Method (Hospital Provider Spell)]
	,[Discharge_Destination_Hospital_Provider_Spell] = [EP].[Discharge Destination (Hospital Provider Spell)]
	,[Patient_Classification] = [EP].[Patient Classification]
	,[Legal_Status_Classification_Code] = [EP].[Legal Status Classification Code]
	,[Intended_Management] = [EP].[Intended Management]
	,[Operation_Status] = [EP].[Operation Status]
	,[Referrer_Code] = [EP].[Referrer Code]
	,[Referring_Org_Code] = [EP].[Referring Organisation Code]
	,[Age_Group_Intended_At_Epiend] = [EP].[Age Group Intended At Epiend]
	,[Local_Sub_Specialty_Code] = [CDS62_EP].[Local Sub Specialty Code]
	,[Neonatal_Level_Of_Care] = [EP].[Neonatal Level Of Care]
	--
	,[Episode_Number] = [EP].[Episode Number]
	,[Admission_Date] = [EP].[Start Date (Hospital Provider Spell)]
	,[Discharge_Date] = COALESCE([EP].[Hospital Provider Spell End Date], [EP].[Episode End Date])
	,[Date_Of_Decision_To_Admit] = [EP].[Decided To Admit Date]
	,[Date_Of_Primary_Procedure] = [EP].[Primary Procedure Date]
	,[Ready_For_Discharge_Date] = [EP].[Ready For Discharge Date]
	,[Spell_Discharge_Time] = [CDS62_EP].[Discharge Time (Hospital Provider Spell)]
	,[Spell_Start_Time] = [CDS62_EP].[Start Time (Hospital Provider Spell)]
	,[Patient_Pathway_ID] = [EP_Pseudo].[RTT Patient Pathway Identifier]
	,[RTT_Status] = [EP].[RTT Status]
	,[RTT_Period_Start_Date] = [EP].[RTT Period Start Date]
	,[RTT_Period_End_Date] = [EP].[RTT Period End Date]
	--
	,[Primary_Procedure] = [EP].[Primary Procedure Code]
	,[Primary_Diagnosis] = [EP].[Primary Diagnosis Code]
	--
	,[Local_Patient_Identifier] = [EP_Pseudo].[Local Patient Identifier]
	,[Hospital_Provider_Spell_Number] = [EP_Pseudo].[Hospital Provider Spell No]
	,[Unique_CDS_Identifier] = [EP_Pseudo].[Unique CDS Identifier]
	,[Commissioning_Serial_No] = [EP_Pseudo].[Commissioning Serial No (Agreement No)]
	,[Commissioner_Reference_Number] = [EP_Pseudo].[Commissioner Reference No]
	,[Provider_Reference_No] = [EP_Pseudo].[Provider Reference No]
	,[NHS_Service_Agreement_Line_No] = [EP_Pseudo].[NHS Service Agreement Line No]
	--
	,[Excess_Bed_Days] = [EP].[PbR Days Beyond Trimpoint]
	--
	,[Core_HRG_Calculated] = [EP].[Core HRG (Calculated)]
	,[Spell_Core_HRG] = [EP].[Spell Core HRG]
	--
	,[Specialist_Commissioning_Service_Line_Code_National] = [EP].[FCE Service Line]
	,[Specialist_Commissioning_Service_Line_Code_National_Spell] = [EP].[Spell Service Line]
	,[Programme_Budget_Code] = [EP].[Programme Budgeting Category]
	--
	,[Local_Site_Code] = [EP].[Site Code Of Treatment (At Start Of Episode)]
	,[Ward_Code_At_Episode_Start] = [EP].[Ward Code At Episode Start Date]
	,[Ward_Code_At_Episode_End] = [EP].[Ward Code At Episode End Date]
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_EP_Pseudo] AS [EP_Pseudo]
	ON ([EP].[Generated Record ID] = [EP_Pseudo].[Generated Record ID])
INNER JOIN [Casted].[IP_pbr_preprocess_CDS62_EP] AS [CDS62_EP]
	ON ([EP].[Generated Record ID] = [CDS62_EP].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgComm]
	ON ([EP].[Organisation Code (Code Of Commissioner)] = [SK_OrgComm].[Organisation_Code])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgProv]
	ON ([EP].[Organisation Code (Code Of Provider)] = [SK_OrgProv].[Organisation_Code]);
