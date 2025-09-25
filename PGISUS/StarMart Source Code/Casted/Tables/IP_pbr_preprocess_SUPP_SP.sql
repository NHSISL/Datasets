CREATE TABLE [Casted].[IP_pbr_preprocess_SUPP_SP] (
	[SUS Version Number] VARCHAR(17) NULL
	,[Spell ID] BIGINT NULL
	,[Excluded Episode Spell ID] BIGINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Generated Record ID] BIGINT NULL
	,[Local Patient Identifier] VARCHAR(20) NULL
	,[NHS Number] CHAR(10) NULL
	,[Organisation Code (Local Patient Identifier)] VARCHAR(5) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Unbundled HRG Or SSC] VARCHAR(255) NULL
	,[Code Type Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling Submission Number] BIGINT NULL
	,[Unbundled Unit Tariff National] BIGINT NULL
	,[Unbundled Unit Tariff Non Mandatory] BIGINT NULL
	,[Unbundled Unit Tariff Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment National] DECIMAL(9, 2) NULL
	,[Aggregate UnBundled Adjustment Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment Non Mandatory] BIGINT NULL
	,[Unbundled Exclusion Reason] VARCHAR(255) NULL
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
