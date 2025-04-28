CREATE VIEW [Final].[WL_WLMDS_ClockStarts]
AS
( 
	SELECT
	  D.[DATE_AND_TIME_DATA_SET_CREATED]
      ,D.[Week_Ending_Date]
      ,D.[PATIENT_PATHWAY_IDENTIFIER]
      ,D.[ORGANISATION_CODE_PATIENT_PATHWAY_IDENTIFIER_ISSUER]
      ,D.[REFERRAL_TO_TREATMENT_PERIOD_START_DATE]
      ,D.[ORGANISATION_IDENTIFIER_CODE_OF_PROVIDER]
      ,D.[ORGANISATION_IDENTIFIER_CODE_OF_COMMISSIONER]
      ,D.[ACTIVITY_TREATMENT_FUNCTION_CODE]
      ,S.[derProviderCode]
      ,S.[derSubmissionDateTimeFromDLP]
      ,S.[derWeekEnding]
      ,S.[derFileName]
      ,D.[derSubmissionId]
      ,D.[derRowId]
      ,D.[dmIcbCommissioner]
      ,D.[dmSubIcbCommissioner]
      ,D.[Pseudo NHS_NUMBER]
      ,D.LOCAL_PATIENT_IDENTIFIER
	  ,D.[PRIORITY_TYPE_CODE]
	  ,D.[SOURCE_OF_REFERRAL]
	  ,D.[PERSON_STATED_GENDER_CODE]
	  ,D.[ETHNIC_CATEGORY]
	  ,D.[REFERRAL_TO_TREATMENT_PERIOD_STATUS]
	  ,D.[der_Age_WeekEndingDate]
	  ,D.[der_Age_at_Referral_To_Treatment_Period_Start_Date]
	  ,D.[der_AgeBand_WeekEndingDate]
	  ,D.[der_AgeBand_at_Referral_To_Treatment_Period_Start_Date]
	  ,D.[derCCGofPractice]
	  ,D.[derCCGofResidence]
	  ,D.[derPracticeCode]
	  ,D.[derLSOA]
	  ,D.[derLSOA2021]
	FROM [Final].[WL_ClockStarts_Data] D
    INNER JOIN [Final].[WL_SubmissionLog_Data] S ON S.derSubmissionID = D.derSubmissionId
	WHERE S.derIsLatestFiletypeProviderWeekending = 1
	);
