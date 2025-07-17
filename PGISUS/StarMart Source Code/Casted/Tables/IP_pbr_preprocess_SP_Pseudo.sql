CREATE TABLE [Casted].[IP_pbr_preprocess_SP_Pseudo] (
	[Spell Identifier] BIGINT NULL
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
	,[Local Patient Identifier] VARCHAR(10) NULL
	,[RTT Patient Pathway Identifier] VARCHAR(20) NULL
	,[Unique Booking Reference Number (Converted)] BIGINT NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Commissioning Serial No (Agreement No)] VARCHAR(6) NULL
	,[NHS Service Agreement Line No] VARCHAR(10) NULL
	,[Provider Reference No] VARCHAR(17) NULL
	,[Commissioner Reference No] VARCHAR(17) NULL
	,[Ambulance Incident Number] VARCHAR(20) NULL
	--
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			HEAP
			,DISTRIBUTION = ROUND_ROBIN
			);
