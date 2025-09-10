CREATE VIEW [StarMart].[AE_EncounterTreatment]
AS
SELECT [Generated_Record_ID] = [SUPP_EM].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_EM].[Generated Record ID]
	--
	,[Treatment_Number] = [SUPP_EM].[Sequence Number Treatment]
	,[Treatment_Code] = [SUPP_EM].[EM Treatment Second]
	,[Procedure_Date] = [SUPP_EM].[Procedure Date (Of Subsequent Treatments)]
	--
	,[dv_Activity_Date] = [SUPP_EM].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_SUPP_EM] AS [SUPP_EM]
WHERE [SUPP_EM].[Sequence Number Treatment] IS NOT NULL
	OR [SUPP_EM].[EM Treatment Second] IS NOT NULL
	OR [SUPP_EM].[Procedure Date (Of Subsequent Treatments)] IS NOT NULL;
