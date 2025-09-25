CREATE VIEW [StarMart].[AE_EncounterAttribution]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_Encounter_ID] = [EM].[Generated Record ID] -- for backwards compatibility
	--
	,[Provider_Code_Provider_Supplied] = [EM].[Provider Code (Original Data)]
	,[Provider_Code_Provider_Validated] = [EM].[Organisation Code (Code Of Provider)]
	--
	,[Commissioner_Code_Provider_Supplied] = [EM].[Commissioner Code (Original Data)]
	,[Commissioner_Code_Provider_Validated] = [EM].[Organisation Code (Code Of Commissioner)]
	,[Commissioner_Code_Provider_Supplied_From_Residence] = [EM].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_SUS_Derived_From_Practice_Code] = [EM].[PCT Derived From GP Practice]
	,[Commissioner_Code_SUS_Derived_From_Residence] = [EM].[Patient Postcode Derived PCT]
	,[Derived_Commissioner] = [EM].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [EM].[Derived Commissioner Type]
	--
	,[Practice_Code_Provider_Supplied] = [EM].[GP Practice Code (Original Data)]
	,[Practice_Code_SUS_Derived] = [EM].[GP Practice Code] --equivalent column in other schema is [GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = [EM].[GP Practice Derived From PDS]
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM];
