CREATE PROCEDURE [Denormalised].[pMaterialise_Casted_IP_Encounter]
AS
BEGIN
	IF OBJECT_ID('[Denormalised].[Materialised_Casted_IP_Attribution]') IS NOT NULL
		DROP TABLE [Denormalised].[Materialised_Casted_IP_Attribution];

	CREATE TABLE [Denormalised].[Materialised_Casted_IP_Attribution]
		WITH (DISTRIBUTION = HASH ([OrganisationCode])) AS

	SELECT *
	FROM [Casted].[IP_Attribution]
	WHERE 1 = 2;

	DECLARE @index_name NVARCHAR(300);

	SELECT @index_name = [name]
	FROM sys.indexes
	WHERE object_id = object_id('[Denormalised].[Materialised_Casted_IP_Attribution]');

	EXEC ('DROP INDEX ' + @index_name + ' ON [Denormalised].[Materialised_Casted_IP_Attribution]');

	CREATE CLUSTERED COLUMNSTORE INDEX [IX_Denormaliased_Materialised_Casted_IP_Attribution] ON [Denormalised].[Materialised_Casted_IP_Attribution]
	ORDER (
			[ActivityPeriod]
			,[Generated Record ID]
			);

	INSERT INTO [Denormalised].[Materialised_Casted_IP_Attribution]
	SELECT *
	FROM [Casted].[IP_Attribution];
END
