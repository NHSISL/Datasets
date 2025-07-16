CREATE VIEW [StarMart].[OP_EncounterPatient]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	--
	,[SK_Patient_ID] = [OP_Pseudo].[SK_PatientID]
	--,[SK_Gender_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [OP].[Gender Code], 1 )
	--,[SK_Ethnicity_ID] = TRY_CAST(NULL AS SMALLINT) -- TODO -- ISNULL( [OP].[Ethnic Category Code], 1 )
	,[SK_Organisation_ID_Practice] = ISNULL([SK_OrgPrac].[SK_OrganisationID], 1) -- [OP].[GP Practice Code (Derived)]
	--,[SK_Postcode_ID] = [Postcode].[SK_PostcodeID]
	--
	,[Date_Of_Birth] = ISNULL([OP_Pseudo].[dv_Birth Date (Rounded)], '1900-01-01')
	,[Age] = TRY_CAST(COALESCE([OP_Pseudo].[dv_Age At CDS Activity Date], [OP].[Derived Age], [OP].[Age]) AS SMALLINT)
	,[dv_Age_In_Month] = [dbo].[AgeAtEventInMonths]([OP_Pseudo].[dv_Birth Date (Rounded)], [OP].[ActivityDate])
	,[Gender_Code] = [OP].[Gender Code]
	,[Ethnic_Category_Code] = [OP].[Ethnic Category Code]
	,[dv_Pseudo_Postcode] = [OP_Pseudo].[dv_Pseudo_Postcode]
	,[dv_LSOA_Code] = [OP_Pseudo].[dv_LSOA]
	--
	,[GP_Code_Original_Data] = [OP].[GP Code]
	,[GP_Practice_Code_Original_Data] = [OP].[GP Practice Code (Original Data)]
	,[GP_Practice_Code_Derived] = [OP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = [OP].[GP Practice Derived From PDS]
	,[Organisation_Code_Code_Of_Provider] = [OP].[Organisation Code (Code Of Provider)]
	--
	,[Withheld_Identity_Reason] = [CDS62_OP].[Withheld Identity Reason]
	,[Confidentiality_Category] = [OP].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [OP].[NHS Number Status Indicator]
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_OP].[OSV Status Classification At CDS Activity Date]
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
INNER JOIN [Casted].[OP_pbr_preprocess_OP_Pseudo] AS [OP_Pseudo]
	ON ([OP].[Generated Record ID] = [OP_Pseudo].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Postcode] AS [Postcode]
	ON ([OP_Pseudo].[dv_Pseudo_Postcode] = [Postcode].[Postcode_8_chars])
LEFT JOIN [Casted].[OP_pbr_preprocess_CDS62_OP] AS [CDS62_OP]
	ON ([OP].[Generated Record ID] = [CDS62_OP].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgPrac]
	ON ([OP].[GP Practice Code (Derived)] = [SK_OrgPrac].[Organisation_Code]);
