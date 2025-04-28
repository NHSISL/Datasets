CREATE TABLE [Final].[WL_AsiCasRas_Data](
	[DATE_AND_TIME_DATA_SET_CREATED] [datetime2](0) NULL,
	[Week_Ending_Date] [date] NULL,
	[REFERRAL_REQUEST_RECEIVED_DATE] [date] NULL,
	[Referral_Identifier] [varchar](50) NULL,
	[ORGANISATION_IDENTIFIER_CODE_OF_PROVIDER] [varchar](6) NULL,
	[ACTIVITY_TREATMENT_FUNCTION_CODE] [varchar](3) NULL,
	[derSubmissionId] [int] NULL,
	[derRowId] [int] NOT NULL,
	[Pseudo NHS_NUMBER] [varchar](20) NULL,
	[ORGANISATION_IDENTIFIER_CODE_OF_COMMISSIONER] [varchar](5) NULL,
	[Last_PAS_Validation_Date] [date] NULL,
	[derCCGofPractice] [varchar](5) NULL,
	[derCCGofResidence] [varchar](5) NULL,
	[derPracticeCode] [varchar](6) NULL,
	[derLSOA] [varchar](9) NULL,
	[derLSOA2021] [varchar](9) NULL
);
