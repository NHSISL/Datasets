CREATE TABLE [Casted].[IP_pbr_preprocess_MB] (
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
	,[Number Of Babies] VARCHAR(1) NULL
	,[Gestation Length Baby 'n'] TINYINT NULL
	,[Delivery Date Baby 'n'] DATE NULL
	,[Birth Order Baby 'n'] TINYINT NULL
	,[Delivery Method Baby 'n'] VARCHAR(1) NULL
	,[Gestation Length Assessment Baby 'n'] TINYINT NULL
	,[Resuscitation Method Baby 'n'] VARCHAR(1) NULL
	,[Status Of Person Conducting Delivery Baby 'n'] VARCHAR(1) NULL
	,[Local Patient Identifier Baby 'n'] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier Baby 'n'] VARCHAR(12) NULL
	,[NHS Number Baby 'n'] CHAR(10) NULL
	,[NHS Number Status Ind Baby 'n'] VARCHAR(2) NULL
	,[Withheld Identity Reason Baby 'n'] TINYINT NULL
	,[Date Of Birth Baby 'n'] DATE NULL
	,[Sex Baby 'n'] VARCHAR(1) NULL
	,[Live Or Still Birth Baby 'n'] VARCHAR(1) NULL
	,[Birth Weight Baby 'n'] SMALLINT NULL
	,[Location Class Of Delivery Place (Actual) Baby 'n'] VARCHAR(2) NULL
	,[Location Type Of Delivery Place (Actual) Baby 'n'] VARCHAR(3) NULL
	,[Delivery Place Type Actual Baby 'n'] VARCHAR(1) NULL
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
