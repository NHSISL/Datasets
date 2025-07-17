CREATE TABLE [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] (
	[SUS Version Number] VARCHAR(17) NULL
	,[NHS Unique Record Identifier] VARCHAR(255) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Sequence Number] BIGINT NULL
	,[Repeating Group] VARCHAR(100) NULL
	,[Code] VARCHAR(255) NULL
	,[Is Approved] BIT NULL
	,[Date] DATE NULL
	,[Time] TIME(0) NULL
	,[Coded Clinical Entry Sequence Number] INT NULL
	,[Qualifier] VARCHAR(18) NULL
	,[Qualifier Is Approved] BIT NULL
	,[Assignment Period Start Date] DATE NULL
	,[Assignment Period Start Time] TIME(0) NULL
	,[Expiry Date] DATE NULL
	,[Expiry Time] TIME(0) NULL
	,[Issuer Code] VARCHAR(2) NULL
	,[Tier] VARCHAR(2) NULL
	,[Discharge Responsibility Indicator] VARCHAR(1) NULL
	,[Activity Service Request Date] DATE NULL
	,[Activity Service Request Time] TIME(0) NULL
	,[Assessment Date] DATE NULL
	,[Assessment Time] TIME(0) NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[Emergency Care Slot Allocation Timestamp] DATETIME NULL
	,[Clinical Responsibility Timestamp] DATETIME NULL
	,[Person Score] VARCHAR(5) NULL
	,[Assessment Tool Validation Timestamp] DATETIME NULL
	,[Observation Value] VARCHAR(10) NULL
	,[UCUM Unit Of Measurement] VARCHAR(10) NULL
	,[Coded Observation Timestamp] DATETIME NULL
	,[Coded Finding Timestamp] DATETIME NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
