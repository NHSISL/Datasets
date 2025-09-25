CREATE VIEW [Casted].[AE_pbr_preprocess_SUPP_EC_Diagnosis_Pivot]
AS
SELECT [Generated Record ID]
	,[ECDS_diagnosis_code_01] = [PV].[1]
	,[ECDS_diagnosis_code_02] = [PV].[2]
	,[ECDS_diagnosis_code_03] = [PV].[3]
	,[ECDS_diagnosis_code_04] = [PV].[4]
	,[ECDS_diagnosis_code_05] = [PV].[5]
	,[ECDS_diagnosis_code_06] = [PV].[6]
	,[ECDS_diagnosis_code_07] = [PV].[7]
	,[ECDS_diagnosis_code_08] = [PV].[8]
	,[ECDS_diagnosis_code_09] = [PV].[9]
	,[ECDS_diagnosis_code_10] = [PV].[10]
	,[ECDS_diagnosis_code_11] = [PV].[11]
	,[ECDS_diagnosis_code_12] = [PV].[12]
FROM (
	SELECT [CDS621_SUPP_EC].[Generated Record ID]
		,[CDS621_SUPP_EC].[Sequence Number]
		,[CDS621_SUPP_EC].[Code]
	FROM [Casted].[AE_pbr_preprocess_CDS621_SUPP_EC] AS [CDS621_SUPP_EC]
	WHERE [CDS621_SUPP_EC].[Repeating Group] = 'EMERGENCY CARE DIAGNOSIS (SNOMED CT)'
		AND [CDS621_SUPP_EC].[Code] IS NOT NULL
	) [D]
PIVOT(MAX([Code]) FOR [Sequence Number] IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS [PV]
