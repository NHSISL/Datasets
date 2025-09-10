CREATE TABLE [Casted].[AE_pbr_preprocess_CDS62_EM] (
	[SUS Version Number] VARCHAR(17) NULL
	,[Generated Record ID] BIGINT NULL
	,[Episode Number] TINYINT NULL
	,[Spell ID] BIGINT NULL
	,[Excluded Episode Spell ID] BIGINT NULL
	,[SHA Commissioner] VARCHAR(5) NULL
	,[SHA Provider] VARCHAR(5) NULL
	,[Spell Version As At Date And Time] VARCHAR(14) NULL
	,[CDS Record Type] VARCHAR(3) NULL
	,[Waiting Time Measurement Type] VARCHAR(2) NULL
	,[Withheld Identity Reason] VARCHAR(2) NULL
	,[Discharged To HaH Service Indicator] VARCHAR(1) NULL
	,[Start Time (Hospital Provider Spell)] TIME(0) NULL
	,[Discharge Time (Hospital Provider Spell)] TIME(0) NULL
	,[Start Time (Episode)] TIME(0) NULL
	,[End Time (Episode)] TIME(0) NULL
	,[Ambulance Incident Number] VARCHAR(20) NULL
	,[OSV Status Classification At CDS Activity Date] VARCHAR(1) NULL
	,[OSV Status Classification 1] VARCHAR(1) NULL
	,[OSV Status Start Date 1] DATE NULL
	,[OSV Status End Date 1] DATE NULL
	,[OSV Status Classification 2] VARCHAR(1) NULL
	,[OSV Status Start Date 2] DATE NULL
	,[OSV Status End Date 2] DATE NULL
	,[OSV Status Classification 3] VARCHAR(1) NULL
	,[OSV Status Start Date 3] DATE NULL
	,[OSV Status End Date 3] DATE NULL
	,[OSV Status Classification 4] VARCHAR(1) NULL
	,[OSV Status Start Date 4] DATE NULL
	,[OSV Status End Date 4] DATE NULL
	,[OSV Status Classification 5] VARCHAR(1) NULL
	,[OSV Status Start Date 5] DATE NULL
	,[OSV Status End Date 5] DATE NULL
	,[Multi-Professional Or Multi-Disciplinary Indication Code] TINYINT NULL
	,[Rehabilitation Assessment Team Type] TINYINT NULL
	,[Direct Access Referral Indicator] VARCHAR(1) NULL
	,[Activity Location Type Code] VARCHAR(3) NULL
	,[Local Sub Specialty Code] VARCHAR(8) NULL
	,[Consultation Medium Used] VARCHAR(2) NULL
	,[Earliest Clinically Appropriate Date] DATE NULL
	,[Appointment Time] TIME(0) NULL
	,[Expected Duration Of Appointment] VARCHAR(3) NULL
	,[Clinic Code] VARCHAR(12) NULL
	,[EM Site Code (Of Treatment)] VARCHAR(5) NULL
	,[EM Initial Assessment Date] DATE NULL
	,[EM Date Seen For Treatment] DATE NULL
	,[EM Attendance Conclusion Date] DATE NULL
	,[EM Departure Date] DATE NULL
	,[Organisation Code (Conveying Ambulance Trust)] VARCHAR(3) NULL
	,[CDS Schema Version] VARCHAR(8) NULL
	,[Earliest Reasonable Offer Date] DATE NULL
	,[Psychiatric Patient Status Code] VARCHAR(1) NULL
	,[Query Date] VARCHAR(14) NULL
	,[Unique Query Id] VARCHAR(34) NULL
	,[Id] BIGINT NOT NULL
	,[ImportRunDataFileId] INT NULL
	,[ActivityDate] DATE NOT NULL
	,[ActivityPeriod] INT NOT NULL
	)
	WITH (
			CLUSTERED COLUMNSTORE INDEX
			,DISTRIBUTION = ROUND_ROBIN
			);
