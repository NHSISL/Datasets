CREATE VIEW [Casted].[IP_Attribution]
AS
SELECT [Generated Record ID] = [EP].[Generated Record ID]
	,[OrganisationCode] = [X].[OrganisationCode]
	,[ActivityPeriod] = [EP].[ActivityPeriod]
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
CROSS APPLY (
	SELECT [EP].[Organisation Code (Code Of Commissioner)]
	
	UNION ALL
	
	SELECT [EP].[Commissioner Code (Original Data)]
	
	UNION ALL
	
	SELECT [EP].[Organisation Code (PCT Of Residence)]
	--UNION ALL SELECT [EP].[PCT Of Residence (Original)]
	
	UNION ALL
	
	SELECT [EP].[PCT Derived From GP Practice]
	
	UNION ALL
	
	SELECT [EP].[Patient Postcode Derived PCT]
	
	UNION ALL
	
	SELECT [EP].[Prime Recipient]
	
	UNION ALL
	
	SELECT [EP].[Derived Commissioner]
	
	UNION ALL
	
	SELECT [EP].[Organisation Code (Code Of Provider)]
	
	UNION ALL
	
	SELECT [EP].[Provider Code (Original Data)]
	
	UNION ALL
	
	SELECT [value]
	FROM STRING_SPLIT([EP].[Copy Recipients], ' ')
		--UNION ALL SELECT [EM].[Commissioner Site Code] -- Obsolete
		--UNION ALL SELECT [EM].[PCT Derived From GP] -- Obsolete
	) AS [X]([OrganisationCode])
WHERE [X].[OrganisationCode] IS NOT NULL
GROUP BY [EP].[Generated Record ID]
	,[EP].[ActivityPeriod]
	,[X].[OrganisationCode];
