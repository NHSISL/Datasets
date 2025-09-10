CREATE VIEW [StarMart].[OP_Encounter]
AS
SELECT [Generated_Record_ID] = [OP].[Generated Record ID]
	,[SK_Encounter_ID] = [OP].[Generated Record ID]
	,[SUS_Version] = [OP].[SUS Version]
	--
	,[dv_RowID] = TRY_CAST(CONCAT (
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
			,[OP].[Generated Record ID]
			) AS VARCHAR(35))
	--
	,[dv_Activity_Date] = [OP].[ActivityDate]
	,[dv_Activity_Period] = [OP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[OP_pbr_preprocess_OP] AS [OP];
