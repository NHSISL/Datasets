CREATE VIEW [StarMart].[IP_EncounterProcedure]
AS
SELECT [Generated_Record_ID] = [SUPP_EP].[Generated Record ID]
	,[SK_Encounter_ID] = [SUPP_EP].[Generated Record ID]
	,[Spell_Identifier] = [SUPP_EP].[Spell ID]
	--
	,[Procedure_Number] = [SUPP_EP].[Sequence Number Procedure]
	,[Procedure_Code] = [SUPP_EP].[Secondary Procedure Code]
	,[Procedure_Date] = [SUPP_EP].[Secondary Procedure Date]
	--
	,[dv_Activity_Date] = [SUPP_EP].[ActivityDate]
	,[dv_Activity_Period] = [SUPP_EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_SUPP_EP] AS [SUPP_EP]
WHERE [SUPP_EP].[Sequence Number Procedure] IS NOT NULL
	OR [SUPP_EP].[Secondary Procedure Code] IS NOT NULL
	OR [SUPP_EP].[Secondary Procedure Date] IS NOT NULL;
