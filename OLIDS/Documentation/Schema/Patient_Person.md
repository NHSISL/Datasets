# Patient_Person

- [Patient\_Person](#patient_person)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity Relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

> [!TIP]
> The `PATIENT_PERSON` object was originally designed to allow for independent incremental loading from synapse to snowflake, and reflected independent updates for patients and person source objects. With the replatforming work, it may be possible to address this independence in ways that do not require this table to continue.
> It has been reprovisioned for completeness, but may be withdrawn if found to add no value during UAT and discussions with users.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Masking policy |
| --- | --- | --- | --- | --- |
| `ID` | `UUID` | Business key for the patient-person link. Carries the patient's LDS_BUSINESS_ID (derived from PATIENTGUID and ORGANISATIONGUID) so that downstream consumers can join back to Patient. tests: - unique - not_null | PK | |
| `LDS_SOURCE_RECORD_ID` | `UUID` | Record-level identifier for the patient, inherited from Admin_Patient_Sequenced. Derived from PATIENTGUID, ORGANISATIONGUID, file row number, and file name. | | |
| `PATIENT_ID` | `UUID` | Foreign key to Patient. Equals the patient's LDS_BUSINESS_ID (same value as ID). | FK -> [Patient](Patient.md).ID | |
| `PERSON_ID` | `UUID` | Foreign key to Person. The ID of the matched person record from the INNER JOIN. | FK -> [Person](Person.md).ID | |
| `LDS_BUSINESS_ID_PERSON` | `UUID` | Business key of the linked person record. Derived via generate_person_business_id using the patient's NHS_NUMBER, LDS_BUSINESS_ID, and LDS_SOURCE_RECORD_ID - matching the logic used to generate ID in Person. | | |
| `LDS_SOURCE_RECORD_ID_PERSON` | `UUID` | Record-level identifier of the linked person record, sourced from Person. Retained separately from LDS_SOURCE_RECORD_ID to distinguish the person record identifier from the patient record identifier in this link table. | | |
| `GP_PRACTICE_CODE` | `VARCHAR` | ODS code of the patient's registered GP practice, sourced from Person. 'Unknown' when the organisation could not be resolved. | | |
| `LDS_IS_DELETED` | `BOOLEAN` | Indicates whether the source patient record has been logically deleted. Coalesced to FALSE when the source value is NULL. | | |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. | | |

## Entity Relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

| Related Table | Relationship Type | Local Key | Related Key | Notes |
| --- | --- | --- | --- | --- |
| [Patient](Patient.md) | FK | PATIENT_ID | ID | |
| [Person](Person.md) | FK | PERSON_ID | ID | |

## Notes
