USE [LondonISL_National]
GO

/****** Object:  View [NDRSCANREG].[vNDR000Header]    Script Date: 14/10/2025 10:21:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   VIEW [NDRSCANREG].[vNDR000Header] AS


SELECT T.Version,
       T.OrgID_Submit,
       T.Received_Date,
       T.Snapshot,
       T.UniqSubmissionId,
       T.File_Type,
       T.ReportingPeriodStartDate,
       T.ReportingPeriodEndDate,
       T.Unique_MonthId,
       T.Total_ndr001,
       T.TotalRecords,
       T.dmicImportLogId,
       T.dmicSystemId,
       T.NDR000_Id,
       T.dmicDateAdded
 
FROM [NDRSCANREG].NDR000Header T
WHERE  t.UniqSubmissionId = (SELECT MAX(UniqSubmissionId) FROM [NDRSCANREG].ActiveSubmission X) 

	
GO


