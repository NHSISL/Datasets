CREATE TABLE [Casted].[IP_pbr_preprocess_WS] (
	[SUS Version Number] VARCHAR(17) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Parent Spell Identifier] BIGINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Organisation Code (Code Of Provider)] VARCHAR(12) NULL
	,[Organisation Code (Code Of Commissioner)] VARCHAR(12) NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Episode Number] TINYINT NULL
	,[Start Date (Hospital Provider Spell)] DATE NULL
	,[End Date (Hospital Provider Spell)] DATE NULL
	,[Episode Start Date] DATE NULL
	,[Episode End Date] DATE NULL
	,[Ward Stay Sequence Number] BIGINT NULL
	,[Ward Code] VARCHAR(12) NULL
	,[Activity Location Type Code] VARCHAR(3) NULL
	,[Ward Security Level] VARCHAR(1) NULL
	,[Location Class Ward Stay 'n'] VARCHAR(2) NULL
	,[Org Code Location Ward Stay 'n'] VARCHAR(12) NULL
	,[Intended Care Intensity Ward Stay 'n'] VARCHAR(2) NULL
	,[Age Group Intended Ward Stay 'n'] VARCHAR(1) NULL
	,[Sex Of Patients Ward Stay 'n'] VARCHAR(1) NULL
	,[Day Period Availability Ward Stay 'n'] VARCHAR(1) NULL
	,[Night Period Availability Ward Stay 'n'] VARCHAR(1) NULL
	,[Stay Start Date Ward Stay 'n'] DATE NULL
	,[Stay Start Time Ward Stay 'n'] TIME(0) NULL
	,[Stay End Date Ward Stay 'n'] DATE NULL
	,[Stay End Time Ward Stay 'n'] TIME(0) NULL
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
