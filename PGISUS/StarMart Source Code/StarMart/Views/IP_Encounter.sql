CREATE VIEW [StarMart].[IP_Encounter]
AS
SELECT [Generated_Record_ID] = [EP].[Generated Record ID]
	,[SK_Encounter_ID] = [EP].[Generated Record ID]
	,[SUS_Version] = [EP].[SUS Version]
	,[Spell_Identifier] = [EP].[Spell Identifier]
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
			,[EP].[Generated Record ID]
			) AS VARCHAR(35))
	--
	,[dv_Activity_Date] = [EP].[ActivityDate]
	,[dv_Activity_Period] = [EP].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[IP_pbr_preprocess_EP] AS [EP]
