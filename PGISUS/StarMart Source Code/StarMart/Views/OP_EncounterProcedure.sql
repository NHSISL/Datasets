CREATE VIEW [StarMart].[OP_EncounterProcedure]
AS
SELECT [Generated_Record_ID] = [SUPP_OP].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_OP].[Generated Record ID]
	--
	,[Procedure_Number] = [SUPP_OP].[Sequence Number Procedure]
	,[Procedure_Code] = [SUPP_OP].[Secondary Procedure Code]
	,[Procedure_Date] = [SUPP_OP].[Secondary Procedure Date]
	--
	,[dv_Activity_Date] = [SUPP_OP].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_SUPP_OP] AS [SUPP_OP]
WHERE [SUPP_OP].[Sequence Number Procedure] IS NOT NULL
	OR [SUPP_OP].[Secondary Procedure Code] IS NOT NULL
	OR [SUPP_OP].[Secondary Procedure Date] IS NOT NULL;
