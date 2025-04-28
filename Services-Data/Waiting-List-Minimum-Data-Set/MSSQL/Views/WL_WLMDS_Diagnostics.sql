CREATE VIEW [Final].[WL_WLMDS_Diagnostics]
AS
( 
	SELECT
	D.[DATE_AND_TIME_DATA_SET_CREATED],
	D.[Week_Ending_Date],
	D.[Waiting_List_Type],
	D.[Pseudo NHS_NUMBER],
	D.[LOCAL_PATIENT_IDENTIFIER],
	D.[PERSON_STATED_GENDER_CODE],
	D.[ETHNIC_CATEGORY],
	D.[Referral_Identifier],
	D.[PATIENT_PATHWAY_IDENTIFIER],
	D.[ORGANISATION_CODE_PATIENT_PATHWAY_IDENTIFIER_ISSUER],
	D.[ORGANISATION_IDENTIFIER_CODE_OF_PROVIDER],
	D.[ORGANISATION_SITE_IDENTIFIER_OF_TREATMENT],
	D.[ORGANISATION_IDENTIFIER_CODE_OF_COMMISSIONER],
	D.[CONSULTANT_CODE],
	D.[REFERRAL_TO_TREATMENT_PERIOD_START_DATE],
	D.[REFERRAL_TO_TREATMENT_PERIOD_END_DATE],
	D.[Diagnostic_Clock_Start_Date],
	D.[Diagnostic_Modality],
	D.[Planned_Diagnostic_Due_Date],
	D.[Proposed_Procedure_OPCS_Code],
	D.[PRIORITY_TYPE_CODE],
	D.[Diagnostic_Priority_Code],
	D.[Inclusion_On_Cancer_PTL],
	D.[derSubmissionId],
	D.[derRowId],
	S.[derProviderCode],
	S.[derSubmissionDateTimeFromDLP],
	S.[derWeekEnding],
	S.[derFileName],
	D.[Der_Age_WeekEndingDate],
	D.[Der_Age_at_Referral_To_Treatment_Period_Start_Date],
	D.[Der_AgeBand_WeekEndingDate],
	D.[Der_AgeBand_at_Referral_To_Treatment_Period_Start_Date],
	D.[derCCGofPractice],
	D.[derCCGofResidence],
	D.[derPracticeCode],
	D.[derLSOA],
	D.[dmIcbCommissioner],
	D.[dmSubIcbCommissioner],
	D.[derLSOA2021]
	FROM [Final].[WL_Diagnostics_Data] D
    INNER JOIN [Final].[WL_SubmissionLog_Data] S 
        ON S.derSubmissionID = D.derSubmissionId
	WHERE S.derIsLatestFiletypeProviderWeekending = 1
	);
