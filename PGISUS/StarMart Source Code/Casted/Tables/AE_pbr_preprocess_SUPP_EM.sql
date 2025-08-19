CREATE TABLE [Casted].[AE_pbr_preprocess_SUPP_EM] (
	[SUS Version Number] VARCHAR(17) NULL
	,[NHS Unique Record Identifier] VARCHAR(255) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Secondary Diagnosis Code] VARCHAR(255) NULL
	,[Sequence Number Diagnosis] TINYINT NULL
	,[Present On Admission Indicator] VARCHAR(1) NULL
	,[EM Investigation Second] VARCHAR(7) NULL
	,[Sequence Number Investigation] TINYINT NULL
	,[EM Treatment Second] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments)] DATE NULL
	,[Sequence Number Treatment] TINYINT NULL
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
