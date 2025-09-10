CREATE TABLE [Casted].[AE_pbr_preprocess_CDS621_EC] (
	[SUS Version Number] VARCHAR(17) NULL
	,[NHS Unique Record Identifier] VARCHAR(255) NULL
	,[Generated Record ID] BIGINT NULL
	,[Spell ID] BIGINT NULL
	,[Emergency Care Attendance Category] VARCHAR(1) NULL
	,[Emergency Care Attendance Source (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Attendance Source (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Arrival Mode (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Arrival Mode (Snomed CT) Is Approved] BIT NULL
	,[Accommodation Status (Snomed CT)] VARCHAR(18) NULL
	,[Accommodation Status (Snomed CT) Is Approved] BIT NULL
	,[Preferred Spoken Language (Snomed CT)] VARCHAR(18) NULL
	,[Preferred Spoken Language (Snomed CT) Is Approved] BIT NULL
	,[Accessible Information Professional Required Code (Snomed CT)] VARCHAR(18) NULL
	,[Accessible Information Professional Required Code (Snomed CT) Is Approved] BIT NULL
	,[Interpreter Language (Snomed CT)] VARCHAR(18) NULL
	,[Interpreter Language (Snomed CT) Is Approved] BIT NULL
	,[Overseas Visitor Charging Category At CDS Activity Date] VARCHAR(1) NULL
	,[Emergency Care Attendance Source For Organistion Site Identifier] VARCHAR(9) NULL
	,[Emergency Care Acuity (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Acuity (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Chief Complaint (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Chief Complaint (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Chief Complaint (Extended)] VARCHAR(18) NULL
	,[Emergency Care Place Of Injury - Latitude] VARCHAR(10) NULL
	,[Emergency Care Place Of Injury - Longitude] VARCHAR(10) NULL
	,[Emergency Care Place Of Injury (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Place Of Injury (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Injury Activity Status (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Injury Activity Status (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Injury Intend (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Injury Intend (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Injury Mechanism (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Injury Mechanism (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Injury Activity Type (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Injury Activity Type (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Injury Date] DATE NULL
	,[Emergency Care Injury Time] TIME(0) NULL
	,[Decided To Admit Date] DATE NULL
	,[Decided To Admit Time] TIME(0) NULL
	,[Activity Treatment Function Code (Decision To Admit)] VARCHAR(3) NULL
	,[Emergency Care Discharge Status (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Discharge Status (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Discharge Destination (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Discharge Destination (Snomed CT) Is Approved] BIT NULL
	,[Organisation Site Identifier (Discharge From Emergency Care)] VARCHAR(9) NULL
	,[Emergency Care Discharge Follow Up (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Discharge Follow Up (Snomed CT) Is Approved] BIT NULL
	,[Emergency Care Discharge Information Given (Snomed CT)] VARCHAR(18) NULL
	,[Emergency Care Discharge Information Given (Snomed CT) Is Approved] BIT NULL
	,[Chief Complaint CQUIN Expected] BIT NULL
	,[Chief Complaint CQUIN Completed] BIT NULL
	,[Chief Complaint CQUIN Valid] BIT NULL
	,[Primary Diagnosis CQUIN Expected] BIT NULL
	,[Primary Diagnosis CQUIN Completed] BIT NULL
	,[Primary Diagnosis CQUIN Valid] BIT NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[Ethnic Category 2021] VARCHAR(3) NULL
	,[Care Contact Identifier (Ambulance Service)] VARCHAR(20) NULL
	,[Emergency Care Clinically Ready To Proceed Timestamp] DATETIME NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
