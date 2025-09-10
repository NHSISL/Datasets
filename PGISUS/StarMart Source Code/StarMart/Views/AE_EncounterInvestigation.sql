CREATE VIEW [StarMart].[AE_EncounterInvestigation]
AS
SELECT [Generated_Record_ID] = [SUPP_EM].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_EM].[Generated Record ID]
	--
	,[Investigation_Number] = [SUPP_EM].[Sequence Number Investigation]
	,[Investigation_Code] = [SUPP_EM].[EM Investigation Second]
	--
	,[dv_Activity_Date] = [SUPP_EM].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_SUPP_EM] AS [SUPP_EM]
WHERE [SUPP_EM].[Sequence Number Investigation] IS NOT NULL
	OR [SUPP_EM].[EM Investigation Second] IS NOT NULL;
