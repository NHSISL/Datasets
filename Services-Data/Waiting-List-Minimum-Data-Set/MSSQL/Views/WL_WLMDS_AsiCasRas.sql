CREATE VIEW [Final].[WL_WLMDS_AsiCasRas]
AS
( 
	SELECT
	  D.[DATE_AND_TIME_DATA_SET_CREATED]
      ,D.[Week_Ending_Date]
      ,D.[REFERRAL_REQUEST_RECEIVED_DATE]
      ,D.[Referral_Identifier]
      ,D.[ORGANISATION_IDENTIFIER_CODE_OF_PROVIDER]
      ,D.[ACTIVITY_TREATMENT_FUNCTION_CODE]
      ,S.[derProviderCode]
      ,S.[derSubmissionDateTimeFromDLP]
      ,S.[derWeekEnding]
      ,S.[derFileName]
      ,D.[derSubmissionId]
      ,D.[derRowId]
      ,D.[Pseudo NHS_NUMBER]
	  ,D.[ORGANISATION_IDENTIFIER_CODE_OF_COMMISSIONER]
	  ,D.[Last_PAS_Validation_Date]
	  ,D.[derCCGofPractice]
	  ,D.[derCCGofResidence]
	  ,D.[derPracticeCode]
	  ,D.[derLSOA]
	  ,D.[derLSOA2021]
	FROM [Final].[WL_AsiCasRas_Data] D 
    INNER JOIN [Final].[WL_SubmissionLog_Data] S 
        ON S.derSubmissionID = D.derSubmissionId
	WHERE S.derIsLatestFiletypeProviderWeekending = 1
	);
