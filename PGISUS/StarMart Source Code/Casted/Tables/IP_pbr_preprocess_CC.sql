CREATE TABLE [Casted].[IP_pbr_preprocess_CC] (
	[SUS Version] VARCHAR(17) NULL
	,[Organisation Code (Code Of Provider)] VARCHAR(12) NULL
	,[Organisation Code (Code Of Commissioner)] VARCHAR(12) NULL
	,[Critical Care Type] VARCHAR(3) NULL
	,[Spell Identifier] BIGINT NULL
	,[Episode ID] BIGINT NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Episode Number] TINYINT NULL
	,[Start Date (Hospital Provider Spell)] DATE NULL
	,[End Date (Hospital Provider Spell)] DATE NULL
	,[Episode Start Date] DATE NULL
	,[Episode End Date] DATE NULL
	,[CC Patient Type] VARCHAR(3) NULL
	,[CC Days For LOS] SMALLINT NULL
	,[Total Episode Level CC Days For LOS] SMALLINT NULL
	,[CC Days For Tariff] SMALLINT NULL
	,[Total Episode Level CC Days For Tariff] SMALLINT NULL
	,[PBR CC Indicator] TINYINT NULL
	,[Excluded Reason] VARCHAR(255) NULL
	,[Critical Care Period Number] BIGINT NULL
	,[CC Unbundled HRG] VARCHAR(5) NULL
	,[CC Unit Cost] VARCHAR(255) NULL
	,[CC Total Cost] VARCHAR(255) NULL
	,[Critical Care Local Identifier] VARCHAR(8) NULL
	,[Critical Care Start Date] DATE NULL
	,[Critical Care Start Time] TIME(0) NULL
	,[Critical Care Discharge Date] DATE NULL
	,[Critical Care Discharge Time] TIME(0) NULL
	,[Activity Date (Critical Care)] DATE NULL
	,[Critical Care Unit Function] VARCHAR(2) NULL
	,[Critical Care Unit Bed Configuration] VARCHAR(2) NULL
	,[Critical Care Admission Source] VARCHAR(2) NULL
	,[Critical Care Source Location] VARCHAR(2) NULL
	,[Critical Care Admission Type] VARCHAR(2) NULL
	,[Gestation Length (At Delivery)] TINYINT NULL
	,[Advanced Respiratory Support Days] SMALLINT NULL
	,[Basic Respiratory Support Days] SMALLINT NULL
	,[Advanced Cardiovascular Support Days] SMALLINT NULL
	,[Basic Cardiovascular Support Days] SMALLINT NULL
	,[Renal Support Days] SMALLINT NULL
	,[Neurological Support Days] SMALLINT NULL
	,[Gastro-Intestinal Support Days] SMALLINT NULL
	,[Dermatological Support Days] SMALLINT NULL
	,[Liver Support Days] SMALLINT NULL
	,[Organ Support Maximum] TINYINT NULL
	,[Critical Care Level 2 Days] SMALLINT NULL
	,[Critical Care Level 3 Days] SMALLINT NULL
	,[Person Weight] VARCHAR(7) NULL
	,[Critical Care Activity Code 1] VARCHAR(2) NULL
	,[Critical Care Activity Code 2] VARCHAR(2) NULL
	,[Critical Care Activity Code 3] VARCHAR(2) NULL
	,[Critical Care Activity Code 4] VARCHAR(2) NULL
	,[Critical Care Activity Code 5] VARCHAR(2) NULL
	,[Critical Care Activity Code 6] VARCHAR(2) NULL
	,[Critical Care Activity Code 7] VARCHAR(2) NULL
	,[Critical Care Activity Code 8] VARCHAR(2) NULL
	,[Critical Care Activity Code 9] VARCHAR(2) NULL
	,[Critical Care Activity Code 10] VARCHAR(2) NULL
	,[Critical Care Activity Code 11] VARCHAR(2) NULL
	,[Critical Care Activity Code 12] VARCHAR(2) NULL
	,[Critical Care Activity Code 13] VARCHAR(2) NULL
	,[Critical Care Activity Code 14] VARCHAR(2) NULL
	,[Critical Care Activity Code 15] VARCHAR(2) NULL
	,[Critical Care Activity Code 16] VARCHAR(2) NULL
	,[Critical Care Activity Code 17] VARCHAR(2) NULL
	,[Critical Care Activity Code 18] VARCHAR(2) NULL
	,[Critical Care Activity Code 19] VARCHAR(2) NULL
	,[Critical Care Activity Code 20] VARCHAR(2) NULL
	,[High Cost Drugs (Opcs) 1] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 2] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 3] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 4] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 5] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 6] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 7] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 8] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 9] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 10] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 11] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 12] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 13] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 14] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 15] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 16] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 17] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 18] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 19] VARCHAR(4) NULL
	,[High Cost Drugs (Opcs) 20] VARCHAR(4) NULL
	,[Critical Care Discharge Ready Date] DATE NULL
	,[Critical Care Discharge Ready Time] TIME(0) NULL
	,[Critical Care Discharge Status] VARCHAR(2) NULL
	,[Critical Care Discharge Destination] VARCHAR(2) NULL
	,[Critical Care Discharge Location] VARCHAR(2) NULL
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
