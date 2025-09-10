CREATE VIEW [StarMart].[IP_EncounterHomeBirth]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[Spell_Identifier] = [EP].[Spell Identifier]
	--
	-- /* Patient Pathway */
	,[Unique_Booking_Reference_Number_Converted] = [EP].[Unique Booking Reference Number (Converted)]
	,[RTT_Patient_Pathway_Identifier] = [EP].[RTT Patient Pathway Identifier] --[Patient Pathway Identifier]
	,[Organisation_Code_Patient_Pathway_Identifier] = [EP].[Organisation Code Patient Pathway Identifier] -- [Organisation Code (Patient Pathway Identifier Issuer)]
	,[RTT_Status] = [EP].[RTT Status] -- [Referral To Treatment Period Status]
	,[Waiting_Time_Measurement_Type] = [CDS62_EP].[Waiting Time Measurement Type]
	,[RTT_Period_Start_Date] = [EP].[RTT Period Start Date] -- [Referral To Treatment Period Start Date]
	,[RTT_Period_End_Date] = [EP].[RTT Period End Date] -- [Referral To Treatment Period End Date]
	--,[RTT_Length_Derived] = [EP].[RTT Length (Derived)]
	--
	-- /* Patient Identity */
	,[Local_Patient_Identifier] = [EP_Pseudo].[Local Patient Identifier]
	,[Org_Code_Local_Patient_Identifier] = [EP].[Org Code Local Patient Identifier] -- [Organisation Code (Local Patient Identifier)]
	--,[NHS_Number] = [PID].[NHS Number]
	,[NHS_Number_Status_Indicator] = [EP].[NHS Number Status Indicator]
	--,[Patient_Name] = [PID].[Patient Name]
	--,[Patient_Usual_Address] = [PID].[Patient Usual Address]
	--,[Postcode_Of_Usual_Address] = [PID].[Postcode Of Usual Address]
	,[Organisation_Code_PCT_Of_Residence] = [EP].[Organisation Code (PCT Of Residence)] -- [Organisation Code (Residence Responsibility)]
	--,[Birth_Date] = [PID].[Birth Date] -- [Person Birth Date]
	,[Withheld_Identity_Reason] = [CDS62_EP].[Withheld Identity Reason]
	--
	-- /* Patient Characteristics */
	,[Gender_Code] = [EP].[Gender Code] -- [Person Gender Code Current]
	,[Carer_Support_Indicator] = [EP].[Carer Support Indicator]
	,[Ethnic_Category_Code] = [EP].[Ethnic Category Code] -- [Ethnic Category]
	,[Marital_Status] = [EP].[Marital Status] -- [Person Marital Status]
	--
	-- /* Delivery Characteristics */
	,[Total_Previous_Pregnancies] = [EP].[Total Previous Pregnancies] -- [Pregnancy Total Previous Pregnancies]
	--
	-- /* GP Registration */
	,[GP_Code_Original_Data] = [EP].[GP Code (Original Data)] -- [General Medical Practitioner (Specified)]
	,[GP_Practice_Code_Original_Data] = [EP].[GP Practice Code (Original Data)] -- [General Medical Practice Code (Patient Registration)]
	--
	-- /* Pregnancy - Activity Characteristics */
	,[Number_Of_Babies] = [EP].[Number Of Babies] -- [Number Of Babies Indication Code]
	--
	-- /* Antenatal Care - Activity Characteristics */
	,[First_Antenatal_Assessment_Date] = [EP].[First Antenatal Assessment Date]
	--
	-- /* Antenatal Care - Person Group (Responsible Clinician) */
	,[GP_Code_Mother] = [EP].[GP Code (Mother)] -- [General Medical Practitioner (Antenatal Care)]
	,[Organisation_Code_GP_Mother] = [EP].[Organisation Code GP (Mother)] -- [General Medical Practitioner Practice (Antenatal Care)]
	--,[EP].[Antenatal Consultant Code]
	--,[EP].[Antenatal Consultant Organisation Code]
	--
	-- /* Antenatal Care - Location Group - Delivery Place Intended */
	,[Location_Class_Of_Delivery_Place_Intended] = [EP].[Location Class Of Delivery Place (Intended)] -- [Location Class]
	,[Location_Type_Code] = [EP].[Location Type Code] -- [Activity Location Type Code]
	,[Delivery_Place_Change_Reason] = [EP].[Delivery Place Change Reason] -- [Delivery Place Change Reason Code]
	,[Delivery_Place_Type_Intended] = [EP].[Delivery Place Type Intended] -- [Delivery Place Type Code (Intended)]
	--
	-- /* Labour/Delivery - Activity Characteristics */
	,[Anaesthetic_During_Labour] = [EP].[Anaesthetic During Labour] -- [Anaesthetic Given During Labour Or Delivery Code]
	,[Anaesthetic_Post_Labour] = [EP].[Anaesthetic Post Labour] -- [Anaesthetic Given Post Labour Or Delivery Code]
	,[Gestation_Length] = [EP].[Gestation Length] -- [Gestation Length (Labour Onset)]
	,[Onset_Method] = [EP].[Onset Method] -- [Labour Or Delivery Onset Method Code]
	,[Delivery_Date] = [EP].[Delivery Date]
	,[Age_At_CDS_Activity_Date] = [EP].[Age At CDS Activity Date]
	,[OSV_Status_Classification_At_CDS_Activity_Date] = [CDS62_EP].[OSV Status Classification At CDS Activity Date]
	--
	-- /* Labour/Delivery Service Agreement Details */
	,[Commissioner_Serial_No_Agreement_No] = [EP].[Commissioner Serial No (Agreement No)] --  [Commissioning Serial Number]
	,[NHS_Service_Agreement_Line_No] = [EP].[NHS Service Agreement Line No] -- [NHS Service Agreement Line Number]
	,[Provider_Reference_No] = [EP].[Provider Reference No] -- [Provider Reference Number]
	,[Commissioner_Reference_No] = [EP].[Commissioner Reference No] -- [Commissioner Reference Number]
	,[Organisation_Code_Code_Of_Provider] = [EP].[Organisation Code (Code Of Provider)]
	,[Organisation_Code_Code_Of_Commissioner] = [EP].[Organisation Code (Code Of Commissioner)]
	--
	-- /* Birth Occurrence - One For Each Baby In The Delivery */
	,[Birth_Order] = [EP].[Birth Order]
	,[Delivery_Method] = [EP].[Delivery Method] -- [Delivery Method Code]
	,[Gestation_Length_Assessment] = [EP].[Gestation Length Assessment] -- [Gestation Length (Assessment)]
	,[Resuscitation_Method] = [EP].[Resuscitation Method] -- [Resuscitation Method Code]
	,[Status_Of_Person_Conducting_Delivery] = [EP].[Status Of Person Conducting Delivery] -- [Status Of Person Conducting Delivery Code]
	,[Local_Patient_Identifier_Baby] = [EP].[Local Patient Identifier (Baby)]
	,[Org_Code_Local_Patient_Identifier_Baby] = [EP].[Org Code Local Patient Identifier (Baby)] -- [Organisation Code (Local Patient Identifier (Baby))]
	,[NHS_Number_Baby] = [EP].[NHS Number (Baby)]
	,[NHS_Number_Status_Ind_Baby] = [EP].[NHS Number Status Ind (Baby)] -- [NHS Number Status Indicator Code (Baby)]
	,[Date_Of_Birth_Baby] = [EP].[Date Of Birth (Baby)] -- [Person Birth Date (Baby)]
	--
	-- /* Birth Occurrence - Person Characteristics - Baby */
	,[Sex_Baby] = [EP].[Sex (Baby)] -- [Person Gender Code Current (Baby)]
	,[Live_Or_Still_Birth] = [EP].[Live Or Still Birth] -- [Live Or Still Birth Code]
	,[Birth_Weight] = [EP].[Birth Weight]
	--,[Overseas Visitor Status Classification At CDS Activity Date]
	--
	-- /* Birth Occurrence - Location Group - Delivery Place Actual */
	,[Location_Class_Of_Delivery_Place_Actual] = [EP].[Location Class Of Delivery Place (Actual)] -- [Location Class]
	,[Location_Type_Of_Delivery_Place_Actual] = [EP].[Location Type Of Delivery Place (Actual)] --[Activity Location Type Code]
	,[Delivery_Place_Type_Actual] = [EP].[Delivery Place Type Actual] -- [Delivery Place Type Code (Actual)]
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
INNER JOIN [Casted].[IP_pbr_preprocess_CDS62_EP] AS [CDS62_EP]
	ON ([EP].[Generated Record ID] = [CDS62_EP].[Generated Record ID])
INNER JOIN [Casted].[IP_pbr_preprocess_EP_Pseudo] AS [EP_Pseudo]
	ON ([EP].[Generated Record ID] = [EP_Pseudo].[Generated Record ID])
WHERE [EP].[CDS Record Type] = '160';
