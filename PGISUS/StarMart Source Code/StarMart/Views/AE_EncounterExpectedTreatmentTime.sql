CREATE VIEW [StarMart].[AE_EncounterExpectedTreatmentTime]
AS
SELECT [Generated_Record_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	,[SK_Encounter_ID] = [CDS621_SUPP_EC].[Generated Record ID]
	--
	,[Sequence_Number] = [CDS621_SUPP_EC].[Sequence Number]
	,[Expected_Date_And_Time_Of_Treatment] = TRY_CONVERT(DATETIME2(0), [CDS621_SUPP_EC].[Code], 120)
	,[Emergency_Care_Slot_Allocation_Timestamp] = [CDS621_SUPP_EC].[Emergency Care Slot Allocation Timestamp]
	,[dv_Is_First] = TRY_CONVERT(BIT, CASE 
			WHEN ROW_NUMBER() OVER (
					PARTITION BY [CDS621_SUPP_EC].[Generated Record ID] ORDER BY [CDS621_SUPP_EC].[Emergency Care Slot Allocation Timestamp] ASC
					) = 1
				THEN 1
			ELSE 0
			END)
	,[dv_Is_Last] = TRY_CONVERT(BIT, CASE 
			WHEN ROW_NUMBER() OVER (
					PARTITION BY [CDS621_SUPP_EC].[Generated Record ID] ORDER BY [CDS621_SUPP_EC].[Emergency Care Slot Allocation Timestamp] DESC
					) = 1
				THEN 1
			ELSE 0
			END)
	--
	,[dv_Activity_Date] = [CDS621_SUPP_EC].[ActivityDate]
	,[dv_Activity_Period] = [CDS621_SUPP_EC].[ActivityPeriod]
	,[dv_ISL_Datetime_Published] = GETDATE()
FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
WHERE [CDS621_SUPP_EC].[Repeating Group] = 'EXPECTED DATE AND TIME OF TREATMENT';
	--AND [CDS621_SUPP_EC].[Code] IS NOT NULL; --Maybe worth considering including
