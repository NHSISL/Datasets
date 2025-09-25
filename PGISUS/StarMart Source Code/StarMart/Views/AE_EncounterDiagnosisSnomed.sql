CREATE VIEW [StarMart].[AE_EncounterDiagnosisSnomed]
AS
SELECT [Generated_Record_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	,[SK_Encounter_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	--
	,[Sequence_Number] = [CDS621_SUPP_EC].[Sequence Number]
	,[Code] = [CDS621_SUPP_EC].[Code]
	,[Qualifier] = [CDS621_SUPP_EC].[Qualifier]
	,[Qualifier_Is_Approved] = [CDS621_SUPP_EC].[Qualifier Is Approved]
	,[Coded_Clinical_Entry_Sequence_Number] = [CDS621_SUPP_EC].[Coded Clinical Entry Sequence Number]
	,[Is_Approved] = [CDS621_SUPP_EC].[Is Approved]
	--
	,[dv_Activity_Date] = [CDS621_SUPP_EC].[ActivityDate]
	,[dv_Activity_Period] = [CDS621_SUPP_EC].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
WHERE [CDS621_SUPP_EC].[Repeating Group] = 'EMERGENCY CARE DIAGNOSIS (SNOMED CT)';
