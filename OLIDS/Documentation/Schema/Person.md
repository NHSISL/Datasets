# Person

- [Person](#person)
  - [Overview](#overview)
  - [Columns](#columns)
    - [columns to be added](#columns-to-be-added)
  - [Entity relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

Represents a 'golden-record' of a person. A person can be represented by multiple-patient resources across different care providers (or multiple care episodes at the same care provider).

The Person object combines national Person Demograhpics Services (PDS) sourced person records with source system "stub" fallback records (using the source systems patient record) where no PDS matched response exists.

PDS responses will always be used over an source system stub where both exist for the same person ID.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Masking Policy | Compass Equivalent |
| --- | --- | --- | --- | --- | --- |
| `ID` | `UUID` | unique identifier for the person. | PK | | -- |
| `LDS_SOURCE_RECORD_ID` | `UUID` | Unique source record identifier (generated deterministcally from source data) | | | -- |
| `REQ_NHS_NUMBER` | `VARCHAR` | The NHS number that was sent in the PDS request (PDS rows) or the NHS number held on the EMIS Admin_Patient record (EMIS stub rows). Hashed at source. | | #️⃣ hashed | -- |
| `MATCHED_NHS_NO` | `VARCHAR` | The NHS number returned by PDS as the verified match. For EMIS stub rows this is set equal to REQ_NHS_NUMBER. Hashed at source. | | #️⃣ hashed | -- |
| `FAMILY_NAME` | `VARCHAR` | Patient's family / last name. Sourced from PDS FAMILY_NAME (PDS rows) or EMIS SURNAME (EMIS stub rows). | | ❌ column removed | -- |
| `GIVEN_NAME` | `VARCHAR` | Patient's first given name. | | ❌ column removed | -- |
| `OTHER_GIVEN_NAME` | `VARCHAR` | Additional given names. Sourced from PDS OTHER_GIVEN_NAME or EMIS MIDDLE_NAMES. | | ❌ column removed | -- |
| `GENDER` | `VARCHAR` | Administrative gender. Populated from PDS response. NULL for EMIS stub rows as EMIS does not supply a gender field in the same format. | | | -- |
| `DATE_OF_BIRTH` | `VARCHAR` | Patient's date of birth. | | 📅 truncated to 1st of month | -- |
| `DATE_OF_BIRTH_YEAR` | `BIGINT` | Year component of DATE_OF_BIRTH. | | | -- |
| `DATE_OF_BIRTH_MONTH` | `BIGINT` | Month component of DATE_OF_BIRTH. | | | -- |
| `DATE_OF_BIRTH_DAY` | `BIGINT` | Day component of DATE_OF_BIRTH. | | 📅 truncated to 1st of month | -- |
| `DATE_OF_BIRTH_TIME` | `TIME` | Time component of DATE_OF_BIRTH. Always NULL — neither PDS nor EMIS provides a time-of-birth value. | | 📅 nullified | -- |
| `DATE_OF_DEATH` | `VARCHAR` | Patient's date of death. NULL if the patient is living. | | 📅 truncated to 1st of month | -- |
| `DATE_OF_DEATH_YEAR` | `BIGINT` | Year component of DATE_OF_DEATH. | | | -- |
| `DATE_OF_DEATH_MONTH` | `BIGINT` | Month component of DATE_OF_DEATH. | | | -- |
| `DATE_OF_DEATH_DAY` | `BIGINT` | Day component of DATE_OF_DEATH. | | 📅 truncated to 1st of month | -- |
| `DATE_OF_DEATH_TIME` | `TIME` | Time component of DATE_OF_DEATH. Always NULL — neither PDS nor EMIS provides a time-of-death value. | | 📅 nullified | -- |
| `DEATH_NOTIFICATION_STATUS` | `VARCHAR` | PDS death notification status code. NULL for EMIS stub rows. | | | -- |
| `ADDRESS_LINE1` | `VARCHAR` | First line of the patient's address. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `ADDRESS_LINE2` | `VARCHAR` | Second line of the patient's address. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `ADDRESS_LINE3` | `VARCHAR` | Third line of the patient's address. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `ADDRESS_LINE4` | `VARCHAR` | Fourth line of the patient's address. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `ADDRESS_LINE5` | `VARCHAR` | Fifth line of the patient's address. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `POSTCODE` | `VARCHAR` | Patient's postcode. NULL for EMIS stub rows. | | #️⃣ hashed | -- |
| `PREFERRED_CONTACT_METHOD` | `VARCHAR` | PDS preferred contact method code. NULL for EMIS stub rows. | | | -- |
| `NOMINATED_PHARMACY` | `VARCHAR` | PDS nominated pharmacy ODS code. NULL for EMIS stub rows. | | | -- |
| `DISPENSING_DOCTOR` | `VARCHAR` | PDS dispensing doctor code. NULL for EMIS stub rows. | | | -- |
| `MEDICAL_APPLIANCE_SUPPLIER` | `VARCHAR` | PDS medical appliance supplier code. NULL for EMIS stub rows. | | | -- |
| `GP_PRACTICE_CODE` | `VARCHAR` | ODS code of the patient's registered GP practice. For PDS rows this comes directly from the PDS response. For EMIS stub rows it is resolved from Organisation via the patient's LDS_BUSINESS_ID_ORGANISATION; defaults to 'Unknown' when no match is found. | | | -- |
| `GP_REGISTRATION_DATE` | `VARCHAR` | Date the patient registered with their current GP practice. Populated for PDS rows only; NULL for EMIS stub rows. | | | -- |
| `NHAIS_POSTING_ID` | `VARCHAR` | PDS NHAIS posting identifier. NULL for EMIS stub rows. | | | -- |
| `AS_AT_DATE` | `VARCHAR` | The date the PDS record was valid as at. NULL for EMIS stub rows. | | | -- |
| `LOCAL_PATIENT_ID` | `VARCHAR` | Local patient identifier from the PDS response. NULL for EMIS stub rows. | | | -- |
| `INTERNAL_ID` | `VARCHAR` | PDS internal identifier. NULL for EMIS stub rows. | | | -- |
| `TELEPHONE_NUMBER` | `VARCHAR` | Patient's telephone number from PDS. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `MOBILE_NUMBER` | `VARCHAR` | Patient's mobile number from PDS. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `EMAIL_ADDRESS` | `VARCHAR` | Patient's email address from PDS. NULL for EMIS stub rows. | | ❌ column removed | -- |
| `MPS_ID` | `VARCHAR` | Master Patient Service identifier from PDS. NULL for EMIS stub rows. | | | -- |
| `PATIENT_FLAGGED_SENSITIVE` | `BOOLEAN` | True where patient is flagged as sensitive. | | | -- |
| `ERROR_SUCCESS_CODE` | `VARCHAR` | PDS response error_success code (sourced from the ERROR_SUCCESS_CODE column in PDS_DATA_MASKED). For EMIS stub rows, set to '92' when SPINE_SENSITIVE is TRUE; otherwise NULL. | | | -- |
| `LDS_IS_DELETED` | `BOOLEAN` | Indicates whether the source record has been logically deleted. Always FALSE for PDS rows (the PDS source has no deleted column). Inherited from the Admin_Patient source for EMIS stub rows. | | | -- |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | The timestamp when the source record was acquired or supplied to LDS | | | -- |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP` | The timestamp when the source record was transformed by LDS | | | -- |

### columns to be added

| Column Name | Data Type (Size) | Description | PK/FK | Masking Policy | Compass Equivalent |
| --- | --- | --- | --- | --- | --- |
| `LDS_SOURCE_DATASET` | `VARCHAR` | Indicates the origin of the person record. 'Person' for records sourced from PDS (Person_Sequenced); 'EMIS' for stub records sourced from Admin_Patient_Sequenced where no PDS response exists. | | | -- |
| `IS_PATIENT_FLAGGED_SENSITIVE` | `BOOLEAN` | will replace/rename `PATIENT_FLAGGED_SENSITIVE`. | | | -- |

## Entity relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

The Person table joins with most other event/entity objects. See `PERSON_ID` in other tables.

## Notes
