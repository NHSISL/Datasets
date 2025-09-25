CREATE VIEW [StarMart].[OP_EncounterDiagnosis]
AS
SELECT [Generated_Record_ID] = [SUPP_OP].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_OP].[Generated Record ID]
	--
	,[Diagnosis_Number] = [SUPP_OP].[Sequence Number Diagnosis]
	,[Diagnosis_Code] = [SUPP_OP].[Secondary Diagnosis Code]
	--
	,[dv_Activity_Date] = [SUPP_OP].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_SUPP_OP] AS [SUPP_OP]
WHERE [SUPP_OP].[Sequence Number Diagnosis] IS NOT NULL
	OR [SUPP_OP].[Secondary Diagnosis Code] IS NOT NULL;
