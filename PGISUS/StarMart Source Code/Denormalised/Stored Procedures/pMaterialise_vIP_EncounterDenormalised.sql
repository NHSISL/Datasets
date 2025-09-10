CREATE PROCEDURE [Denormalised].[pMaterialise_vIP_EncounterDenormalised]
AS
BEGIN
	IF OBJECT_ID('[Denormalised].[Materialised_vIP_EncounterDenormalised]') IS NOT NULL
		DROP TABLE [Denormalised].[Materialised_vIP_EncounterDenormalised];

	CREATE TABLE [Denormalised].[Materialised_vIP_EncounterDenormalised]
		WITH (
				CLUSTERED COLUMNSTORE INDEX
				,DISTRIBUTION = HASH ([Organisation_Code_Code_Of_Commissioner])
				) AS

	SELECT *
	FROM [Denormalised].[vIP_EncounterDenormalised]
	WHERE 1 = 2;

	INSERT INTO [Denormalised].[Materialised_vIP_EncounterDenormalised]
	SELECT *
	FROM [Denormalised].[vIP_EncounterDenormalised];
END
