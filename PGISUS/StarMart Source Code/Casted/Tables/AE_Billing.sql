CREATE TABLE [Casted].[AE_Billing] (
	[Generated Record ID] BIGINT NOT NULL
	,[dmicPSSGrouperVersion] VARCHAR(20) NULL
	,[dmicGrouperVersion] VARCHAR(25) NULL
	,[dmicRuleFinancialYear] VARCHAR(7) NOT NULL
	,[dmicFinancialYear] VARCHAR(7) NOT NULL
	,[National Tariff] DECIMAL(19, 4) NULL
	,[Market Forces Factor] DECIMAL(19, 6) NULL
	,[Market Forces Factor Adjustment] DECIMAL(38, 9) NULL
	,[Local Tariff] DECIMAL(19, 4) NULL
	,[Default Tariff] DECIMAL(19, 4) NULL
	,[Rounded Total Tariff] INT NULL
	,[Rounded Total Tariff Including MFF] INT NULL
	,[Unrounded Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Including MFF] DECIMAL(19, 4) NULL
	,[dmicPODCode] VARCHAR(25) NOT NULL
	,[dmicStandardPODCode] VARCHAR(25) NULL
	,[dmicLocalPODCode] VARCHAR(25) NOT NULL
	,[dmicLocalPODCodeAE] VARCHAR(25) NULL
	,[dmicNationalPODCode] VARCHAR(10) NULL
	,[dmicGrouperHRG] VARCHAR(5) NULL
	,[dmicTariffHRG] VARCHAR(50) NULL
	,[dmicNonStreamingHrgCode] VARCHAR(5) NULL
	,[dmicAppliedLocalRuleIDs] VARCHAR(255) NULL
	,[dmicLocalSpecialtyCode] VARCHAR(25) NOT NULL
	,[dmicLocalMarketForcesFactorAdjustment] DECIMAL(19, 4) NULL
	,[dmicLocalTreatmentFunctionCode] VARCHAR(25) NOT NULL
	,[dmicBusinessRuleCodes] VARCHAR(255) NULL
	,[dmicTariffServiceLineCode] VARCHAR(20) NULL
	,[dmicPBCCategoryCode] VARCHAR(3) NULL
	,[dmicGrouperErrorMessage] VARCHAR(1024) NULL
	,[dmicExcludedIndicator] BIT NOT NULL
	,[dmicExclusionReasons] VARCHAR(255) NULL
	-- Add extra fields as per Bill Wood 17/1/24
	,[dmicPreGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicPostGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicHrgExcludedIndicator] BIT NULL --NOT NULL
	,[dmicContractMonitoringExcludedIndicator] BIT NULL --NOT NULL
	,[dmicContractMonitoringExclusionReasons] VARCHAR(255) NULL
	,[dmicCostTypeId] TINYINT NULL
	,[dmicCostType] VARCHAR(17) NULL
	,[ZeroTariffFlag] VARCHAR(12) NULL
	,[ActivityDate] DATE NULL
	,[ActivityPeriod] INT NULL
	,[dmicValidFrom] DATETIME2(3) NOT NULL
	,[dmicValidTo] DATETIME2(3) NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
