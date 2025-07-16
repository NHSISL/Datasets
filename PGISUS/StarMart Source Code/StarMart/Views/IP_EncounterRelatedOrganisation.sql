CREATE VIEW [StarMart].[IP_EncounterRelatedOrganisation]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_EncounterID] = [EP].[Generated Record ID]
	,[OrganisationCode] = TRY_CAST([EP].[OrganisationCode] AS VARCHAR(10))
	,[ActivityPeriod] = [EP].[ActivityPeriod]
FROM [Casted].[IP_Attribution] AS [EP];
