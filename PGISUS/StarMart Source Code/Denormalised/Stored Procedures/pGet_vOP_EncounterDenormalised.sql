CREATE PROCEDURE [Denormalised].[pGet_vOP_EncounterDenormalised] @SourceSchemaName [VARCHAR] (30)
	,@SourceTable [VARCHAR] (300)
	,@Organisation [VARCHAR] (25)
AS
BEGIN
	--DECLARE @Organisation VARCHAR(20) = '36L';
	SELECT [T].*
	FROM [Denormalised].[Materialised_vOP_EncounterDenormalised] AS [T]
	WHERE EXISTS (
			SELECT NULL
			FROM [Denormalised].[Materialised_Casted_OP_Attribution] AS [R]
			WHERE [R].[Generated Record ID] = [T].[Generated_Record_ID]
				AND [R].[ActivityPeriod] = [T].[ActivityPeriod]
				AND [R].[OrganisationCode] IN (
					SELECT [F].[OrganisationCode_Descendent]
					FROM [Reference].[Dictionary_NELCSU_OrganisationDisseminationDescendent] AS [F]
					WHERE [F].[OrganisationCode_AnchorOrganisation] = @Organisation -- as target recipient i.e. '36L'
						AND [F].[OrganisationPrimaryRole] IN (
							'RO172' --ISP HQ
							, 'RO176' --ISP site Y
							, 'RO197' --nhs trust
							, 'RO198' --nhs trust site
							, 'RO98' --ICB
							, 'RO261' --STP
							, 'RO209' --NHSE Region
							, 'RO210' --NHSE Region Office
							, 'RO180' --PCT site??
							, 'RO179' --PCT ??
							)
					)
			)
END
