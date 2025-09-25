CREATE VIEW [StarMart].[IP_EncounterAttribution]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[Spell_Identifier] = [EP].[Spell Identifier]
	--
	,[Provider_Code_Provider_Supplied] = [EP].[Provider Code (Original Data)]
	,[Provider_Code_Provider_Validated] = [EP].[Organisation Code (Code Of Provider)]
	--
	,[Commissioner_Code_Provider_Supplied] = [EP].[Commissioner Code (Original Data)]
	,[Commissioner_Code_Provider_Validated] = [EP].[Organisation Code (Code Of Commissioner)]
	,[Commissioner_Code_Provider_Supplied_From_Residence] = [EP].[Organisation Code (PCT Of Residence)]
	,[Commissioner_Code_SUS_Derived_From_Practice_Code] = [EP].[PCT Derived From GP Practice]
	,[Commissioner_Code_SUS_Derived_From_Residence] = [EP].[Patient Postcode Derived PCT]
	,[Derived_Commissioner] = [EP].[Derived Commissioner]
	,[Derived_Commissioner_Type] = [EP].[Derived Commissioner Type]
	--
	,[Practice_Code_Provider_Supplied] = [EP].[GP Practice Code (Original Data)]
	,[Practice_Code_SUS_Derived] = [EP].[GP Practice Code (Derived)]
	,[Is_GP_Practice_Derived_from_PDS] = [EP].[GP Practice Derived From PDS]
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
