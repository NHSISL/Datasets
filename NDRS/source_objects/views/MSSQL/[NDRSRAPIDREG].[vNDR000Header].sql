USE [LondonISL_National]
GO

/****** Object:  View [NDRSRAPIDREG].[vNDR000Header]    Script Date: 14/10/2025 10:43:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [NDRSRAPIDREG].[vNDR000Header] AS


select R.Version,
       R.OrgID_Submit,
       R.Received_Date,
       R.Snapshot,
       R.UniqSubmissionId,
       R.File_Type,
       R.ReportingPeriodStartDate,
       R.ReportingPeriodEndDate,
       R.Unique_MonthId,
       R.Total_ndr001,
       R.TotalRecords,
       R.dmicImportLogId,
       R.dmicSystemId,
       R.NDR000_Id,
       R.dmicDateAdded
	  
from [NDRSRAPIDREG].NDR000Header R
where  r.UniqSubmissionId = (select max(UniqSubmissionId) from [NDRSRAPIDREG].ActiveSubmission X) 

	
GO


