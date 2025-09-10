CREATE VIEW [StarMart].[AE_Encounter]
AS
SELECT [Generated_Record_ID] = [EM].[Generated Record ID]
	,[SK_Encounter_ID] = [EM].[Generated Record ID]
	,[SUS_Version] = [EM].[SUS Version]
	--
	,[dv_Row_ID] = TRY_CAST(CONCAT (
			CASE '$(SUSDataMartID)' /*[SK_SUSDataMartID]*/
				WHEN 10 -- Sollis Rec/PostRec
					THEN '<PM>'
				WHEN 11 -- Sollis DateRange
					THEN '<DR>'
				WHEN 12 -- PGISUS Rec/PostRec
					THEN '<RP>'
				WHEN 13 -- PGISUS DateRange
					THEN '<SD>'
				END
			,[EM].[Generated Record ID]
			) AS VARCHAR(35))
	--
	,[dv_Activity_Date] = [EM].[ActivityDate]
	,[dv_Activity_Period] = [EM].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_EM] AS [EM];
