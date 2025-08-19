CREATE VIEW [Casted].[AE_Attribution]
AS
SELECT [Generated Record ID] = [EM].[Generated Record ID]
	,[OrganisationCode] = [X].[OrganisationCode]
	,[ActivityPeriod] = [EM].[ActivityPeriod]
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM]
CROSS APPLY (
	SELECT [EM].[Organisation Code (Code Of Commissioner)]
	
	UNION ALL
	
	SELECT [EM].[Commissioner Code (Original Data)]
	
	UNION ALL
	
	SELECT [EM].[Organisation Code (PCT Of Residence)]
	
	UNION ALL
	
	SELECT [EM].[PCT Of Residence (Original)]
	
	UNION ALL
	
	SELECT [EM].[PCT Derived From GP Practice]
	
	UNION ALL
	
	SELECT [EM].[Patient Postcode Derived PCT]
	
	UNION ALL
	
	SELECT [EM].[Prime Recipient]
	
	UNION ALL
	
	SELECT [EM].[Derived Commissioner]
	
	UNION ALL
	
	SELECT [EM].[Organisation Code (Code Of Provider)]
	
	UNION ALL
	
	SELECT [EM].[Provider Code (Original Data)]
	
	UNION ALL
	
	SELECT [value]
	FROM STRING_SPLIT([EM].[Copy Recipients], ' ')
		--UNION ALL SELECT [EM].[Commissioner Site Code] -- Obsolete
		--UNION ALL SELECT [EM].[PCT Derived From GP] -- Obsolete
	) AS [X]([OrganisationCode])
WHERE [X].[OrganisationCode] IS NOT NULL
GROUP BY [EM].[Generated Record ID]
	,[EM].[ActivityPeriod]
	,[X].[OrganisationCode];
