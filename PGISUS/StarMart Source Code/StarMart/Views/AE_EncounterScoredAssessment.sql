CREATE VIEW [StarMart].[AE_EncounterScoredAssessment]
AS
SELECT [Generated_Record_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	,[SK_Encounter_ID] = [CDS621_SUPP_EC].[Generated Record ID] -- for backwards compatibility
	--
	,[Sequence_Number] = [CDS621_SUPP_EC].[Sequence Number]
	,[Code] = [CDS621_SUPP_EC].[Code] --CODED SCORED ASSESSMENT
	,[Person_Score] = [CDS621_SUPP_EC].[Person Score]
	,[Assessment_Tool_Validation_Timestamp] = [CDS621_SUPP_EC].[Assessment Tool Validation Timestamp]
	,[Is_Approved] = [CDS621_SUPP_EC].[Is Approved]
	--
	,[dv_Activity_Date] = [CDS621_SUPP_EC].[ActivityDate]
	,[dv_Activity_Period] = [CDS621_SUPP_EC].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
WHERE [CDS621_SUPP_EC].[Repeating Group] = 'CODED SCORED ASSESSMENT';
