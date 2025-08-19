CREATE PROCEDURE [Denormalised].[pMaterialised_SUS_Views_All]
AS
BEGIN
	EXEC [Denormalised].[pMaterialise_Casted_AE_Encounter];

	EXEC [Denormalised].[pMaterialise_Casted_IP_Encounter];

	EXEC [Denormalised].[pMaterialise_Casted_OP_Encounter];

	EXEC [Denormalised].[pMaterialise_vAE_EncounterDenormalised];

	EXEC [Denormalised].[pMaterialise_vIP_EncounterDenormalised];

	EXEC [Denormalised].[pMaterialise_vOP_EncounterDenormalised];
END
