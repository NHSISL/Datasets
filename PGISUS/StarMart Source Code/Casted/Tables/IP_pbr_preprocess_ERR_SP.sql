CREATE TABLE [Casted].[IP_pbr_preprocess_ERR_SP] (
	[SUS Version Number] VARCHAR(17) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Excluded Episode Spell ID] BIGINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Local Patient Identifier] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier] VARCHAR(12) NULL
	,[NHS Number] CHAR(10) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Spell In PbR/Not In PbR] TINYINT NULL
	,[Spell Error Status] BIGINT NULL
	,[Spell Core HRG] VARCHAR(5) NULL
	,[Attribute Name] VARCHAR(40) NULL
	,[Error Code] BIGINT NULL
	,[Error Description] VARCHAR(255) NULL
	,[Error Type] VARCHAR(50) NULL
	,[Error Grain] VARCHAR(20) NULL
	,[Position] BIGINT NULL
	,[Submitted Attribute Value] VARCHAR(20) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
