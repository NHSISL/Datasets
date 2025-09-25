CREATE VIEW [StarMart].[IP_EncounterPatient]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[Spell_Identifier] = [EP].[Spell Identifier]
	--
	,[SK_Patient_ID] = [EP_Pseudo].[SK_PatientID]
	--,[SK_Gender_ID] = TRY_CAST(NULL AS TINYINT) -- [EP].[Gender Code]
	--,[SK_Ethnicity_ID] = TRY_CAST(NULL AS SMALLINT) -- [EP].[Ethnic Category Code]
	,[SK_Organisation_ID_PracticeID] = ISNULL([SK_OrgPrac].[SK_OrganisationID], 1)
	--,[SK_Postcode_ID] = [Postcode].[SK_PostcodeID]
	--
	,[Date_Of_Birth] = ISNULL([EP_Pseudo].[dv_Birth Date (Rounded)], '1900-01-01')
	,[Age] = TRY_CAST(COALESCE([EP_Pseudo].[dv_Age At CDS Activity Date], [EP].[Age At CDS Activity Date], [EP].[Spell Age], [EP].[Age At Spell End Original], [EP].[Age At End Of Spell]) AS SMALLINT)
	,[dv_Age_In_Month] = [dbo].[AgeAtEventInMonths]([EP_Pseudo].[dv_Birth Date (Rounded)], [EP].[ActivityDate])
	,[Gender_Code] = [EP].[Gender Code]
	,[Ethnic_Category_Code] = [EP].[Ethnic Category Code]
	,[dv_Pseudo_Postcode] = [EP_Pseudo].[dv_Pseudo_Postcode]
	,[dv_LSOA_Code] = [EP_Pseudo].[dv_LSOA]
	--
	,[GP_Code_Original_Data] = [EP].[GP Code (Original Data)]
	,[GP_Practice_Code_Original_Data] = [EP].[GP Practice Code (Original Data)]
	,[GP_Practice_Code_Derived] = [EP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = [EP].[GP Practice Derived From PDS]
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	--
	,[Withheld_Identity_Reason] = [CDS62_EP].[Withheld Identity Reason]
	,[Confidentiality_Category] = [EP].[Confidentiality Category]
	,[NHS_Number_Status_Indicator] = [EP].[NHS Number Status Indicator]
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_EP].[OSV Status Classification At CDS Activity Date]
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_EP_Pseudo] AS [EP_Pseudo]
	ON ([EP].[Generated Record ID] = [EP_Pseudo].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Postcode] AS [Postcode]
	ON ([EP_Pseudo].[dv_Pseudo_Postcode] = [Postcode].[Postcode_8_chars])
LEFT JOIN [Casted].[IP_pbr_preprocess_CDS62_EP] AS [CDS62_EP]
	ON ([EP].[Generated Record ID] = [CDS62_EP].[Generated Record ID])
LEFT JOIN [Reference].[Dictionary_dbo_Organisation] AS [SK_OrgPrac]
	ON ([EP].[GP Practice Code (Derived)] = [SK_OrgPrac].[Organisation_Code]);
