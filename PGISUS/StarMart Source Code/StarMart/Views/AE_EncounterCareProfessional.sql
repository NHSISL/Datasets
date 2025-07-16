CREATE VIEW [StarMart].[AE_EncounterCareProfessional]
AS
SELECT [Generated_Record_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	,[SK_Encounter_ID] = [CDS621_SUPP_EC].[Generated Record ID] -- for backwards compatibility
	--
	,[Sequence_Number] = [CDS621_SUPP_EC].[Sequence Number]
	,[Code] = [CDS621_SUPP_EC].[Code] --PROFESSIONAL REGISTRATION ENTRY IDENTIFIER
	,[Issuer_Code] = [CDS621_SUPP_EC].[Issuer Code]
	,[Tier] = [CDS621_SUPP_EC].[Tier]
	,[Discharge_Responsibility_Indicator] = [CDS621_SUPP_EC].[Discharge Responsibility Indicator]
	,[Clinical_Responsibility_Timestamp] = [CDS621_SUPP_EC].[Clinical Responsibility Timestamp]
	,[Is_Approved] = [CDS621_SUPP_EC].[Is Approved]
	--
	,[dv_Activity_Date] = [CDS621_SUPP_EC].[ActivityDate]
	,[dv_Activity_Period] = [CDS621_SUPP_EC].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
WHERE [CDS621_SUPP_EC].[Repeating Group] = 'PROFESSIONAL REGISTRATION';
