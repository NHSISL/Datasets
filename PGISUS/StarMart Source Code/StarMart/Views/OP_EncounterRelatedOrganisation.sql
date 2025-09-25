CREATE VIEW [StarMart].[OP_EncounterRelatedOrganisation]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_EncounterID] = [OP].[Generated Record ID]
	,[OrganisationCode] = TRY_CAST([OP].[OrganisationCode] AS VARCHAR(10))
	,[ActivityPeriod] = [OP].[ActivityPeriod]
FROM [Casted].[OP_Attribution] AS [OP]
