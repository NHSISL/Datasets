CREATE TABLE [Final].[WL_SubmissionLog_Data](
	[derSubmissionID] [int] NOT NULL,
	[derDLPSpecificationName] [varchar](256) NULL,
	[derFileName] [nvarchar](500) NULL,
	[derSubmissionDateTimeFromDLP] [datetime2](0) NULL,
	[derProviderCode] [varchar](10) NULL,
	[derWeekEnding] [date] NULL,
	[derIsLatestFiletypeProviderWeekending] [bit] NULL,
	[derIsLatestFiletypeProvider] [bit] NULL
);
