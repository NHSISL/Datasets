# EMIS source specification (version 8.0)

- [EMIS source specification (version 8.0)](#emis-source-specification-(version-8.0))
  - [Changes from previous version](#changes-from-previous-version)
    - [Version 5.2 - 5.5](#version-5.2---5.5)
    - [Version 6.0](#version-6.0)
    - [Version 7.0](#version-7.0)
    - [Version 8.0](#version-8.0)
  - [Table inventory](#table-inventory)
  - [Table schema](#table-schema)
    - [Admin\_Location](#admin_location)


## Changes from previous version

### Version 5.2 - 5.5

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

### Version 6.0

| Date | Description | Version |
| --- | --- | --- |
| 26/03/2020 | Added value for ""example data"" column for CareRecord_Observation  - AssociatedText CareRecord_problem – Comment | 6 |

### Version 7.0

| Date | Description | Version |
| --- | --- | --- |
| 28/08/2020 | <span>Updated previous_location mapping for the below columns in:<br>CareRecord_ObservationReferral --<br>ReferralReceivedDate*<br>ReferralReceivedTime*<br>ReferralEndDate*<br>ReferralSourceId*<br>ReferralSourceOrganisationGuid*<br>ReferralReasonCodeId*<br>ReferringCareProfessionalStaffGroupCodeId*<br>ReferralEpisodeRTTMeasurementTypeId*<br>ReferralEpisodeClosureDate*<br>ReferralEpisodeDischargeLetterIssuedDate*<br>ReferralClosureReasonCodeId*<br>Coding_ClinicalCode --<br>CodeId<br>Term<br>ReadTermId<br>SnomedCTConceptId<br>SnomedCTDescriptionId<br>EmisCodeCategoryDescription<br>ParentCodeID<br>Updated excel cell format of ""example data"" column in<br>CareRecord_Diary -- CareRecord.Diary.AssociatedText<br>CareRecord_Observation -- CareRecord.Observation.AssociatedText<br>CareRecord_Problem -- CareRecord.Diary.Comment</span> | 7 |
| 16/04/2021 | Removed: CareRecord_Diary.. AssociatedText, CareRecord_Observation.AssociatedText, CareRecord_Problem.Comment fields removed - undergoing Information Governance review | 7.1 |

### Version 8.0

| Date | Description | Version |
| --- | --- | --- |
| 05/04/2023 | - New table Admin_PatientHistory<br>- Added RegistrationNumber to Admin_UserInRole.<br>- Added ContactComments to Admin_Patient. <br>- Added BookedDate, BookedTime and SlotType to Appointment_Slot.<br>- ConsultationType added to CareRecord_Consultation.  <br>- Qualifiers, Abnormal, AbnormalReason and Episodicity added to CareRecord_Observation<br>- TransportRequired, ReferralTargetClinician and ReferralTargetDepartment added to CareRecord_ObservationReferral<br>- BNFChapterRef added to Coding_DrugCode<br>- EmisCode, PatientMessage, ScriptPharmacyStamp, Compliance, AverageCompliance, IsPrescribedAsContraceptive, IsPrivatelyPrescribed, PharmacyMessage, PharmacyText, ConsultationGuid added to Prescribing_IssueRecord<br>- Added: CareRecord_Diary.AssociatedText, CareRecord_Observation.AssociatedText, CareRecord_Problem.Comment fields | 8 |"


## Table inventory

| Name |	Description |
| --- | --- |
| `Admin_Location` | Location details |
| `Admin_Organisation` | Organisation details and codes |
| `Admin_OrganisationLocation` | Links locations to an organisation |
| `Admin_Patient` | Demographic information relating to a patient such as name, date of birth, gender, primary address |
| `admin_PatientHistory` | History of the patient registration |
| `Admin_UserInRole` | Contains individuals that perform a role in clinical care and their details both internal and external to the patient’s registered organisation, e.g. doctor, nurse, hospital consultant |
| `Agreements_SharingOrganisation` | Lists all sharing organisations for the current agreement |
| `Appointment_Session` | All appointment session information |
| `Appointment_SessionUser` | All users associated to appointment sessions |
| `Appointment_Slot` | All patient appointments which have taken place |
| `Audit_PatientAudit` | All clinical update/deletes for a patient |
| `Audit_RegistrationAudit` | All demographic/registration update/deletes for a patient |
| `CareRecord_Consultation` | All consultations that take place within an organisation, or quick notes entered in a Community organisation  |
| `CareRecord_Diary` | All diary entries |
| `CareRecord_Observation` | All clinically coded observations including referrals, values and problems |
| `CareRecord_ObservationReferral` | All referral observations (extends CareRecord_Observation) |
| `CareRecord_Problem` | All clinical problems |
| `Coding_ClinicalCodes` | All clinical codes |
| `Coding_DrugCodes` | All drug codes |
| `Prescribing_DrugRecord` | All records of the current authorisation of a drug |
| `Prescribing_IssueRecord` | All drugs which have been issued to patients by the appropriate clinician |

## Table schema

### Admin_Location

| Column Name | Description | Example Data | Previous Location | Data Type | Max length | Is Nullable |
| --- | --- | --- | --- | --- | --- | --- |
| `LocationGuid` | Unique ID | {1858F0D1-7474-4537-8EFE-AD7697E421C3} | dbo.Location.GUID | uniqueidentifier | 38 | 0 |
| `LocationName` | Location name | The Hotton Surgery | dbo.Location.LocationName | varchar | 100 | 0 |
| `LocationTypeDescription` | Type of location | Main Surgery | dbo.LocationType.LocationTypeDescription | varchar | 50 | 0 |
| `ParentLocationGuid` | Parent location | {892243B2-8947-4371-B92F-7143A5A038AB} | dbo.Location.ParentLocationId | uniqueidentifier | 38 | 1 |
| `OpenDate` | Open Date | 2007-11-02 | dbo.Location.OpenDate | date | 3 | 0 |
| `CloseDate` | Close Date | 2007-11-02 | dbo.Location.CloseDate | date | 3 | 1 |
| `MainContactName` | Main contact name | Mrs B Smith | dbo.Location.MainContactName | varchar | 200 | 1 |
| `FaxNumber` | Fax number | 01132555888 | dbo.Location.FaxNumber | varchar | 100 | 1 |
| `EmailAddress` | Email adress | thesurgery@nhs.co.uk | dbo.Location.EmailAddress | varchar | 100 | 1 |
| `PhoneNumber` | Phone number | 01132555887 | dbo.Location.PhoneNumber | varchar | 100 | 1 |
| `HouseNameFlatNumber` | Address name/flat number | 2A | dbo.Address.HouseNameFlatNumber | varchar | 50 | 1 |
| `NumberAndStreet` | Address street | 27 Zak Lane | dbo.Address.NumberAndStreet | varchar | 50 | 1 |
| `Village` | Address village | Hotton | dbo.Address.Village | varchar | 50 | 1 |
| `Town` | Address town | Leeds | dbo.Address.Town | varchar | 50 | 1 |
| `County` | Address county | West Yorkshire | dbo.Address.Country | varchar | 50 | 1 |
| `Postcode` | Type of organisation | LS21 5MU | dbo.Address.PostCode | varchar | 7 | 1 |
| `Deleted` | Indicates whether the location has been deleted | False | dbo.Location.Deleted | boolean | 1 | 0 |
| `ProcessingId` | Sequentual identifier indicating the order to process the items | 1 | N/A | int | 4 | 0 |
