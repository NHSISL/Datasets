CREATE VIEW [StarMart].[AE_EncounterDiagnosis]
AS
SELECT [Generated_Record_ID] = [SUPP_EM].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_EM].[Generated Record ID]
	--
	,[Diagnosis_Number] = [SUPP_EM].[Sequence Number Diagnosis]
	,[Diagnosis_Code] = [SUPP_EM].[Secondary Diagnosis Code]
	--
	,[dv_Activity_Date] = [SUPP_EM].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_SUPP_EM] AS [SUPP_EM]
WHERE [SUPP_EM].[Sequence Number Diagnosis] IS NOT NULL
	OR [SUPP_EM].[Secondary Diagnosis Code] IS NOT NULL;
