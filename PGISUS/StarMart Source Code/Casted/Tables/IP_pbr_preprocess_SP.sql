CREATE TABLE [Casted].[IP_pbr_preprocess_SP] (
	[SUS Version] VARCHAR(17) NULL
	,[Spell Identifier] BIGINT NULL
	,[Parent Spell Identifier] BIGINT NULL
	,[Pseudonymised Status] BIGINT NULL
	,[Reason Access Provided] VARCHAR(30) NULL
	,[Local Patient Identifier] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier] VARCHAR(12) NULL
	,[NHS Number] CHAR(10) NULL
	,[Organisation Code Patient Pathway Identifier] VARCHAR(12) NULL
	,[RTT Patient Pathway Identifier] VARCHAR(20) NULL
	,[RTT Period End Date] DATE NULL
	,[RTT Period Start Date] DATE NULL
	,[RTT Status] VARCHAR(2) NULL
	,[Unique Booking Reference Number (Converted)] BIGINT NULL
	,[Birth Date] DATE NULL
	,[Age At CDS Activity Date] SMALLINT NULL
	,[Age At Start Of Spell] SMALLINT NULL
	,[Age At End Of Spell] SMALLINT NULL
	,[Spell Age] BIGINT NULL
	,[Patient Type] VARCHAR(3) NULL
	,[Carer Support Indicator] VARCHAR(2) NULL
	,[Legal Status Classification Code] VARCHAR(2) NULL
	,[Ethnic Category Code] VARCHAR(2) NULL
	,[Marital Status] VARCHAR(1) NULL
	,[NHS Number Status Indicator] VARCHAR(2) NULL
	,[Gender Code] VARCHAR(1) NULL
	,[Postcode Of Usual Address] VARCHAR(8) NULL
	,[Postcode Sector Of Usual Address] VARCHAR(8) NULL
	,[Organisation Code (PCT Of Residence)] VARCHAR(12) NULL
	,[Patient Postcode Derived PCT Type] VARCHAR(1) NULL
	,[Patient Postcode Derived PCT] VARCHAR(12) NULL
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Administrative Category (On Admission)] VARCHAR(2) NULL
	,[Administrative Category (Derived)] VARCHAR(20) NULL
	,[Patient Classification] VARCHAR(1) NULL
	,[Admission Method (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Admission Type (Derived)] VARCHAR(3) NULL
	,[Admission Subtype (Derived)] VARCHAR(3) NULL
	,[Discharge Destination (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Discharge Method (Hospital Provider Spell)] VARCHAR(1) NULL
	,[Source Of Admission (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Start Date (Hospital Provider Spell)] DATE NULL
	,[Ready For Discharge Date] DATE NULL
	,[End Date (Hospital Provider Spell)] DATE NULL
	,[Delay Discharge Reason] VARCHAR(4000) NULL
	,[Spell In PbR/Not In PbR] TINYINT NULL
	,[Spell Exclusion Reason] VARCHAR(100) NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Applicable Costing Period] VARCHAR(20) NULL
	,[Commissioner Serial No (Agreement No)] VARCHAR(6) NULL
	,[NHS Service Agreement Line No] VARCHAR(10) NULL
	,[Provider Reference No] VARCHAR(17) NULL
	,[Commissioner Reference No] VARCHAR(17) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Organisation Code (Code Of Provider)] VARCHAR(12) NULL
	,[Provider Code (Original Data)] VARCHAR(12) NULL
	,[Provider Site Code] VARCHAR(12) NULL
	,[Organisation Code (Code Of Commissioner)] VARCHAR(12) NULL
	,[Commissioner Code (Original Data)] VARCHAR(12) NULL
	,[Commissioner Site Code] VARCHAR(12) NULL
	,[Organisation Code Type Commissioner] VARCHAR(1) NULL
	,[PCT Derived From GP] VARCHAR(12) NULL
	,[PCT Derived From GP Practice] VARCHAR(12) NULL
	,[GP Practice Derived From PDS] TINYINT NULL
	,[Main Specialty Code] VARCHAR(3) NULL
	,[Treatment Function Code] VARCHAR(3) NULL
	,[Registered GMP Code] VARCHAR(8) NULL
	,[GP Code (Original Data)] VARCHAR(8) NULL
	,[GP Practice Code] VARCHAR(12) NULL
	,[GP Consortium Code] VARCHAR(12) NULL
	,[GP Practice Code (Original Data)] VARCHAR(12) NULL
	,[GP Practice Code (Derived)] VARCHAR(12) NULL
	,[Organisation Code Type GP Practice] VARCHAR(1) NULL
	,[Referrer Code] VARCHAR(8) NULL
	,[Referring Organisation Code] VARCHAR(12) NULL
	,[Duration Of Elective Wait] INT NULL
	,[Intended Management] VARCHAR(1) NULL
	,[Decided To Admit Date] DATE NULL
	,[Length Of Stay (Hospital Provider Spell)] BIGINT NULL
	,[PbR NCC PCC Adjusted Length Of Stay] BIGINT NULL
	,[PbR Final Adjusted Length Of Stay] BIGINT NULL
	,[Number Of Commissioners In PbR Spell] TINYINT NULL
	,[Number Diagnosis] INT NULL
	,[Number Hospital Provider Spell ID] TINYINT NULL
	,[Number Procedures] INT NULL
	,[Number Unbundled HRGs] INT NULL
	,[Number Unbundled Non Priced HRGs] INT NULL
	,[Number Unbundled Priced HRGs] INT NULL
	,[Excluded Episodes In Hospital Provider Spell] TINYINT NULL
	,[Number SSCs] TINYINT NULL
	,[Number BPT Indicators] BIGINT NULL
	,[PbR Spell Trimpoint Days] SMALLINT NULL
	,[PbR Days Beyond Trimpoint] SMALLINT NULL
	,[Spell ACC Length Of Stay] BIGINT NULL
	,[Spell NCC Length Of Stay] BIGINT NULL
	,[Spell PCC Length Of Stay] BIGINT NULL
	,[Spell Primary Diagnosis] VARCHAR(6) NULL
	,[Spell Secondary Diagnosis] VARCHAR(6) NULL
	,[Spell Dominant Procedure] VARCHAR(255) NULL
	,[Primary Procedure Code] VARCHAR(7) NULL
	,[Significant Specialised Service Code] VARCHAR(5) NULL
	,[Specialised Service Code 1] VARCHAR(255) NULL
	,[Specialised Service Code 2] VARCHAR(255) NULL
	,[Specialised Service Code 3] VARCHAR(255) NULL
	,[Specialised Service Code 4] VARCHAR(255) NULL
	,[Specialised Service Code 5] VARCHAR(255) NULL
	,[BPT Indicator 1] VARCHAR(6) NULL
	,[BPT Indicator 1 Action] VARCHAR(20) NULL
	,[BPT Indicator 2] VARCHAR(6) NULL
	,[BPT Indicator 2 Action] VARCHAR(20) NULL
	,[BPT Indicator 3] VARCHAR(6) NULL
	,[BPT Indicator 3 Action] VARCHAR(20) NULL
	,[BPT Indicator 4] VARCHAR(6) NULL
	,[BPT Indicator 4 Action] VARCHAR(20) NULL
	,[BPT Indicator 5] VARCHAR(6) NULL
	,[BPT Indicator 5 Action] VARCHAR(20) NULL
	,[Tariff Initial Amount National] DECIMAL(9, 2) NULL
	,[Tariff Day Case National] BIGINT NULL
	,[Tariff Short Stay Emergency National] VARCHAR(255) NULL
	,[Tariff Service Adjustment National] DECIMAL(9, 2) NULL
	,[Tariff Long Stay Rate National] DECIMAL(9, 2) NULL
	,[Tariff Long Stay Payment National] DECIMAL(9, 2) NULL
	,[Aggregate UnBundled Adjustment National] DECIMAL(9, 2) NULL
	,[Tariff Financial Adjustment National] BIGINT NULL
	,[Tariff Adjustment Future Use_1 National] BIGINT NULL
	,[Tariff Adjustment Future Use_2 National] BIGINT NULL
	,[Applied MFF Elective] BIGINT NULL
	,[Applied MFF Non Elective] BIGINT NULL
	,[MFF Adjustment] DECIMAL(9, 2) NULL
	,[Tariff Pre MFF Adjusted National] DECIMAL(9, 2) NULL
	,[Tariff Total Payment National] DECIMAL(9, 2) NULL
	,[Tariff Initial Amount Non Mandatory] BIGINT NULL
	,[Tariff Day Case Non Mandatory] BIGINT NULL
	,[Tariff Short Stay Emergency Non Mandatory] BIGINT NULL
	,[Tariff Spec Serv Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Long Stay Rate Non Mandatory] BIGINT NULL
	,[Tariff Long Stay Payment Non Mandatory] BIGINT NULL
	,[Aggregate UnBundled Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Financial Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_1 Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_2 Non Mandatory] BIGINT NULL
	,[Applied MFF Elective Non Mandatory] BIGINT NULL
	,[Applied MFF Non Elective Non Mandatory] BIGINT NULL
	,[Tariff Pre MFF Adjusted Non Mandatory] BIGINT NULL
	,[Tariff Total Payment Non Mandatory] BIGINT NULL
	,[Non Mandatory Core Tariff (With UB)] BIGINT NULL
	,[Optional APC BPT Adjustment] BIGINT NULL
	,[Tarrif Initial Amount Local] BIGINT NULL
	,[Tariff Day Case Local] BIGINT NULL
	,[Tariff Short Stay Emergency Local] BIGINT NULL
	,[Tariff Long Stay Rate Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment Local] BIGINT NULL
	,[Tariff Long Stay Payment Local] BIGINT NULL
	,[Tariff Total Payment Local] BIGINT NULL
	,[Local Core Tariff (With UB)] BIGINT NULL
	,[PbR Final Tariff] DECIMAL(9, 2) NULL
	,[Final Tariff Applied] VARCHAR(10) NULL
	,[PbR Costed Indicator] BIGINT NULL
	,[Grouping Method] VARCHAR(255) NULL
	,[Configurable Indicator] VARCHAR(4) NULL
	,[Code Cleaning] VARCHAR(1) NULL
	,[Spell Core HRG] VARCHAR(5) NULL
	,[Core HRG Version (Calculated)] VARCHAR(3) NULL
	,[HRG Submitted] VARCHAR(5) NULL
	,[HRG Version (Submitted)] VARCHAR(3) NULL
	,[Grouping Algorithm Version] VARCHAR(8) NULL
	,[Grouping Reference Data Version] VARCHAR(255) NULL
	,[Grouping HRG Version] VARCHAR(20) NULL
	,[Unbundled HRG 1] VARCHAR(5) NULL
	,[Unbundled HRG 2] VARCHAR(5) NULL
	,[Unbundled HRG 3] VARCHAR(5) NULL
	,[Unbundled HRG 4] VARCHAR(5) NULL
	,[Unbundled HRG 5] VARCHAR(5) NULL
	,[Unbundled HRG 6] VARCHAR(5) NULL
	,[Unbundled HRG 7] VARCHAR(5) NULL
	,[Unbundled HRG 8] VARCHAR(5) NULL
	,[Unbundled HRG 9] VARCHAR(5) NULL
	,[Unbundled HRG 10] VARCHAR(5) NULL
	,[Unbundled HRG 11] VARCHAR(5) NULL
	,[Unbundled HRG 12] VARCHAR(5) NULL
	,[Spell Programme Budgeting Category] VARCHAR(255) NULL
	,[Number Of Babies] VARCHAR(255) NULL
	,[PbR Spell Error Status] TINYINT NULL
	,[PbR Spell Frozen Indicator] BIGINT NULL
	,[PbR Spell Status Indicator] BIGINT NULL
	,[Match Criterion Indicator] BIGINT NULL
	,[RAP DH Tariff Adjustment Child] VARCHAR(1) NULL
	,[RAP Validation Child Indicator] VARCHAR(255) NULL
	,[RAP Spell Type] VARCHAR(6) NULL
	,[Applicable Date] DATE NULL
	,[Extract Date] DATE NULL
	,[Extract Type] VARCHAR(20) NULL
	,[Spare 1] VARCHAR(30) NULL
	,[Spare 2] VARCHAR(30) NULL
	,[Spare 3] VARCHAR(30) NULL
	,[Spare 4] VARCHAR(30) NULL
	,[Spare 5] VARCHAR(30) NULL
	,[Spell NPOC] VARCHAR(3) NULL
	,[Spell Service Line] VARCHAR(8) NULL
	,[Commissioning Region] VARCHAR(255) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Prime Recipient] VARCHAR(12) NULL
	,[Copy Recipients] VARCHAR(50) NULL
	,[Derived Commissioner] VARCHAR(12) NULL
	,[Derived Commissioner Type] VARCHAR(100) NULL
	,[Open Spell Indicator] VARCHAR(1) NULL
	,[Evidence Based Intervention Category] VARCHAR(1) NULL
	,[Evidence Based Intervention Type] VARCHAR(15) NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
