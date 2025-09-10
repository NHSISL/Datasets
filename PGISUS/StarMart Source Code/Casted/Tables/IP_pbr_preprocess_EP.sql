CREATE TABLE [Casted].[IP_pbr_preprocess_EP] (
	[SUS Version] VARCHAR(17) NULL
	,[NHS RID (From Provider)] VARCHAR(35) NULL
	,[Spell Identifier] BIGINT NULL
	,[Parent Spell Identifier] BIGINT NULL
	,[Generated Record ID] BIGINT NULL
	,[Dominant Generated Record ID] BIGINT NULL
	,[First Generated Record ID] BIGINT NULL
	,[Last Generated Record ID] BIGINT NULL
	,[CDS Record Type] VARCHAR(3) NULL
	,[Reason Access Provided] VARCHAR(30) NULL
	,[CDS Group Derived] BIGINT NULL
	,[CDS Group Indicator] TINYINT NULL
	,[Bulk Replacement CDS Group] VARCHAR(3) NULL
	,[Pseudonymised Status] BIGINT NULL
	,[Confidentiality Category] TINYINT NULL
	,[Local Patient Identifier] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier] VARCHAR(12) NULL
	,[NHS Number] CHAR(10) NULL
	,[NHS Number (Mother)] CHAR(10) NULL
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
	,[Patient Type] VARCHAR(3) NULL
	,[Age At Start Of Episode Derived] BIGINT NULL
	,[Age At Start Of Spell] SMALLINT NULL
	,[Spell Age] BIGINT NULL
	,[Episode Age] BIGINT NULL
	,[Local Patient Identifier (Mother)] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier (Mother)] VARCHAR(12) NULL
	,[Birth Date (Mother)] DATE NULL
	,[Year Of Birth] SMALLINT NULL
	,[Birth Year (Mother)] SMALLINT NULL
	,[Birth Month] TINYINT NULL
	,[Birth Month (Mother)] TINYINT NULL
	,[Age At Spell End Original] SMALLINT NULL
	,[Age At Record Start] BIGINT NULL
	,[Age At End Of Spell] SMALLINT NULL
	,[Age At Spell Start Original] SMALLINT NULL
	,[Age At Record End] BIGINT NULL
	,[Age Range Derived] SMALLINT NULL
	,[Age Range Derived (Mother)] SMALLINT NULL
	,[Carer Support Indicator] VARCHAR(2) NULL
	,[Legal Status Classification Code] VARCHAR(2) NULL
	,[Ethnic Category Code] VARCHAR(2) NULL
	,[Marital Status] VARCHAR(1) NULL
	,[NHS Number Status Indicator] VARCHAR(2) NULL
	,[Gender Code] VARCHAR(1) NULL
	,[Total Previous Pregnancies] VARCHAR(2) NULL
	,[Postcode Of Usual Address] VARCHAR(8) NULL
	,[Postcode Sector Of Usual Address] VARCHAR(8) NULL
	,[Organisation Code (PCT Of Residence)] VARCHAR(12) NULL
	,[Patient Postcode Derived PCT Type] VARCHAR(1) NULL
	,[Patient Postcode Derived PCT] VARCHAR(12) NULL
	,[Patient Name] VARCHAR(70) NULL
	,[Patient Usual Address] VARCHAR(175) NULL
	,[Organisation Code Type PCT Of Residence] VARCHAR(1) NULL
	,[NHS Number Status Indicator (Mother)] VARCHAR(2) NULL
	,[Postcode Dominant] VARCHAR(8) NULL
	,[Patient Usual Address (Mother)] VARCHAR(175) NULL
	,[Postcode Of Usual Address (Mother)] VARCHAR(8) NULL
	,[Area Code Of Usual Address] VARCHAR(9) NULL
	,[Area Code Derived] VARCHAR(4) NULL
	,[Organisation Code (PCT Of Residence - Mother)] VARCHAR(3) NULL
	,[Patient Postcode Derived PCT Type (Mother)] VARCHAR(1) NULL
	,[Patient Postcode Electoral Ward] VARCHAR(255) NULL
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
	,[Hospital Provider Spell No] VARCHAR(20) NULL
	,[Administrative Category (At Start Of Episode)] VARCHAR(2) NULL
	,[Administrative Category (On Admission)] VARCHAR(2) NULL
	,[Patient Classification] VARCHAR(1) NULL
	,[Admission Method (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Admission Method (Original Data)] VARCHAR(2) NULL
	,[Admission Type (Derived)] VARCHAR(3) NULL
	,[Admission Subtype (Derived)] VARCHAR(3) NULL
	,[Discharge Destination (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Discharge Method (Hospital Provider Spell)] VARCHAR(1) NULL
	,[Source Of Admission (Hospital Provider Spell)] VARCHAR(2) NULL
	,[Start Date (Hospital Provider Spell)] DATE NULL
	,[End Date (Hospital Provider Spell)] DATE NULL
	,[Spell In PbR/Not In PbR] TINYINT NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[Delay Discharge Reason] VARCHAR(4000) NULL
	,[Delayed Discharged Days] SMALLINT NULL
	,[Administrative Category (Derived)] VARCHAR(20) NULL
	,[Elective Admission Type] VARCHAR(2) NULL
	,[PbR Spell Start Date] DATE NULL
	,[PbR Spell End Date] DATE NULL
	,[Hospital Provider Spell Discharge Date] DATE NULL
	,[Hospital Provider Spell End Date] DATE NULL
	,[Ready For Discharge Date] DATE NULL
	,[PbR Delayed Discharge Days Derived] BIGINT NULL
	,[Spell Exclusion Reason] VARCHAR(100) NULL
	,[Applicable Costing Period] VARCHAR(20) NULL
	,[Episode Number] TINYINT NULL
	,[First Regular Day Night Admission] VARCHAR(1) NULL
	,[Last Episode In Spell Indicator] VARCHAR(1) NULL
	,[Neonatal Level Of Care] VARCHAR(1) NULL
	,[Operation Status] VARCHAR(1) NULL
	,[Episode Start Date] DATE NULL
	,[Episode End Date] DATE NULL
	,[CDS Activity Date] DATE NULL
	,[Episode Start Date Original] DATE NULL
	,[Commissioner Serial No (Agreement No)] VARCHAR(6) NULL
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
	,[Spell Commissioner Code] VARCHAR(12) NULL
	,[PCT Derived From GP] VARCHAR(12) NULL
	,[PCT Derived From GP Practice] VARCHAR(12) NULL
	,[GP Practice Derived From PDS] TINYINT NULL
	,[Site Code Of Treatment (At Start Of Episode)] VARCHAR(5) NULL
	,[Organisation Code Type Provider] VARCHAR(1) NULL
	,[Provider Code (Original Data)] VARCHAR(12) NULL
	,[Provider Location Derived] VARCHAR(4) NULL
	,[Organisation Code Type Commissioner] VARCHAR(1) NULL
	,[GP PCT Type (Derived)] VARCHAR(1) NULL
	,[SHA From GP (Derived)] VARCHAR(12) NULL
	,[SHA Type From GP (Derived)] VARCHAR(1) NULL
	,[PCT Derived From GP Practice (Mother)] VARCHAR(255) NULL
	,[Consultant Code] VARCHAR(8) NULL
	,[Main Specialty Code] VARCHAR(3) NULL
	,[Treatment Function Code] VARCHAR(3) NULL
	,[Consultant Code Type] VARCHAR(3) NULL
	,[Consultant Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Type Consultant] VARCHAR(1) NULL
	,[Specialty Function Code Original] VARCHAR(3) NULL
	,[Elective Consultant Code] VARCHAR(8) NULL
	,[Elective Consultant Specialty Code] VARCHAR(3) NULL
	,[Elective Consultant Code Type] VARCHAR(3) NULL
	,[Elective Specialty Function Code] VARCHAR(3) NULL
	,[Elective Consultant Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Type Elective Consultant] VARCHAR(1) NULL
	,[Antenatal Consultant Code] VARCHAR(8) NULL
	,[Antenatal Consultant Specialty Code] VARCHAR(3) NULL
	,[Antenatal Consultant Code Type] VARCHAR(3) NULL
	,[Antenatal Specialty Function Code] VARCHAR(3) NULL
	,[Antenatal Consultant Organisation Code] VARCHAR(12) NULL
	,[Organisation Code Type Antenatal Consultant] VARCHAR(1) NULL
	,[Registered GMP Code] VARCHAR(8) NULL
	,[GP Code (Original Data)] VARCHAR(8) NULL
	,[GP Practice Code] VARCHAR(12) NULL
	,[GP Consortium Code] VARCHAR(12) NULL
	,[GP Practice Code (Original Data)] VARCHAR(12) NULL
	,[GP Practice Code (Derived)] VARCHAR(12) NULL
	,[Referrer Code] VARCHAR(8) NULL
	,[Referring Organisation Code] VARCHAR(12) NULL
	,[Code Of GP] VARCHAR(8) NULL
	,[Organisation Code GP] VARCHAR(12) NULL
	,[Organisation Code Type GP] VARCHAR(1) NULL
	,[Organisation Code Type GP Practice] VARCHAR(1) NULL
	,[GP Code (Mother)] VARCHAR(8) NULL
	,[Organisation Code GP (Mother)] VARCHAR(12) NULL
	,[Organisation Code Type GP (Mother)] VARCHAR(1) NULL
	,[GP Code Type] VARCHAR(3) NULL
	,[GP Code Type (Mother)] VARCHAR(3) NULL
	,[First GP Organisation Code] VARCHAR(12) NULL
	,[GP Practice Code Original] VARCHAR(12) NULL
	,[GP Practice Code Derived] VARCHAR(12) NULL
	,[GP Practice Code Derived (Mother)] VARCHAR(12) NULL
	,[Organisation Code Type Referrer] VARCHAR(1) NULL
	,[Referrer Code Type] VARCHAR(3) NULL
	,[Organisation Code Type Prime Recipient] VARCHAR(1) NULL
	,[Duration Of Elective Wait] INT NULL
	,[Intended Management] VARCHAR(1) NULL
	,[Decided To Admit Date] DATE NULL
	,[Episode Duration] SMALLINT NULL
	,[Episode Duration Grouper] SMALLINT NULL
	,[Length Of Stay (Hospital Provider Spell)] BIGINT NULL
	,[PbR NCC PCC Adjusted Length Of Stay] BIGINT NULL
	,[PbR Final Adjusted Length Of Stay] BIGINT NULL
	,[Spell ACC Length Of Stay] BIGINT NULL
	,[Spell NCC Length Of Stay] BIGINT NULL
	,[Spell PCC Length Of Stay] BIGINT NULL
	,[Spell Primary Diagnosis] VARCHAR(6) NULL
	,[Spell Secondary Diagnosis] VARCHAR(6) NULL
	,[HRG Submitted] VARCHAR(5) NULL
	,[HRG Version (Submitted)] VARCHAR(3) NULL
	,[Core HRG (Calculated)] VARCHAR(5) NULL
	,[Episode HRG Version (Calculated)] VARCHAR(3) NULL
	,[Episode Dominant Procedure] VARCHAR(7) NULL
	,[Grouping Algorithm Version] VARCHAR(8) NULL
	,[Grouping Reference Data Version] VARCHAR(255) NULL
	,[Grouping HRG Version] VARCHAR(20) NULL
	,[Spell Core HRG] VARCHAR(5) NULL
	,[HRG Dominant Grouping Variable] VARCHAR(7) NULL
	,[HRG Procedure Scheme] VARCHAR(3) NULL
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
	,[Programme Budgeting Category] VARCHAR(8) NULL
	,[Spell Programme Budgeting Category] VARCHAR(255) NULL
	,[Spell Report Flag] BIGINT NULL
	,[PbR Excluded Indicator] TINYINT NULL
	,[Episode Exclusion Reason] VARCHAR(100) NULL
	,[Code Cleaning] VARCHAR(1) NULL
	,[PbR Costed Indicator] BIGINT NULL
	,[Grouping Method] VARCHAR(255) NULL
	,[Configurable Indicator] VARCHAR(4) NULL
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
	,[Spell Dominant Procedure] VARCHAR(255) NULL
	,[Advanced Cardiovascular Support Days] SMALLINT NULL
	,[Advanced Respiratory Support Days] SMALLINT NULL
	,[Basic Cardiovascular Support Days] SMALLINT NULL
	,[Basic Respiratory Support Days] SMALLINT NULL
	,[Critical Care Level2 Days] VARCHAR(255) NULL
	,[Critical Care Level3 Days] VARCHAR(255) NULL
	,[Critical Care Unit Function] VARCHAR(2) NULL
	,[Dermatological Support Days] SMALLINT NULL
	,[Neurological Support Days] SMALLINT NULL
	,[Renal Support Days] SMALLINT NULL
	,[Liver Support Days] SMALLINT NULL
	,[Episode ACC Length Of Stay] INT NULL
	,[Episode NCC Length Of Stay] INT NULL
	,[Episode PCC Length Of Stay] INT NULL
	,[APC Tariff ID] BIGINT NULL
	,[Market Forces Factor] DECIMAL(9, 7) NULL
	,[Market Forces Factor ID] BIGINT NULL
	,[Tariff Initial Amount National] DECIMAL(9, 2) NULL
	,[Tariff Day Case National] BIGINT NULL
	,[Tariff Long Stay Payment National] DECIMAL(9, 2) NULL
	,[Tariff Long Stay Rate National] DECIMAL(9, 2) NULL
	,[Tariff Service Adjustment National] DECIMAL(9, 2) NULL
	,[Tariff Short Stay Elective National] BIGINT NULL
	,[Tariff Short Stay Emergency National] VARCHAR(255) NULL
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
	,[App Period Spell Status Indicator] BIGINT NULL
	,[Hospital Provider Spell Duration Days Derived] BIGINT NULL
	,[Number Of Episodes In PbR Spell] BIGINT NULL
	,[RAP DH Tariff Adjustment Child] VARCHAR(1) NULL
	,[RAP Validation Child Indicator] VARCHAR(255) NULL
	,[RAP Spell Type] VARCHAR(6) NULL
	,[PbR Generated Interchange ID] BIGINT NULL
	,[PbR Spell Cost ID] BIGINT NULL
	,[PbR Spell Cost Version Date] BIGINT NULL
	,[PbR Spell Const Version Number] VARCHAR(5) NULL
	,[PbR Spell Complete Indicator] BIGINT NULL
	,[PbR Spell Error Status] TINYINT NULL
	,[PbR Spell Frozen Indicator] BIGINT NULL
	,[Spell Service ID] VARCHAR(10) NULL
	,[Spell Service Version] VARCHAR(10) NULL
	,[PbR Spell Status Indicator] BIGINT NULL
	,[Match Criterion Indicator] BIGINT NULL
	,[Number Of Babies] VARCHAR(1) NULL
	,[Location Class Of Delivery Place (Intended)] VARCHAR(2) NULL
	,[Location Type Of Delivery Place (Intended)] VARCHAR(3) NULL
	,[Anaesthetic During Labour] VARCHAR(1) NULL
	,[Anaesthetic Post Labour] VARCHAR(1) NULL
	,[Location Class Of Delivery Place (Actual)] VARCHAR(2) NULL
	,[Location Type Of Delivery Place (Actual)] VARCHAR(3) NULL
	,[Birth Order] TINYINT NULL
	,[Birth Weight] SMALLINT NULL
	,[Delivery Date] DATE NULL
	,[Delivery Method] VARCHAR(1) NULL
	,[Delivery Place Change Reason] VARCHAR(1) NULL
	,[Delivery Place Type Actual] VARCHAR(1) NULL
	,[Delivery Place Type Intended] VARCHAR(1) NULL
	,[First Antenatal Assessment Date] DATE NULL
	,[Gestation Length] TINYINT NULL
	,[Gestation Length Assessment] TINYINT NULL
	,[Live Or Still Birth] VARCHAR(1) NULL
	,[Status Of Person Conducting Delivery] VARCHAR(1) NULL
	,[Local Patient Identifier (Baby)] VARCHAR(10) NULL
	,[Org Code Local Patient Identifier (Baby)] VARCHAR(255) NULL
	,[NHS Number (Baby)] CHAR(10) NULL
	,[NHS Number Status Ind (Baby)] VARCHAR(2) NULL
	,[Date Of Birth (Baby)] DATE NULL
	,[Sex (Baby)] TINYINT NULL
	,[Costing Batch Sequence] BIGINT NULL
	,[Count Of Days Suspended] VARCHAR(4) NULL
	,[Current Period Number] VARCHAR(6) NULL
	,[PbR Days Beyond Trimpoint] SMALLINT NULL
	,[PbR Spell Trimpoint Days] SMALLINT NULL
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
	,[Dominant Contract Identifier] VARCHAR(16) NULL
	,[Episode Duration Days Derived] SMALLINT NULL
	,[Error Reason] VARCHAR(255) NULL
	,[Excluded Critical Care Days] SMALLINT NULL
	,[Finished Indicator] BIGINT NULL
	,[First Attendance] VARCHAR(1) NULL
	,[First Staging Loaded Date] DATE NULL
	,[HES Identifier] BIGINT NULL
	,[Hierarchy] BIGINT NULL
	,[Intended Procedure Status] VARCHAR(1) NULL
	,[Interchange ID] VARCHAR(14) NULL
	,[Last Did Not Arrive Date] VARCHAR(8) NULL
	,[Last Entry Review Date] VARCHAR(8) NULL
	,[Last Staging Loaded Date] DATE NULL
	,[Location Type Code] VARCHAR(3) NULL
	,[Logically Deleted Date] DATE NULL
	,[Maximum Episode Date] DATE NULL
	,[Onset Method] TINYINT NULL
	,[Organisation Code Type Location] VARCHAR(1) NULL
	,[Other Indicator] VARCHAR(2) NULL
	,[Outcome Of Attendance] VARCHAR(1) NULL
	,[PCT Responsible] VARCHAR(12) NULL
	,[Record Extraction Indicator] BIGINT NULL
	,[Re-Costing Requested Flag] VARCHAR(1) NULL
	,[Resuscitation Method] VARCHAR(1) NULL
	,[Service Original] VARCHAR(10) NULL
	,[Service Top-Up Percentage] BIGINT NULL
	,[Short Stay Redn Pcnt] VARCHAR(255) NULL
	,[Significant Service ID] VARCHAR(10) NULL
	,[Specialty Service Top-Up] VARCHAR(255) NULL
	,[Temporary Cost Period Status] VARCHAR(1) NULL
	,[Test Indicator] VARCHAR(1) NULL
	,[Update Type] TINYINT NULL
	,[Version Sequence Number] BIGINT NULL
	,[Number Of Commissioners In PbR Spell] TINYINT NULL
	,[Number Diagnosis] INT NULL
	,[Number Procedures] INT NULL
	,[Number Unbundled HRGs] INT NULL
	,[Number Unbundled Non Priced HRGs] INT NULL
	,[Number Unbundled Priced HRGs] INT NULL
	,[Excluded Episodes In Hospital Provider Spell] TINYINT NULL
	,[Number Hospital Provider Spell ID] TINYINT NULL
	,[Number SSCs] TINYINT NULL
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
	,[Dominant Staging Loaded Date] DATE NULL
	,[Extract Type] VARCHAR(20) NULL
	,[Location Class At Epistart] VARCHAR(2) NULL
	,[Org Code Location At Epistart] VARCHAR(5) NULL
	,[Org Code Type Location At Epistart] VARCHAR(3) NULL
	,[Intended Care Intensity At Epistart] VARCHAR(2) NULL
	,[Age Group Intended At Epistart] VARCHAR(1) NULL
	,[Sex Of Patients At Epistart] VARCHAR(1) NULL
	,[Day Period Availability At Epistart] VARCHAR(1) NULL
	,[Night Period Availability At Epistart] VARCHAR(1) NULL
	,[Location Class At Epiend] VARCHAR(2) NULL
	,[Org Code Location At Epiend] VARCHAR(12) NULL
	,[Org Code Type Location At Epiend] VARCHAR(3) NULL
	,[Intended Care Intensity At Epiend] VARCHAR(2) NULL
	,[Age Group Intended At Epiend] VARCHAR(1) NULL
	,[Sex Of Patients At Epiend] VARCHAR(1) NULL
	,[Day Period Availability At Epiend] TINYINT NULL
	,[Night Period Availability At Epiend] VARCHAR(1) NULL
	,[Spare 1] VARCHAR(30) NULL
	,[Spare 2] VARCHAR(30) NULL
	,[Spare 3] VARCHAR(30) NULL
	,[Spare 4] VARCHAR(30) NULL
	,[Spare 5] VARCHAR(30) NULL
	,[FCE NPOC] VARCHAR(3) NULL
	,[FCE Service Line] VARCHAR(8) NULL
	,[FCE Service Line List] VARCHAR(4000) NULL
	,[Spell NPOC] VARCHAR(3) NULL
	,[Spell Service Line] VARCHAR(8) NULL
	,[Commissioning Region] VARCHAR(255) NULL
	,[Data Quality Indicator] VARCHAR(255) NULL
	,[Unbundled Exclusion Reason] VARCHAR(255) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Prime Recipient] VARCHAR(12) NULL
	,[Copy Recipients] VARCHAR(50) NULL
	,[Ward Code At Episode Start Date] VARCHAR(12) NULL
	,[Ward Security Level At Episode Start Date] VARCHAR(1) NULL
	,[Ward Code At Episode End Date] VARCHAR(12) NULL
	,[Ward Security Level At Episode End Date] VARCHAR(1) NULL
	,[Derived Commissioner] VARCHAR(12) NULL
	,[Derived Commissioner Type] VARCHAR(100) NULL
	,[Open Spell Indicator] VARCHAR(1) NULL
	,[NHSE Planning Commissioner] VARCHAR(32) NULL
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
