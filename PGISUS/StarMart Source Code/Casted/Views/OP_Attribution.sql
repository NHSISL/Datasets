CREATE VIEW [Casted].[OP_Attribution]
AS
SELECT [Generated Record ID] = [OP].[Generated Record ID]
	,[OrganisationCode] = [X].[OrganisationCode]
	,[ActivityPeriod] = [OP].[ActivityPeriod]
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP]
CROSS APPLY (
	SELECT [OP].[Organisation Code (Code Of Commissioner)]
	
	UNION ALL
	
	SELECT [OP].[Commissioner Code (Original Data)]
	
	UNION ALL
	
	SELECT [OP].[Organisation Code (PCT Of Residence)]
	
	UNION ALL
	
	SELECT [OP].[PCT Of Residence (Original)]
	
	UNION ALL
	
	SELECT [OP].[PCT Derived From GP Practice]
	
	UNION ALL
	
	SELECT [OP].[Patient Postcode Derived PCT]
	
	UNION ALL
	
	SELECT [OP].[Prime Recipient]
	
	UNION ALL
	
	SELECT [OP].[Derived Commissioner]
	
	UNION ALL
	
	SELECT [OP].[Organisation Code (Code Of Provider)]
	
	UNION ALL
	
	SELECT [OP].[Provider Site Code]
	
	UNION ALL
	
	SELECT [value]
	FROM STRING_SPLIT([OP].[Copy Recipients], ' ')
		--UNION ALL SELECT [EM].[Commissioner Site Code] -- Obsolete
		--UNION ALL SELECT [EM].[PCT Derived From GP] -- Obsolete
	) AS [X]([OrganisationCode])
WHERE [X].[OrganisationCode] IS NOT NULL
GROUP BY [OP].[Generated Record ID]
	,[OP].[ActivityPeriod]
	,[X].[OrganisationCode];
