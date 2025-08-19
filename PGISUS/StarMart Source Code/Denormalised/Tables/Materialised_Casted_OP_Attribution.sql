CREATE TABLE [Denormalised].[Materialised_Casted_OP_Attribution] (
	[Generated Record ID] BIGINT NULL
	,[OrganisationCode] VARCHAR(50) NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			HEAP
			,DISTRIBUTION = HASH ([OrganisationCode])
			);
GO

CREATE CLUSTERED COLUMNSTORE INDEX [IX_Denormaliased_Materialised_Casted_OP_Attribution] ON [Denormalised].[Materialised_Casted_OP_Attribution]
ORDER (
		[ActivityPeriod]
		,[Generated Record ID]
		);
