CREATE VIEW [StarMart].[AE_EncounterRelatedOrganisation]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_EncounterID] = [EM].[Generated Record ID]
	,[OrganisationCode] = TRY_CAST([EM].[OrganisationCode] AS VARCHAR(10))
	,[ActivityPeriod] = [EM].[ActivityPeriod]
FROM [Casted].[AE_Attribution] AS [EM];
