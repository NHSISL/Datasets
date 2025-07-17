CREATE TABLE [Casted].[AE_pbr_preprocess_EC] (
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
	,[NHS Number] VARCHAR(10) NULL
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
	,[Age At CDS Activity Date] SMALLINT NULL
	,[Derived Age] BIGINT NULL
	,[Patient Type] VARCHAR(3) NULL
	,[Age Range Derived] SMALLINT NULL
	,[Year Of Birth] SMALLINT NULL
	,[Month Of Birth] TINYINT NULL
	,[Age At Record Start] BIGINT NULL
	,[Age At Record End] BIGINT NULL
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
	,[SHA From Patient Postcode] VARCHAR(12) NULL
	,[SHA Type From Patient Postcode] VARCHAR(255) NULL
	,[Area Code Derived] VARCHAR(4) NULL
	,[Organisation Code Type PCT Of Residence] VARCHAR(1) NULL
	,[PCT Of Residence (Original)] VARCHAR(12) NULL
	,[PCT Responsible] VARCHAR(12) NULL
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
	,[EM Attendance Number] VARCHAR(12) NULL
	,[EM Mode Of Arrival] VARCHAR(1) NULL
	,[EM Attendance Category] VARCHAR(1) NULL
	,[EM Attendance Disposal] VARCHAR(2) NULL
	,[EM Incident Location Type] VARCHAR(2) NULL
	,[EM Staff Member Code] VARCHAR(3) NULL
	,[EM Referral Source] VARCHAR(2) NULL
	,[Arrival Date] DATE NULL
	,[EM Patient Group] VARCHAR(2) NULL
	,[EM Attendance Conclusion Time] TIME(0) NULL
	,[EM Departure Time] TIME(0) NULL
	,[EM Initial Assessment Time] TIME(0) NULL
	,[EM Time Seen For Treatment] TIME(0) NULL
	,[Arrival Time] TIME(0) NULL
	,[CDS Activity Date] DATE NULL
	,[EM Attendance Category ID] BIGINT NULL
	,[Consultant Code Type] VARCHAR(3) NULL
	,[Consultant Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Type Consultant] VARCHAR(1) NULL
	,[EM Conclusion Waiting Time] VARCHAR(8) NULL
	,[EM Duration Time] VARCHAR(8) NULL
	,[EM Assessment Waiting Time] VARCHAR(8) NULL
	,[EM Treatment Wait Time] VARCHAR(8) NULL
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
	,[Organisation Code Type Provider] VARCHAR(1) NULL
	,[Provider Code (Original Data)] VARCHAR(12) NULL
	,[Organisation Code Type Commissioner] VARCHAR(1) NULL
	,[GP PCT Type (Derived)] VARCHAR(1) NULL
	,[Registered GMP Code] VARCHAR(8) NULL
	,[Registered GMP Code (Original Data)] VARCHAR(8) NULL
	,[GP Practice Code (Original Data)] VARCHAR(12) NULL
	,[GP Practice Code] VARCHAR(12) NULL
	,[GP Consortium Code] VARCHAR(12) NULL
	,[GP Code Type] VARCHAR(3) NULL
	,[Organisation Code GP] VARCHAR(12) NULL
	,[Organisation Code Type GP] VARCHAR(1) NULL
	,[First GP Organisation Code] VARCHAR(12) NULL
	,[SHA From GP (Derived)] VARCHAR(12) NULL
	,[SHA Type From GP (Derived)] VARCHAR(1) NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Applicable Costing Period] VARCHAR(20) NULL
	,[PbR Spell Status Indicator] BIGINT NULL
	,[PbR Spell Frozen Indicator] BIGINT NULL
	,[HRG Code - Submitted] VARCHAR(5) NULL
	,[HRG Code Version - Submitted] VARCHAR(3) NULL
	,[Core HRG] VARCHAR(5) NULL
	,[HRG Code Version - Calculated] VARCHAR(255) NULL
	,[HRG Dominant Grouping Variable] VARCHAR(7) NULL
	,[HRG Dominant Grouping Variable Procedure] VARCHAR(20) NULL
	,[HRG Procedure Scheme] VARCHAR(3) NULL
	,[Diagnosis Scheme In Use] VARCHAR(3) NULL
	,[ICD 10 Primary Diagnosis] VARCHAR(7) NULL
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
	,[EM Diagnosis First] VARCHAR(7) NULL
	,[EM Diagnosis Second 1] VARCHAR(7) NULL
	,[EM Diagnosis Second 2] VARCHAR(7) NULL
	,[EM Diagnosis Second 3] VARCHAR(7) NULL
	,[EM Diagnosis Second 4] VARCHAR(7) NULL
	,[EM Diagnosis Second 5] VARCHAR(7) NULL
	,[EM Diagnosis Second 6] VARCHAR(7) NULL
	,[EM Diagnosis Second 7] VARCHAR(7) NULL
	,[EM Diagnosis Second 8] VARCHAR(7) NULL
	,[EM Diagnosis Second 9] VARCHAR(7) NULL
	,[EM Diagnosis Second 10] VARCHAR(7) NULL
	,[EM Diagnosis Second 11] VARCHAR(7) NULL
	,[EM Diagnosis Second 12] VARCHAR(7) NULL
	,[Diagnosis Type] VARCHAR(1) NULL
	,[Investigation Scheme In Use] VARCHAR(2) NULL
	,[EM Investigation First] VARCHAR(7) NULL
	,[EM Investigation Second 1] VARCHAR(7) NULL
	,[EM Investigation Second 2] VARCHAR(7) NULL
	,[EM Investigation Second 3] VARCHAR(7) NULL
	,[EM Investigation Second 4] VARCHAR(7) NULL
	,[EM Investigation Second 5] VARCHAR(7) NULL
	,[EM Investigation Second 6] VARCHAR(7) NULL
	,[EM Investigation Second 7] VARCHAR(7) NULL
	,[EM Investigation Second 8] VARCHAR(7) NULL
	,[EM Investigation Second 9] VARCHAR(7) NULL
	,[EM Investigation Second 10] VARCHAR(7) NULL
	,[EM Investigation Second 11] VARCHAR(7) NULL
	,[EM Investigation Second 12] VARCHAR(7) NULL
	,[Procedure Scheme In Use] VARCHAR(3) NULL
	,[EM Treatment First] VARCHAR(7) NULL
	,[Procedure Date (Of First Treatment)] DATE NULL
	,[EM Treatment Second 1] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 1] DATE NULL
	,[EM Treatment Second 2] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 2] DATE NULL
	,[EM Treatment Second 3] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 3] DATE NULL
	,[EM Treatment Second 4] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 4] DATE NULL
	,[EM Treatment Second 5] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 5] DATE NULL
	,[EM Treatment Second 6] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 6] DATE NULL
	,[EM Treatment Second 7] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 7] DATE NULL
	,[EM Treatment Second 8] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 8] DATE NULL
	,[EM Treatment Second 9] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 9] DATE NULL
	,[EM Treatment Second 10] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 10] DATE NULL
	,[EM Treatment Second 11] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 11] DATE NULL
	,[EM Treatment Second 12] VARCHAR(7) NULL
	,[Procedure Date (Of Subsequent Treatments) 12] DATE NULL
	,[Primary Procedure] VARCHAR(7) NULL
	,[Primary Procedure Date] DATE NULL
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
	,[Derived EM Department Type] VARCHAR(2) NULL
	,[EM Department Type] VARCHAR(2) NULL
	,[EM Department Type MIU Indicator Derived] VARCHAR(2) NULL
	,[Tariff Initial Amount National] DECIMAL(9, 2) NULL
	,[Tariff Financial Adjustment National] BIGINT NULL
	,[Tariff Adjustment Future Use_1 National] BIGINT NULL
	,[Tariff Adjustment Future Use_2 National] BIGINT NULL
	,[Tariff Pre MFF Adjusted National] DECIMAL(9, 2) NULL
	,[Applied MFF National] DECIMAL(9, 2) NULL
	,[MFF Adjustment] DECIMAL(9, 2) NULL
	,[Tariff Total Payment National] DECIMAL(9, 2) NULL
	,[EM Tariff ID] BIGINT NULL
	,[Market Forces Factor ID] BIGINT NULL
	,[Tariff Initial Amount Non Mandatory] BIGINT NULL
	,[Tariff Financial Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_1 Non Mandatory] BIGINT NULL
	,[Tariff Adjustment Future Use_2 Non Mandatory] BIGINT NULL
	,[Tariff Pre MFF Adjusted Non Mandatory] BIGINT NULL
	,[Applied MFF Non Mandatory] BIGINT NULL
	,[MFF Adjustment Non Mandatory] BIGINT NULL
	,[Tariff Total Payment Non Mandatory] BIGINT NULL
	,[Tarrif Initial Amount Local] BIGINT NULL
	,[Tariff Total Payment Local] BIGINT NULL
	,[PbR Final Tariff] DECIMAL(9, 2) NULL
	,[Final Tariff Applied] VARCHAR(10) NULL
	,[Number Diagnosis] INT NULL
	,[Number Procedures] INT NULL
	,[Number EM Investigations] INT NULL
	,[Number EM Treatments] INT NULL
	,[Organisation Code (Sender)] VARCHAR(12) NULL
	,[Staging Loaded Date] DATE NULL
	,[Protocol Identifier] VARCHAR(3) NULL
	,[Unique CDS Identifier] VARCHAR(35) NULL
	,[Applicable Date And Time] DATE NULL
	,[Extract Date] DATE NULL
	,[Report Period Start Date] DATE NULL
	,[Report Period End Date] DATE NULL
	,[Organisation Code Type Sender] VARCHAR(1) NULL
	,[Match Criterion Indicator] BIGINT NULL
	,[Cost Period Spell Status Indicator] BIGINT NULL
	,[Costed Indicator] BIGINT NULL
	,[Costing Batch Sequence] BIGINT NULL
	,[Current Period Number] VARCHAR(6) NULL
	,[Finished Indicator] BIGINT NULL
	,[HES Identifier] BIGINT NULL
	,[Intended Procedure Status] VARCHAR(1) NULL
	,[Interchange ID] VARCHAR(14) NULL
	,[Attendance Location Class] VARCHAR(3) NULL
	,[Location Type Code] VARCHAR(3) NULL
	,[Attendance Site Code] VARCHAR(12) NULL
	,[Prime Recipient] VARCHAR(12) NULL
	,[Organisation Code Type Prime Recipient] VARCHAR(1) NULL
	,[Organisation Code Type Location] VARCHAR(1) NULL
	,[Other Indicator] VARCHAR(2) NULL
	,[PbR Generated Interchange ID] BIGINT NULL
	,[Spell Const Version No] VARCHAR(5) NULL
	,[PbR Spell Cost ID] BIGINT NULL
	,[PbR Spell Cost Version Date] BIGINT NULL
	,[Provider Location] VARCHAR(4) NULL
	,[Record Extraction Indicator] BIGINT NULL
	,[Re-Costing Requested Flag] VARCHAR(1) NULL
	,[Referrer Code Type] VARCHAR(3) NULL
	,[Organisation Code Type Referrer] VARCHAR(1) NULL
	,[First Referrer Organisation Code] VARCHAR(12) NULL
	,[Spell Complete Indicator] TINYINT NULL
	,[Temporary Cost Period Status] VARCHAR(1) NULL
	,[Test Indicator] VARCHAR(1) NULL
	,[Update Type] TINYINT NULL
	,[Version Sequence Number] BIGINT NULL
	,[Maximum Episode Date] DATE NULL
	,[Hierarchy] BIGINT NULL
	,[PbR Spell Service ID Version] DATE NULL
	,[Spell Error Status] BIGINT NULL
	,[Spare 1] VARCHAR(30) NULL
	,[Spare 2] VARCHAR(30) NULL
	,[Spare 3] VARCHAR(30) NULL
	,[Spare 4] VARCHAR(30) NULL
	,[Spare 5] VARCHAR(30) NULL
	,[Grouping Algorithm Version] VARCHAR(8) NULL
	,[Grouping Reference Data Version] VARCHAR(255) NULL
	,[Grouping HRG Version] VARCHAR(20) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Copy Recipients] VARCHAR(50) NULL
	,[Derived Commissioner] VARCHAR(12) NULL
	,[Derived Commissioner Type] VARCHAR(100) NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
