CREATE PROCEDURE [Denormalised].[pMaterialise_vAE_EncounterDenormalised]
AS
BEGIN
	IF OBJECT_ID('[Denormalised].[Materialised_vAE_EncounterDenormalised]') IS NOT NULL
		DROP TABLE [Denormalised].[Materialised_vAE_EncounterDenormalised];

	CREATE TABLE [Denormalised].[Materialised_vAE_EncounterDenormalised]
		WITH (
				CLUSTERED COLUMNSTORE INDEX
				,DISTRIBUTION = HASH ([Organisation_Code_Code_Of_Commissioner])
				) AS

	SELECT *
	FROM [Denormalised].[vAE_EncounterDenormalised]
	WHERE 1 = 2;

	INSERT INTO [Denormalised].[Materialised_vAE_EncounterDenormalised]
	SELECT *
	FROM [Denormalised].[vAE_EncounterDenormalised];
END
