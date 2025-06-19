# EMIS dataset schema change history

The following change history is provided as reported by EMIS.

## Contents

- [EMIS dataset schema change history](#emis-dataset-schema-change-history)
  - [Contents](#contents)
  - [Version 5.2 - 5.5](#version-5.2---5.5)
  - [Version 6.0](#version-6.0)
  - [Version 7.0 - 7.1](#version-7.0---7.1)
  - [Version 8.0 - 8.2](#version-8.0---8.2)

## Version 5.2 - 5.5

| Date | Description | Version |
| --- | --- | --- |
| 25/04/2016 | Admin_Patient_PersonGUID amended to Admin_Patient_PersonGuid   | 5.2 |
| 25/04/2016 | Added column CareRecord_Problem_Deleted | 5.2 |
| 22/09/2016 | Amended Admin_OrganisationLocation_IsMainLocation data type to boolean | 5.3 |
| 22/09/2016 | Amended Admin_OrganisationLocation_IsMainLocation max length to 5 | 5.3 |
| 22/09/2016 | Amended Admin_OrganisationLocation_Deleted data type to boolean | 5.3 |
| 22/09/2016 | Amended Admin_OrganisationLocation_Deleted max length to 5 | 5.3 |
| 22/09/2016 | Removal of AgreementGuid from all files | 5.3 |
| 22/09/2016 | Amended CareRecord_Problem_Deleted data type to boolean | 5.3 |
| 26/09/2016 | Added column Coding_ClinicalCode_ParentCodeId | 5.4 |
| 25/04/2017 | Updated excel cell format of "example data" column to "date" for Admin_Patient_DateOfDeactivation  | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "date" for Admin_Patient_DateOfDeath  | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "time" for Carerecord_Observation_EnteredTime | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "time" for CareRecord_ObservationReferral_ReferralReceivedTime | 5.5 |
| 25/04/2017 | Added a value for "example data" column for CareRecord_Problem_ExpectedDuration | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "number" for CareRecord_Problem_ProcessingId | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "number" for CareRecord_ObservationReferral_ProcessingId | 5.5 |
| 25/04/2017 | Added values for ""example data"" for following columns in Admin_Patient: <br> - MiddleNames<br> - HouseNameFlatNumber<br> - ResidentialInstituteCode<br> - CarerName<br> - CarerRelation | 5.5 |
| 25/04/2017 | Added value for "example data" column for CareRecord_Diary_EffectiveDatePrecision | 5.5 |
| 25/04/2017 | Added value for "example data" column for CareRecord_Observation_EffectiveDatePrecision | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column to "decimal" for CareRecord_Observation_NumericRangeLow and CareRecord_Observation_NumericRangeHigh | 5.5 |
| 25/04/2017 | Added value for "example data" column for CareRecord_ObservationReferral_ReferralServiceType | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column  for CareRecord_Problem_Deleted | 5.5 |
| 25/04/2017 | Updated excel cell format of "example data" column for all tables. | 5.5 |

## Version 6.0

| Date | Description | Version |
| --- | --- | --- |
| 26/03/2020 | Added value for ""example data"" column for CareRecord_Observation  - AssociatedText CareRecord_problem – Comment | 6 |

## Version 7.0 - 7.1

| Date | Description | Version |
| --- | --- | --- |
| 28/08/2020 | <span>Updated previous_location mapping for the below columns in:<br>CareRecord_ObservationReferral --<br>ReferralReceivedDate*<br>ReferralReceivedTime*<br>ReferralEndDate*<br>ReferralSourceId*<br>ReferralSourceOrganisationGuid*<br>ReferralReasonCodeId*<br>ReferringCareProfessionalStaffGroupCodeId*<br>ReferralEpisodeRTTMeasurementTypeId*<br>ReferralEpisodeClosureDate*<br>ReferralEpisodeDischargeLetterIssuedDate*<br>ReferralClosureReasonCodeId*<br>Coding_ClinicalCode --<br>CodeId<br>Term<br>ReadTermId<br>SnomedCTConceptId<br>SnomedCTDescriptionId<br>EmisCodeCategoryDescription<br>ParentCodeID<br>Updated excel cell format of ""example data"" column in<br>CareRecord_Diary -- CareRecord.Diary.AssociatedText<br>CareRecord_Observation -- CareRecord.Observation.AssociatedText<br>CareRecord_Problem -- CareRecord.Diary.Comment</span> | 7 |
| 16/04/2021 | Removed: CareRecord_Diary.. AssociatedText, CareRecord_Observation.AssociatedText, CareRecord_Problem.Comment fields removed - undergoing Information Governance review | 7.1 |

## Version 8.0 - 8.2

| Date | Description | Version |
| --- | --- | --- |
| 05/04/2023 | - New table Admin_PatientHistory<br>- Added RegistrationNumber to Admin_UserInRole.<br>- Added ContactComments to Admin_Patient. <br>- Added BookedDate, BookedTime and SlotType to Appointment_Slot.<br>- ConsultationType added to CareRecord_Consultation.  <br>- Qualifiers, Abnormal, AbnormalReason and Episodicity added to CareRecord_Observation<br>- TransportRequired, ReferralTargetClinician and ReferralTargetDepartment added to CareRecord_ObservationReferral<br>- BNFChapterRef added to Coding_DrugCode<br>- EmisCode, PatientMessage, ScriptPharmacyStamp, Compliance, AverageCompliance, IsPrescribedAsContraceptive, IsPrivatelyPrescribed, PharmacyMessage, PharmacyText, ConsultationGuid added to Prescribing_IssueRecord<br>- Added: CareRecord_Diary.AssociatedText, CareRecord_Observation.AssociatedText, CareRecord_Problem.Comment fields | 8 |
|24/04/2024	| • Coding_DrugCode table - BNFChapterRef discontinued and replaced with NULL values<br>• ExpiryDate field discontinued in Issue_Record table and replaced with NULL values<br>• ExpiryDate field added to Drug_Record table | 8.1 |
| 13/02/2025 | • Added columns to the appointment slot table:  Isblocked, NationalSlotCategoryName, ContextType, ServiceSetting.<br>• Added issuemethodDescription to issue record table.	| 8.2 |
