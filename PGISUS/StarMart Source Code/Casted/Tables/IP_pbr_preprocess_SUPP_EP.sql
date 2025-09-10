CREATE TABLE [Casted].[IP_pbr_preprocess_SUPP_EP] (
	[SUS Version Number] VARCHAR(17) NULL
	,[Generated Record ID] BIGINT NULL
	,[Episode Number] TINYINT NULL
	,[Spell ID] BIGINT NULL
	,[Excluded Episode Spell ID] BIGINT NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Unbundled HRG] VARCHAR(5) NULL
	,[Code Type Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling Submission Number] BIGINT NULL
	,[Secondary Diagnosis Code] VARCHAR(255) NULL
	,[Sequence Number Diagnosis] TINYINT NULL
	,[Present On Admission Indicator] VARCHAR(1) NULL
	,[Secondary Procedure Code] VARCHAR(4) NULL
	,[Secondary Procedure Date] DATE NULL
	,[Sequence Number Procedure] TINYINT NULL
	,[Professional Registration Entry Identifier (Main Operating Care Professional)] VARCHAR(12) NULL
	,[Professional Registration Issuer Code (Operator)] VARCHAR(2) NULL
	,[Professional Registration Entry Identifier (Responsible Anaesthetist)] VARCHAR(12) NULL
	,[Professional Registration Issuer Code (Anaesthetist)] VARCHAR(2) NULL
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
