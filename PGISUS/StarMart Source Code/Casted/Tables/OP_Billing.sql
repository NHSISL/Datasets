CREATE TABLE [Casted].[OP_Billing] (
	[Generated Record ID] BIGINT NOT NULL
	,[dmicPSSGrouperVersion] VARCHAR(20) NULL
	,[dmicGrouperVersion] VARCHAR(25) NULL
	,[dmicRuleFinancialYear] VARCHAR(7) NOT NULL
	,[dmicFinancialYear] VARCHAR(7) NOT NULL
	,[National Tariff] DECIMAL(19, 4) NULL
	,[Best Practice Tariff] DECIMAL(19, 4) NULL
	,[Best Practice Additional] DECIMAL(19, 4) NULL
	,[Market Forces Factor] DECIMAL(19, 6) NULL
	,[Market Forces Factor Adjustment] DECIMAL(19, 4) NULL
	,[Local Tariff] DECIMAL(19, 4) NULL
	,[Default Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Unbundled Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Unbundled Tariff Including MFF] DECIMAL(19, 4) NULL
	,[Rounded Total Tariff] INT NULL
	,[Rounded Total Tariff Including MFF] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Including MFF] DECIMAL(19, 4) NULL
	,[Unrounded DC Unbundled Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded DC Unbundled Total Tariff Including Mff] DECIMAL(19, 4) NULL
	,[Unrounded CCG Unbundled Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded CCG Unbundled Total Tariff Including Mff] DECIMAL(19, 4) NULL
	,[Unrounded DC Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded DC Total Tariff Including Mff] DECIMAL(19, 4) NULL
	,[Unrounded CCG Total Tariff] DECIMAL(19, 4) NULL
	,[Unrounded CCG Total Tariff Including Mff] DECIMAL(19, 4) NULL
	,[dmicPODCode] VARCHAR(25) NOT NULL
	,[dmicStandardPODCode] VARCHAR(25) NULL
	,[dmicLocalPODCode] VARCHAR(25) NOT NULL
	,[dmicOPIPPODCode] VARCHAR(25) NULL
	,[dmicNationalPODCode] VARCHAR(10) NULL
	,[dmicGrouperHRG] VARCHAR(5) NULL
	,[dmicTariffHRG] VARCHAR(50) NULL
	,[dmicAppliedLocalRuleIDs] VARCHAR(255) NULL
	,[dmicLocalSpecialtyCode] VARCHAR(25) NULL
	,[dmicLocalMarketForcesFactorAdjustment] DECIMAL(19, 4) NULL
	,[dmicLocalTreatmentFunctionCode] VARCHAR(25) NULL
	,[dmicBusinessRuleCodes] VARCHAR(255) NULL
	,[dmicTariffServiceLineCode] VARCHAR(20) NULL
	,[dmicPBCCategoryCode] VARCHAR(20) NULL
	,[dmicGrouperErrorMessage] VARCHAR(1024) NULL
	,[GroupingMethodFlag] VARCHAR(1) NULL
	,[DominantProcedure] VARCHAR(60) NULL
	,[dmicExcludedIndicator] BIT NOT NULL
	,[dmicExclusionReasons] VARCHAR(255) NULL
	-- Add extra fields as per Bill Wood 17/1/24
	,[dmicPreGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicPostGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicHRGExcludedIndicator] BIT NULL --NOT NULL
	,[dmicIsConsultantLedIndicator] BIT NULL
	,[dmicIsProcedureHrgIndicator] BIT NULL
	,[dmicIsNonMandatoryTariffIndicator] BIT NULL --NOT NULL
	,[dmicIsDirectAccessIndicator] BIT NULL
	,[dmicCostTypeId] TINYINT NULL
	,[dmicIgnoreLocalFlexibilityExcludedIndicator] BIT NULL
	--ADD PGISUS derived PSS Code
	,[dmicSpecialisedServiceLineCode] VARCHAR(25) NULL
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
