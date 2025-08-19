CREATE PROCEDURE [Denormalised].[pMaterialise_Casted_OP_Encounter]
AS
BEGIN
	IF OBJECT_ID('[Denormalised].[Materialised_Casted_OP_Attribution]') IS NOT NULL
		DROP TABLE [Denormalised].[Materialised_Casted_OP_Attribution];

	CREATE TABLE [Denormalised].[Materialised_Casted_OP_Attribution]
		WITH (DISTRIBUTION = HASH ([OrganisationCode])) AS

	SELECT *
	FROM [Casted].[OP_Attribution]
	WHERE 1 = 2;

	DECLARE @index_name NVARCHAR(300);

	SELECT @index_name = [name]
	FROM sys.indexes
	WHERE object_id = object_id('[Denormalised].[Materialised_Casted_OP_Attribution]');

	EXEC ('DROP INDEX ' + @index_name + ' ON [Denormalised].[Materialised_Casted_OP_Attribution]');

	CREATE CLUSTERED COLUMNSTORE INDEX [IX_Denormaliased_Materialised_Casted_OP_Attribution] ON [Denormalised].[Materialised_Casted_OP_Attribution]
	ORDER (
			[ActivityPeriod]
			,[Generated Record ID]
			);

	INSERT INTO [Denormalised].[Materialised_Casted_OP_Attribution]
	SELECT *
	FROM [Casted].[OP_Attribution];
END
