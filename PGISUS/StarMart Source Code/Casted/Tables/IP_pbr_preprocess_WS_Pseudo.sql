CREATE TABLE [Casted].[IP_pbr_preprocess_WS_Pseudo] (
	[Generated Record ID] BIGINT NULL
	,[SK_PatientID] INT NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NOT NULL
	--
	,[dv_Age At CDS Activity Date] TINYINT NULL
	,[dv_Birth Date (Rounded)] DATE NULL
	,[dv_Pseudo_Postcode] VARCHAR(8) NULL
	,[dv_LSOA] VARCHAR(9) NULL
	,[dv_OA] VARCHAR(9) NULL
	--
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	--
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			HEAP
			,DISTRIBUTION = ROUND_ROBIN
			);
