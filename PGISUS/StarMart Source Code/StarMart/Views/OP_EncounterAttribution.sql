CREATE VIEW [StarMart].[OP_EncounterAttribution]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	--
	,[Provider_Code_Provider_Supplied] = [OP].[Provider Site Code]
	,[Provider_Code_Provider_Validated] = [OP].[Organisation Code (Code Of Provider)]
	--
	,[Commissioner_Code_Provider_Supplied] = [OP].[Commissioner Code (Original Data)]
	,[Commissioner_Code_Provider_Validated] = [OP].[Organisation Code (Code Of Commissioner)]
	,[Commissioner_Code_Provider_Supplied_From_Residence] = [OP].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_SUS_Derived_From_Practice_Code] = [OP].[PCT Derived From GP Practice]
	,[Commissioner_Code_SUS_Derived_From_Residence] = [OP].[Patient Postcode Derived PCT]
	,[Derived_Commissioner] = [OP].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [OP].[Derived Commissioner Type]
	--
	,[Practice_Code_Provider_Supplied] = [OP].[GP Practice Code (Original Data)]
	,[Practice_Code_SUS_Derived] = [OP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = [OP].[GP Practice Derived From PDS]
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP];
