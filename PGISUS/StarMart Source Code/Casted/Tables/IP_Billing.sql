CREATE TABLE [Casted].[IP_Billing] (
	[Generated Record ID] BIGINT NOT NULL
	,[dmicPSSGrouperVersion] VARCHAR(20) NOT NULL
	,[dmicGrouperVersion] VARCHAR(25) NOT NULL
	,[dmicRuleFinancialYear] VARCHAR(7) NOT NULL
	,[dmicFinancialYear] VARCHAR(7) NOT NULL
	,[Critical Care Days] SMALLINT NULL
	,[National Tariff] DECIMAL(19, 4) NULL
	,[Best Practice Tariff] DECIMAL(19, 4) NULL
	,[Excess Bed Days Adjustment] DECIMAL(19, 4) NULL
	,[SSC Topup Percentage] FLOAT(53) NULL
	,[SSC Tariff Adjustment] DECIMAL(19, 4) NULL
	,[Market Forces Factor] DECIMAL(19, 6) NULL
	,[Market Forces Factor Adjustment] DECIMAL(19, 4) NULL
	,[Local Tariff] DECIMAL(19, 4) NULL
	,[Default Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Unbundled Tariff] DECIMAL(19, 4) NULL
	,[Unrounded Total Unbundled Tariff Including MFF] DECIMAL(19, 4) NULL
	,[Total Additional Episode Local Tariff] DECIMAL(19, 4) NULL
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
	,[Unrounded Total Excess Bed Days Adjustment Including MFF] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Excluding XBD] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Excluding XBD Including MFF] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Excluding Unbundled] DECIMAL(19, 4) NULL
	,[Unrounded Total Tariff Excluding Unbundled Including MFF] DECIMAL(19, 4) NULL
	,[Best Practice Additional] DECIMAL(19, 4) NULL
	,[Base National Tariff] DECIMAL(19, 4) NULL
	,[Base Best Practice Tariff] DECIMAL(19, 4) NULL
	,[ShortStayPercentageReduction] TINYINT NULL
	,[SpellPBC] VARCHAR(25) NULL
	,[RehabilitationDays] SMALLINT NULL
	,[SpecialCareDays] SMALLINT NULL
	,[UnroundedTotalXBDAdjustment] DECIMAL(19, 4) NULL
	,[dmicPODCode] VARCHAR(25) NOT NULL
	,[dmicLocalPODCode] VARCHAR(25) NOT NULL
	,[dmicStandardPODCode] VARCHAR(25) NULL
	,[dmicNationalPODCode] VARCHAR(10) NULL
	,[dmicGrouperHRG] VARCHAR(5) NULL
	,[dmicTariffHRG] VARCHAR(50) NULL
	,[dmicAppliedLocalRuleIDs] VARCHAR(255) NULL
	,[dmicLocalSpecialtyCode] VARCHAR(25) NULL
	,[dmicLocalTreatmentFunctionCode] VARCHAR(25) NULL
	,[dmicLocalMarketForcesFactorAdjustment] DECIMAL(19, 4) NULL
	,[dmicLocalExcessBedDaysAdjustment] DECIMAL(19, 4) NULL
	,[dmicBusinessRuleCodes] VARCHAR(255) NULL
	,[dmicTariffServiceLineCode] VARCHAR(20) NULL
	,[dmicPBCCategoryCode] VARCHAR(25) NULL
	,[dmicGrouperErrorMessage] VARCHAR(1024) NULL
	,[PrimaryICDDiagnosisCode] VARCHAR(6) NULL
	,[SpellPrimaryDiagnosis] VARCHAR(7) NULL
	,[SpellSecondaryDiagnosis] VARCHAR(7) NULL
	,[SpellDominantProcedure] VARCHAR(60) NULL
	,[SpellGroupingMethodFlag] VARCHAR(1) NULL
	,[dmicSSCCode] VARCHAR(5) NULL
	,[dmicBestPracticeCode] VARCHAR(5) NULL
	,[dmicSpellLengthOfStay] SMALLINT NULL
	,[dmicTrimpoint] SMALLINT NULL
	,[dmicExcessBedDays] INT NULL
	,[dmicExcludedIndicator] BIT NOT NULL
	,[dmicExclusionReasons] VARCHAR(255) NULL
	,[dmicAcuteLengthOfStay] SMALLINT NULL
	,[dmicCommunityLengthOfStay] SMALLINT NULL
	,[dmicApplicableSSCCodes] VARCHAR(50) NULL
	,[dmicApplicableBPTCodes] VARCHAR(50) NULL
	,[dmicAdultCriticalCareDays] SMALLINT NULL
	,[dmicPaediatricCriticalCareDays] SMALLINT NULL
	,[dmicNeonatalCriticalCareDays] SMALLINT NULL
	,[dmicPbRTrimpoint] SMALLINT NULL
	,[dmicPbRExcessBedDays] SMALLINT NULL
	,[dmicExcessBedDayPerDayTariff] DECIMAL(19, 4) NULL
	,[dmicUnadjustedPbRExcessBedDays] SMALLINT NULL
	,[dmicPbRExcessBedDayPerDayTariff] DECIMAL(19, 4) NULL
	,[dmicValidatedCriticalCareDays] SMALLINT NULL
	,[dmicValidatedAdultCriticalCareDays] SMALLINT NULL
	,[dmicValidatedPaediatricCriticalCareDays] SMALLINT NULL
	,[dmicValidatedNeonatalCriticalCareDays] SMALLINT NULL
	,[dmicDelayedDischargeAdjustment] DECIMAL(19, 4) NULL
	,[dmicRehabCriticalCareOverlap] INT NULL
	,[dmicRehabValidatedCriticalCareOverlap] INT NULL
	-- Add extra fields as per Bill Wood 17/1/24
	,[dmicPreGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicPostGrouperExcludedIndicator] BIT NULL --NOT NULL
	,[dmicHRGExcludedIndicator] BIT NULL --NOT NULL
	,[dmicIsNonMandatoryTariffIndicator] BIT NULL --NOT NULL
	,[dmicAllInCommunityHospitalIndicator] BIT NULL
	,[dmicAllInCriticalCareIndicator] BIT NULL
	,[dmicAllInPaediatricCriticalCareIndicator] BIT NULL
	,[dmicPotentialOPPROCIndicator] BIT NULL
	,[dmicAllInRehabIndicator] BIT NULL
	,[dmicCostTypeId] TINYINT NULL
	,[dmicIgnoreLocalFlexibilityExcludedIndicator] BIT NULL
	-- Add PGISUS derived PSS Codes
	,[dmicSpecialisedServiceLineCode] VARCHAR(25) NULL
	,[dmicSpellSpecialisedServiceLine] VARCHAR(25) NULL
	,[dmicAdmissionWardCode] VARCHAR(12) NULL
	,[dmicDischargeWardCode] VARCHAR(12) NULL
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
