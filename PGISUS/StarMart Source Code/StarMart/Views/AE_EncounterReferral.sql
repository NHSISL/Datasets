CREATE VIEW [StarMart].[AE_EncounterReferral]
AS
SELECT [Generated_Record_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	,[SK_Encounter_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	--
	,[Sequence_Number] = [CDS621_SUPP_EC].[Sequence Number]
	,[Code] = [CDS621_SUPP_EC].[Code] --REFERRED TO SERVICE (SNOMED CT)
	,[Activity_Service_Request_Date] = [CDS621_SUPP_EC].[Activity Service Request Date]
	,[Activity_Service_Request_Time] = [CDS621_SUPP_EC].[Activity Service Request Time]
	,[Assessment_Date] = [CDS621_SUPP_EC].[Assessment Date]
	,[Assessment_Time] = [CDS621_SUPP_EC].[Assessment Time]
	,[Is_Approved] = [CDS621_SUPP_EC].[Is Approved]
	--
	,[dv_Activity_Date] = [CDS621_SUPP_EC].[ActivityDate]
	,[dv_Activity_Period] = [CDS621_SUPP_EC].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
WHERE [CDS621_SUPP_EC].[Repeating Group] = 'REFERRED TO SERVICE';
