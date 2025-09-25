CREATE TABLE [Casted].[OP_pbr_preprocess_SUPP_OP] (
	[SUS Version Number] VARCHAR(17) NULL
	,[NHS Unique Record Identifier] VARCHAR(255) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Unbundled HRG] VARCHAR(5) NULL
	,[Code Type Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling] VARCHAR(255) NULL
	,[Code Driving Unbundling Submission Number] BIGINT NULL
	,[Unbundled Unit Tariff National] BIGINT NULL
	,[Unbundled Unit Tariff Non Mandatory] BIGINT NULL
	,[Unbundled Unit Tariff Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment National] DECIMAL(9, 2) NULL
	,[Aggregate UnBundled Adjustment Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment Non Mandatory] BIGINT NULL
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
