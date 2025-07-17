CREATE TABLE [Casted].[OP_Billing_Unbundled] (
	[Generated Record ID] BIGINT NOT NULL
	,[dmicPSSGrouperVersion] VARCHAR(20) NULL
	,[dmicGrouperVersion] VARCHAR(25) NULL
	,[dmicRuleFinancialYear] VARCHAR(7) NOT NULL
	,[dmicFinancialYear] VARCHAR(7) NOT NULL
	,[Costs Rebundled] BIT NOT NULL
	,[Days] INT NULL
	,[National Tariff] DECIMAL(19, 4) NULL
	,[Market Forces Factor] DECIMAL(19, 6) NULL
	,[Market Forces Factor Adjustment] DECIMAL(38, 9) NULL
	,[Local Tariff] DECIMAL(19, 4) NULL
	,[Default Tariff] DECIMAL(19, 4) NULL
	,[Unrounded DC Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded DC Total Tariff Including Mff] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Including MFF] DECIMAL(19, 4) NULL
	,[dmicLocalPODCode] VARCHAR(25) NULL
	,[dmicNationalPODCode] VARCHAR(10) NULL
	,[dmicGrouperHRG] VARCHAR(5) NULL
	,[dmicTariffHRG] VARCHAR(25) NULL
	,[dmicAppliedLocalRuleIDs] VARCHAR(255) NULL
	,[dmicLocalMarketForcesFactorAdjustment] DECIMAL(19, 4) NULL
	,[dmicLocalTreatmentFunctionCode] VARCHAR(25) NULL
	,[dmicTariffServiceLineCode] VARCHAR(20) NULL
	,[dmicPBCCategoryCode] VARCHAR(3) NULL
	,[dmicExcludedIndicator] BIT NULL
	,[dmicExclusionReasons] VARCHAR(255) NULL
	-- Add extra fields as per Bill Wood 17/1/24
	,[dmicIsDirectAccessIndicator] BIT NULL
	,[dmicIsNonMandatoryIndicator] BIT NULL
	,[dmicPostGrouperExcludedIndicator] BIT NULL
	,[dmicHrgExcludedIndicator] BIT NULL
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
