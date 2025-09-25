CREATE VIEW [StarMart].[AE_EncounterPatient]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_EncounterID] = [EM].[Generated Record ID]
	--
	,[SK_Patient_ID] = [EM_Pseudo].[SK_PatientID]
	--,[SK_Gender_ID] = TRY_CAST(NULL AS TINYINT) -- TODO -- ISNULL( [EM].[Gender Code], 1 )
	--,[SK_Ethnicity_ID] = TRY_CAST(NULL AS SMALLINT) -- TODO -- ISNULL( [EM].[Ethnic Category Code], 1 )
	,[SK_Organisation_ID_Practice] = ISNULL([SK_OrgPrac].[SK_OrganisationID], 1)
	--,[SK_Postcode_ID] = [Postcode].[SK_PostcodeID]
	--
	,[Date_Of_Birth] = ISNULL([EM_Pseudo].[dv_Birth Date (Rounded)], '1900-01-01')
	,[Age] = TRY_CAST(COALESCE([EM_Pseudo].[dv_Age At CDS Activity Date], [EM].[Derived Age], [EM].[Age At CDS Activity Date]) AS SMALLINT)
	,[dv_Age_In_Month] = [dbo].[AgeAtEventInMonths]([EM_Pseudo].[dv_Birth Date (Rounded)], [EM].[ActivityDate])
	,[Gender_Code] = [EM].[Gender Code]
	,[Ethnic_Category_Code] = [EM].[Ethnic Category Code]
	,[dv_Pseudo_Postcode] = [EM_Pseudo].[dv_Pseudo_Postcode]
	,[dv_LSOA_Code] = [EM_Pseudo].[dv_LSOA]
	--
	,[Registered_GMP_Code_Original_Data] = [EM].[Registered GMP Code (Original Data)]
	,[GP_Practice_Code_Original_Data] = [EM].[GP Practice Code (Original Data)]
	,[GP_Practice_Code] = [EM].[GP Practice Code]
	,[Is_GP_Practice_Derived_from_PDS] = [EM].[GP Practice Derived From PDS]
	,[Organisation_Code_Code_Of_Provider] = [EM].[Organisation Code (Code Of Provider)]
	--
	,[Withheld_Identity_Reason] = [CDS62_EC].[Withheld Identity Reason]
	,[Confidentiality_Category] = [EM].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [EM].[NHS Number Status Indicator]
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_EC].[OSV Status Classification At CDS Activity Date]
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM]
INNER JOIN [Casted].[AE_pbr_preprocess_EM_Pseudo] AS [EM_Pseudo]
	ON ([EM].[Generated Record ID] = [EM_Pseudo].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Postcode] AS [Postcode]
	ON ([EM_Pseudo].[dv_Pseudo_Postcode] = [Postcode].[Postcode_8_chars])
LEFT JOIN [Casted].[AE_pbr_preprocess_CDS62_EC] AS [CDS62_EC]
	ON ([EM].[Generated Record ID] = [CDS62_EC].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgPrac]
	ON ([EM].[GP Practice Code] = [SK_OrgPrac].[Organisation_Code]);
