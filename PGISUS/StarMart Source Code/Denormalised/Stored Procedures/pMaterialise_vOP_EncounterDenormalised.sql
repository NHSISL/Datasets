CREATE PROCEDURE [Denormalised].[pMaterialise_vOP_EncounterDenormalised]
AS
BEGIN
	IF OBJECT_ID('[Denormalised].[Materialised_vOP_EncounterDenormalised]') IS NOT NULL
		DROP TABLE [Denormalised].[Materialised_vOP_EncounterDenormalised];

	CREATE TABLE [Denormalised].[Materialised_vOP_EncounterDenormalised]
		WITH (
				CLUSTERED COLUMNSTORE INDEX
				,DISTRIBUTION = HASH ([Organisation_Code_Code_Of_Commissioner])
				) AS

	SELECT *
	FROM [Denormalised].[vOP_EncounterDenormalised]
	WHERE 1 = 2;

	INSERT INTO [Denormalised].[Materialised_vOP_EncounterDenormalised]
	SELECT *
	FROM [Denormalised].[vOP_EncounterDenormalised];
END
