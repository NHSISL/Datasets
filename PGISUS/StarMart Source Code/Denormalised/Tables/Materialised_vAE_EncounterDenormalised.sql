CREATE TABLE [Denormalised].[Materialised_vAE_EncounterDenormalised] (
	[SK_EncounterID] BIGINT NOT NULL
	,[dv_Extract_Type] VARCHAR(200) NULL
	,[dv_Query_ID] VARCHAR(7) NULL
	,[dv_FinYear] VARCHAR(30) NULL
	,[dv_FinMonth] TINYINT NULL
	,[dv_Activity_Period_Date] INT NULL
	,[CDS_Record_Type] VARCHAR(3) NULL
	,[Generated_Record_ID] BIGINT NULL
	,[Spell_Identifier] BIGINT NULL
	,[Unique_CDS_Identifier] VARCHAR(35) NULL
	,[EM_Attendance_Number] VARCHAR(12) NULL
	,[Arrival_Date] DATE NULL
	,[Arrival_Time] TIME(0) NULL
	,[EM_Referral_Source] VARCHAR(2) NULL
	,[EM_Mode_Of_Arrival] VARCHAR(1) NULL
	,[EM_Department_Type] VARCHAR(2) NULL
	,[EM_Attendance_Category] VARCHAR(1) NULL
	,[EM_Incident_Location_Type] VARCHAR(2) NULL
	,[EM_Patient_Group] VARCHAR(2) NULL
	,[EM_Staff_Member_Code] VARCHAR(3) NULL
	,[EM_Initial_Assessment_Date] DATE NULL
	,[EM_Initial_Assessment_Time] TIME(0) NULL
	,[EM_Time_Seen_For_Treatment] TIME(0) NULL
	,[EM_Date_Seen_For_Treatment] DATE NULL
	,[EM_Attendance_Conclusion_Date] DATE NULL
	,[EM_Attendance_Conclusion_Time] TIME(0) NULL
	,[EM_Attendance_Disposal] VARCHAR(2) NULL
	,[EM_Departure_Date] DATE NULL
	,[EM_Departure_Time] TIME(0) NULL
	,[dv_EM_Conclusion_Waiting_Time] INT NULL
	,[dv_EM_Duration_Time] INT NULL
	,[dv_EM_Treatment_Wait_Time] INT NULL
	,[Number_Diagnosis] INT NULL
	,[Number_Procedures] INT NULL
	,[Number_EM_Investigations] INT NULL
	,[Number_EM_Treatments] INT NULL
	,[SK_PatientID] INT NULL
	,[Local_Patient_Identifier] VARCHAR(10) NULL
	,[Carer_Support_Indicator] VARCHAR(2) NULL
	,[Ethnic_Category_Code] VARCHAR(2) NULL
	,[Age_At_CDS_Activity_Date] SMALLINT NULL
	,[Gender_Code] CHAR(1) NULL
	,[Postcode_Of_Usual_Address] VARCHAR(8) NULL
	,[dv_LSOA] VARCHAR(9) NULL
	,[Registered_GMP_Code_Original_Data] VARCHAR(8) NULL
	,[GP_Practice_Code] VARCHAR(12) NULL
	,[GP_Practice_Code_Original_Data] VARCHAR(12) NULL
	,[Provider_Reference_No] VARCHAR(17) NULL
	,[Commissioner_Reference_No] VARCHAR(17) NULL
	,[Commissioning_Serial_No_Agreement_No] VARCHAR(6) NULL
	,[NHS_Service_Agreement_Line_No] VARCHAR(10) NULL
	,[Organisation_Code_Code_Of_Provider] VARCHAR(12) NULL
	,[Provider_Site_Code] VARCHAR(12) NULL
	,[Organisation_Code_Code_Of_Commissioner] VARCHAR(12) NULL
	,[Organisation_Code_PCT_Of_Residence] VARCHAR(12) NULL
	,[PCT_Derived_From_GP_Practice] VARCHAR(12) NULL
	,[Patient_Postcode_Derived_PCT] VARCHAR(12) NULL
	,[PCT_Of_Residence_Original] VARCHAR(12) NULL
	,[PCT_Responsible] VARCHAR(12) NULL
	,[dv_Commissioner_Code_Of_Residence] INT NULL
	,[dv_Purchaser_ID] VARCHAR(15) NULL
	,[Core_HRG] VARCHAR(5) NULL
	,[dv_HRG] VARCHAR(5) NULL
	,[dv_Local_Cost_Code] VARCHAR(30) NULL
	,[dv_IsPBR] BIT NULL
	,[dv_Base_Cost] MONEY NULL
	,[dv_MFF_Index_Applied] REAL NULL
	,[Tariff_Initial_Amount_National] DECIMAL(9, 2) NULL
	,[Tariff_Pre_MFF_Adjusted_National] DECIMAL(9, 2) NULL
	,[Applied_MFF_National] DECIMAL(9, 2) NULL
	,[MFF_Adjustment] DECIMAL(9, 2) NULL
	,[Tariff_Total_Payment_National] DECIMAL(9, 2) NULL
	,[PBR_Final_Tariff] DECIMAL(9, 2) NULL
	,[dv_Total_Cost_Inc_MFF] MONEY NULL
	,[EM_Diagnosis_First] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_1] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_2] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_3] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_4] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_5] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_6] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_7] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_8] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_9] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_10] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_11] VARCHAR(7) NULL
	,[EM_Diagnosis_Second_12] VARCHAR(7) NULL
	,[EM_Investigation_First] VARCHAR(7) NULL
	,[EM_Investigation_Second_1] VARCHAR(7) NULL
	,[EM_Investigation_Second_2] VARCHAR(7) NULL
	,[EM_Investigation_Second_3] VARCHAR(7) NULL
	,[EM_Investigation_Second_4] VARCHAR(7) NULL
	,[EM_Investigation_Second_5] VARCHAR(7) NULL
	,[EM_Investigation_Second_6] VARCHAR(7) NULL
	,[EM_Investigation_Second_7] VARCHAR(7) NULL
	,[EM_Investigation_Second_8] VARCHAR(7) NULL
	,[EM_Investigation_Second_9] VARCHAR(7) NULL
	,[EM_Investigation_Second_10] VARCHAR(7) NULL
	,[EM_Investigation_Second_11] VARCHAR(7) NULL
	,[EM_Investigation_Second_12] VARCHAR(7) NULL
	,[EM_Treatment_First] VARCHAR(7) NULL
	,[EM_Treatment_Second_1] VARCHAR(7) NULL
	,[EM_Treatment_Second_2] VARCHAR(7) NULL
	,[EM_Treatment_Second_3] VARCHAR(7) NULL
	,[EM_Treatment_Second_4] VARCHAR(7) NULL
	,[EM_Treatment_Second_5] VARCHAR(7) NULL
	,[EM_Treatment_Second_6] VARCHAR(7) NULL
	,[EM_Treatment_Second_7] VARCHAR(7) NULL
	,[EM_Treatment_Second_8] VARCHAR(7) NULL
	,[EM_Treatment_Second_9] VARCHAR(7) NULL
	,[EM_Treatment_Second_10] VARCHAR(7) NULL
	,[EM_Treatment_Second_11] VARCHAR(7) NULL
	,[EM_Treatment_Second_12] VARCHAR(7) NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = HASH ([Organisation_Code_Code_Of_Commissioner])
			);
