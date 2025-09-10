CREATE TABLE [Casted].[IP_pbr_preprocess_MB_Pseudo] (
	[Generated Record ID] BIGINT NULL
	,[SK_PatientID] INT NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NOT NULL
	--
	,[dv_Age At CDS Activity Date] TINYINT NULL
	,[dv_Birth Date (Rounded)] DATE NULL
	--
	,[Birth Order Baby 'n'] TINYINT NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Local Patient Identifier Baby 'n'] VARCHAR(10) NULL
	--
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			HEAP
			,DISTRIBUTION = ROUND_ROBIN
			);
