CREATE TABLE [Casted].[OP_pbr_preprocess_OP] (
	[SUS Version] VARCHAR(17) NULL
	,[NHS RID (From Provider)] VARCHAR(35) NULL
	,[Spell Identifier] BIGINT NULL
	,[Generated Record ID] BIGINT NULL
	,[CDS Record Type] VARCHAR(3) NULL
	,[Reason Access Provided] VARCHAR(30) NULL
	,[CDS Group Derived] BIGINT NULL
	,[CDS Group Indicator] TINYINT NULL
	,[Bulk Replacement CDS Group] VARCHAR(3) NULL
	,[Spell In PbR/Not In PbR] TINYINT NULL
	,[Exclusion Reason] VARCHAR(100) NULL
	,[Pseudonymised Status] BIGINT NULL
	,[Confidentiality Category] TINYINT NULL
	,[Configurable Indicator] VARCHAR(4) NULL
	,[Code Cleaning] VARCHAR(1) NULL
	,[Local Patient Identifier] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier] VARCHAR(12) NULL
	,[NHS Number] CHAR(10) NULL
	,[Patient Name] VARCHAR(70) NULL
	,[Patient Usual Address] VARCHAR(175) NULL
	,[Lead Care Activity Indicator] TINYINT NULL
	,[Organisation Code Patient Pathway Identifier] VARCHAR(12) NULL
	,[RTT Patient Pathway Identifier] VARCHAR(20) NULL
	,[RTT Period End Date] DATE NULL
	,[RTT Period Start Date] DATE NULL
	,[RTT Status] VARCHAR(2) NULL
	,[Unique Booking Reference Number (Converted)] BIGINT NULL
	,[RTT Length (Derived)] SMALLINT NULL
	,[Birth Date] DATE NULL
	,[Age] SMALLINT NULL
	,[Derived Age] BIGINT NULL
	,[Patient Type] VARCHAR(3) NULL
	,[Year Of Birth] SMALLINT NULL
	,[Month Of Birth] TINYINT NULL
	,[Age At Record End] BIGINT NULL
	,[Age At Record Start] BIGINT NULL
	,[Age Range Derived] SMALLINT NULL
	,[Carer Support Indicator] VARCHAR(2) NULL
	,[Ethnic Category Code] VARCHAR(2) NULL
	,[Marital Status] VARCHAR(1) NULL
	,[NHS Number Status Indicator] VARCHAR(2) NULL
	,[Gender Code] VARCHAR(1) NULL
	,[Postcode Of Usual Address] VARCHAR(8) NULL
	,[Postcode Sector Of Usual Address] VARCHAR(8) NULL
	,[Organisation Code (PCT Of Residence)] VARCHAR(12) NULL
	,[Patient Postcode Derived PCT Type] VARCHAR(1) NULL
	,[Patient Postcode Derived PCT] VARCHAR(12) NULL
	,[Patient Postcode Electoral Ward] VARCHAR(255) NULL
	,[Area Code Derived] VARCHAR(4) NULL
	,[Organisation Code Type PCT Of Residence] VARCHAR(1) NULL
	,[SHA From Patient Postcode] VARCHAR(12) NULL
	,[SHA Type From Patient Postcode] VARCHAR(255) NULL
	,[Census Output Area 2001] VARCHAR(255) NULL
	,[Country] VARCHAR(9) NULL
	,[County Code] VARCHAR(255) NULL
	,[ED County Code] VARCHAR(17) NULL
	,[ED District Code] VARCHAR(15) NULL
	,[Electoral Ward Division] VARCHAR(255) NULL
	,[Government Office Region Code] VARCHAR(255) NULL
	,[Local Authority Code] VARCHAR(255) NULL
	,[SHA Old Org Code] VARCHAR(255) NULL
	,[Electoral Ward 1998] VARCHAR(6) NULL
	,[Attendance Identifier] VARCHAR(12) NULL
	,[Administrative Category] VARCHAR(2) NULL
	,[Attended Or Did Not Attend] VARCHAR(1) NULL
	,[First Attendance] VARCHAR(1) NULL
	,[Outcome Of Attendance] VARCHAR(1) NULL
	,[Medical Staff Type Seeing Patient] VARCHAR(2) NULL
	,[Source Of Referral For Outpatients] VARCHAR(2) NULL
	,[Appointment Date] DATE NULL
	,[Operation Status] VARCHAR(1) NULL
	,[OP Episode Type] VARCHAR(255) NULL
	,[CDS Activity Date] DATE NULL
	,[Attendance Date] DATE NULL
	,[Attender Type Derived] VARCHAR(2) NULL
	,[Commissioning Serial No (Agreement No)] VARCHAR(6) NULL
	,[NHS Service Agreement Line No] VARCHAR(10) NULL
	,[Provider Reference No] VARCHAR(17) NULL
	,[Commissioner Reference No] VARCHAR(17) NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Organisation Code (Code Of Provider)] VARCHAR(12) NULL
	,[Provider Site Code] VARCHAR(12) NULL
	,[Organisation Code (Code Of Commissioner)] VARCHAR(12) NULL
	,[Commissioner Code (Original Data)] VARCHAR(12) NULL
	,[Commissioner Site Code] VARCHAR(12) NULL
	,[PCT Derived From GP] VARCHAR(12) NULL
	,[PCT Derived From GP Practice] VARCHAR(12) NULL
	,[GP Practice Derived From PDS] TINYINT NULL
	,[Location Class] VARCHAR(3) NULL
	,[Site Code Of Treatment] VARCHAR(12) NULL
	,[Organisation Code Type Provider] VARCHAR(1) NULL
	,[Organisation Code Type Commissioner] VARCHAR(1) NULL
	,[GP PCT Type (Derived)] VARCHAR(1) NULL
	,[PCT Of Residence (Original)] VARCHAR(12) NULL
	,[PCT Responsible] VARCHAR(12) NULL
	,[Location Type Code] VARCHAR(3) NULL
	,[Attendance Organisation Code Type] VARCHAR(1) NULL
	,[Provider Location] VARCHAR(4) NULL
	,[Consultant Code] VARCHAR(8) NULL
	,[Main Specialty Code] VARCHAR(3) NULL
	,[Treatment Function Code] VARCHAR(3) NULL
	,[Consultant Code Type] VARCHAR(3) NULL
	,[Consultant Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Type Consultant] VARCHAR(1) NULL
	,[Registered GMP Code] VARCHAR(8) NULL
	,[GP Code] VARCHAR(8) NULL
	,[GP Practice Code] VARCHAR(12) NULL
	,[GP Consortium Code] VARCHAR(12) NULL
	,[GP Practice Code (Original Data)] VARCHAR(12) NULL
	,[GP Practice Code (Derived)] VARCHAR(12) NULL
	,[Referrer Code] VARCHAR(8) NULL
	,[Referring Organisation Code] VARCHAR(12) NULL
	,[GP Code Type] VARCHAR(3) NULL
	,[Organisation Code Type GP] VARCHAR(1) NULL
	,[First GP Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Of GP] VARCHAR(12) NULL
	,[SHA From GP (Derived)] VARCHAR(12) NULL
	,[SHA Type From GP (Derived)] VARCHAR(1) NULL
	,[Referrer Code Type] VARCHAR(3) NULL
	,[Organisation Code Type Referrer] VARCHAR(1) NULL
	,[Priority Type] TINYINT NULL
	,[Service Type Requested] TINYINT NULL
	,[Referral Request Received Date] DATE NULL
	,[Last DNA Or Patient Cancelled Date] DATE NULL
	,[Request Received Date Status] VARCHAR(1) NULL
	,[Last Did Not Arrive Date] VARCHAR(8) NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Applicable Costing Period] VARCHAR(20) NULL
	,[PbR Spell Status Indicator] BIGINT NULL
	,[PbR Spell Frozen Indicator] BIGINT NULL
	,[PbR Spell Cost ID] BIGINT NULL
	,[Spell Cost Version Date] DATE NULL
	,[Spell Error Status] BIGINT NULL
	,[Spell Const Version No] VARCHAR(5) NULL
	,[HRG (Submitted)] VARCHAR(5) NULL
	,[Core HRG Version (Calculated)] VARCHAR(3) NULL
	,[Core HRG] VARCHAR(5) NULL
	,[SUS HRG] VARCHAR(5) NULL
	,[HRG Version (Submitted)] VARCHAR(3) NULL
	,[HRG Dominant Grouping Variable Procedure] VARCHAR(20) NULL
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
	,[HRG Dominant Grouping Variable] VARCHAR(7) NULL
	,[HRG Procedure Scheme] VARCHAR(3) NULL
	,[Diagnosis Scheme In Use] VARCHAR(3) NULL
	,[Primary Diagnosis Code] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 1] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 2] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 3] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 4] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 5] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 6] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 7] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 8] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 9] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 10] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 11] VARCHAR(7) NULL
	,[Secondary Diagnosis Code 12] VARCHAR(7) NULL
	,[Procedure Scheme In Use] VARCHAR(3) NULL
	,[Primary Procedure Code] VARCHAR(7) NULL
	,[Secondary Procedure Code 1] VARCHAR(7) NULL
	,[Secondary Procedure Date 1] DATE NULL
	,[Secondary Procedure Code 2] VARCHAR(7) NULL
	,[Secondary Procedure Date 2] DATE NULL
	,[Secondary Procedure Code 3] VARCHAR(7) NULL
	,[Secondary Procedure Date 3] DATE NULL
	,[Secondary Procedure Code 4] VARCHAR(7) NULL
	,[Secondary Procedure Date 4] DATE NULL
	,[Secondary Procedure Code 5] VARCHAR(7) NULL
	,[Secondary Procedure Date 5] DATE NULL
	,[Secondary Procedure Code 6] VARCHAR(7) NULL
	,[Secondary Procedure Date 6] DATE NULL
	,[Secondary Procedure Code 7] VARCHAR(7) NULL
	,[Secondary Procedure Date 7] DATE NULL
	,[Secondary Procedure Code 8] VARCHAR(7) NULL
	,[Secondary Procedure Date 8] DATE NULL
	,[Secondary Procedure Code 9] VARCHAR(7) NULL
	,[Secondary Procedure Date 9] DATE NULL
	,[Secondary Procedure Code 10] VARCHAR(7) NULL
	,[Secondary Procedure Date 10] DATE NULL
	,[Secondary Procedure Code 11] VARCHAR(7) NULL
	,[Secondary Procedure Date 11] DATE NULL
	,[Secondary Procedure Code 12] VARCHAR(7) NULL
	,[Secondary Procedure Date 12] DATE NULL
	,[Primary Procedure Date] DATE NULL
	,[HRG Used For Tariff] VARCHAR(2) NULL
	,[Tariff Initial Amount National] DECIMAL(9, 2) NULL
	,[Aggregate UnBundled Adjustment National] DECIMAL(9, 2) NULL
	,[Tariff Financial Adjustment National] BIGINT NULL
	,[Tariff Adjustment Future Use_1 National] BIGINT NULL
	,[Tariff Adjustment Future Use_2 National] BIGINT NULL
	,[Tariff Pre MFF Adjusted National] DECIMAL(9, 2) NULL
	,[Applied MFF National] DECIMAL(9, 2) NULL
	,[MFF Adjustment] DECIMAL(9, 2) NULL
	,[Tariff Total Payment National] DECIMAL(9, 2) NULL
	,[Outpatient Tariff] BIGINT NULL
	,[Market Forces Factor ID] BIGINT NULL
	,[Tariff Initial Amount Non Mandatory] BIGINT NULL
	,[Aggregate UnBundled Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Financial Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_1 Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_2 Non Mandatory] BIGINT NULL
	,[Tariff Pre MFF Adjusted Non Mandatory] BIGINT NULL
	,[Applied MFF Non Mandatory] BIGINT NULL
	,[MFF Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Total Payment Non Mandatory] BIGINT NULL
	,[Non Mandatory Core Tariff (With UB)] BIGINT NULL
	,[Tarrif Initial Amount Local] BIGINT NULL
	,[Aggregate UnBundled Adjustment Local] BIGINT NULL
	,[Tariff Total Payment Local] BIGINT NULL
	,[Local Core Tariff (With UB)] BIGINT NULL
	,[PbR Final Tariff] DECIMAL(9, 2) NULL
	,[Final Tariff Applied] VARCHAR(10) NULL
	,[Number Diagnosis] INT NULL
	,[Number Procedures] INT NULL
	,[Number Unbundled HRGs] INT NULL
	,[Number Unbundled Non Priced HRGs] INT NULL
	,[Number Unbundled Priced HRGs] INT NULL
	,[Number BPT Indicators] BIGINT NULL
	,[Organisation Code (Sender)] VARCHAR(12) NULL
	,[Staging Loaded Date] DATE NULL
	,[Protocol Identifier] VARCHAR(3) NULL
	,[Unique CDS Identifier] VARCHAR(35) NULL
	,[Applicable Date] DATE NULL
	,[Extract Date] DATE NULL
	,[Report Period Start Date] DATE NULL
	,[Report Period End Date] DATE NULL
	,[Organisation Code Type Sender] VARCHAR(1) NULL
	,[Match Criterion Indicator] BIGINT NULL
	,[Costing Batch Sequence] BIGINT NULL
	,[Current Period Number] VARCHAR(6) NULL
	,[Finished Indicator] BIGINT NULL
	,[HES Identifier] BIGINT NULL
	,[Intended Procedure Status] VARCHAR(1) NULL
	,[Interchange ID] VARCHAR(14) NULL
	,[Prime Recipient] VARCHAR(12) NULL
	,[Organisation Code Type Prime Recipient] VARCHAR(1) NULL
	,[Other Indicator] VARCHAR(2) NULL
	,[PbR Generated Interchange ID] BIGINT NULL
	,[Record Extraction Indicator] BIGINT NULL
	,[Re-Costing Requested Flag] VARCHAR(1) NULL
	,[Temporary Cost Period Status] VARCHAR(1) NULL
	,[Test Indicator] VARCHAR(1) NULL
	,[Update Type] TINYINT NULL
	,[Version Sequence Number] BIGINT NULL
	,[Hierarchy] BIGINT NULL
	,[Costed Indicator] BIGINT NULL
	,[Spare 1] VARCHAR(30) NULL
	,[Spare 2] VARCHAR(30) NULL
	,[Spare 3] VARCHAR(30) NULL
	,[Spare 4] VARCHAR(30) NULL
	,[Spare 5] VARCHAR(30) NULL
	,[Direct Access Tariff Flag] CHAR(1) NULL
	,[Spell NPOC] VARCHAR(3) NULL
	,[Spell Service Line] VARCHAR(8) NULL
	,[Commissioning Region] VARCHAR(255) NULL
	,[Unbundled Exclusion Reason] VARCHAR(255) NULL
	,[Grouping Algorithm Version] VARCHAR(8) NULL
	,[Grouping Reference Data Version] VARCHAR(255) NULL
	,[Grouping HRG Version] VARCHAR(20) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Copy Recipients] VARCHAR(50) NULL
	,[Derived Commissioner] VARCHAR(12) NULL
	,[Derived Commissioner Type] VARCHAR(100) NULL
	,[Is Valid UBRN] BIT NULL
	,[UBRN Occurrence Count] BIGINT NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
