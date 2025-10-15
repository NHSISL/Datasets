USE [LondonISL_National]
GO

/****** Object:  View [NDRSRAPIDREG].[vNDR001RapidRegistration]    Script Date: 14/10/2025 10:44:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   VIEW [NDRSRAPIDREG].[vNDR001RapidRegistration] AS


SELECT 
	   r.SK,
       r.Snapshot,
       r.INDIVIDUAL_ID,
       r.PATIENT_ID,
       r.[NHS_NUMBER Pseudo],
       r.TUMOUR_AVP_ID,
       r.DIAGNOSISDATE,
       r.TUMOUR_SITE,
       r.CANCER_GROUP,
       r.GENDER,
       r.AGE,
       r.STAGE,
       r.ETHNICCATEGORY,
       r.FINAL_ROUTE,
       r.IMD_QUINTILE,
       r.IMD_YEAR,
       r.CHRL_TOT_27_03,
       r.TUMOUR_MORPHOLOGY,
       r.TUMOUR_PERFORMANCESTATUS,
       r.BASISOFDIAGNOSIS,
       r.CCG_CODE,
       r.CCG_NAME,
       r.TRUST_CODE,
       r.STP_CODE,
       r.STP_NAME,
       r.CANALLIANCE_CODE,
       r.CANALLIANCE_NAME,
       r.NHS_REGION_CODE,
       r.NHS_REGION_NAME,
       r.ENG_LOC_CODE,
       r.ENG_LOC_NAME,
       r.ICB_CODE,
       r.ICB_NAME,
       r.GEOG_BOUNDARY_YEAR,
       r.SOURCE,
       r.dmicImportLogId,
       r.NDR001_ID,
       r.UniqSubmissionId,
       r.Unique_MonthId,
       r.dmicSystemId,
       r.dmicDateAdded,
       r.dmPracticeCode,
       r.dmIcbOfRegistration,
       r.dmSubIcbOfRegistration,
       r.dmCCGCode,
       r.dmSTPCode,
       r.dmCanAllianceCode,
       r.dmICBCode,
       r.dmIcbCommissioner,
       r.dmSubIcbCommissioner,
       r.dmIcbResidenceSubmitted,
       r.dmSubIcbResidenceSubmitted,
       r.dmCommissionerDerivationReason,
       r.dmicRecordHash

FROM [NDRSRAPIDREG].NDR001RapidRegistration R
WHERE  r.UniqSubmissionId = (SELECT MAX(UniqSubmissionId) FROM [NDRSRAPIDREG].ActiveSubmission X) 

	
GO


