# Person

## Overview
Transformed model for Person. Combines PDS-sourced person records (from Person_Sequenced) with EMIS stub fallback records (from Admin_Patient_Sequenced) where no PDS response exists. PDS always wins over an EMIS stub when both exist for the same person ID. The LDS_BUSINESS_ID is derived from the NHS number match quality.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| ID | VARCHAR | Business key for the person record. Derived via generate_person_business_id: hashed from MATCHED_NHS_NO when a valid match exists, or from the patient LDS_BUSINESS_ID when no match (0000000000 / 9999999999 / empty), or from LDS_SOURCE_RECORD_ID as a last resort. tests: - unique - not_null | PK |
| LDS_SOURCE_RECORD_ID | VARCHAR | Unique record identifier. For PDS rows this is derived from UNIQUE_REFERENCE, file row number and file name. For EMIS stub rows it is derived from PATIENTGUID and ORGANISATIONGUID. |  |
| LDS_IS_DELETED | BOOLEAN | Indicates whether the source record has been logically deleted. Always FALSE for PDS rows (the PDS source has no deleted column). Inherited from the Admin_Patient source for EMIS stub rows. |  |
| REQ_NHS_NUMBER | VARCHAR | The NHS number that was sent in the PDS request (PDS rows) or the NHS number held on the EMIS Admin_Patient record (EMIS stub rows). Hashed at source. |  |
| MATCHED_NHS_NO | VARCHAR | The NHS number returned by PDS as the verified match. For EMIS stub rows this is set equal to REQ_NHS_NUMBER. Hashed at source. |  |
| FAMILY_NAME | VARCHAR | Patient's family / last name. Sourced from PDS FAMILY_NAME (PDS rows) or EMIS SURNAME (EMIS stub rows). |  |
| GIVEN_NAME | VARCHAR | Patient's first given name. |  |
| OTHER_GIVEN_NAME | VARCHAR | Additional given names. Sourced from PDS OTHER_GIVEN_NAME or EMIS MIDDLE_NAMES. |  |
| GENDER | VARCHAR | Administrative gender. Populated from PDS response. NULL for EMIS stub rows as EMIS does not supply a gender field in the same format. |  |
| DATE_OF_BIRTH | VARCHAR | Patient's date of birth. |  |
| DATE_OF_BIRTH_YEAR | BIGINT | Year component of DATE_OF_BIRTH. |  |
| DATE_OF_BIRTH_MONTH | BIGINT | Month component of DATE_OF_BIRTH. |  |
| DATE_OF_BIRTH_DAY | BIGINT | Day component of DATE_OF_BIRTH. |  |
| DATE_OF_BIRTH_TIME | TIME | Time component of DATE_OF_BIRTH. Always NULL — neither PDS nor EMIS provides a time-of-birth value. |  |
| DATE_OF_DEATH | VARCHAR | Patient's date of death. NULL if the patient is living. |  |
| DATE_OF_DEATH_YEAR | BIGINT | Year component of DATE_OF_DEATH. |  |
| DATE_OF_DEATH_MONTH | BIGINT | Month component of DATE_OF_DEATH. |  |
| DATE_OF_DEATH_DAY | BIGINT | Day component of DATE_OF_DEATH. |  |
| DATE_OF_DEATH_TIME | TIME | Time component of DATE_OF_DEATH. Always NULL — neither PDS nor EMIS provides a time-of-death value. |  |
| DEATH_NOTIFICATION_STATUS | VARCHAR | PDS death notification status code. NULL for EMIS stub rows. |  |
| ADDRESS_LINE1 | VARCHAR | First line of the patient's address. NULL for EMIS stub rows. |  |
| ADDRESS_LINE2 | VARCHAR | Second line of the patient's address. NULL for EMIS stub rows. |  |
| ADDRESS_LINE3 | VARCHAR | Third line of the patient's address. NULL for EMIS stub rows. |  |
| ADDRESS_LINE4 | VARCHAR | Fourth line of the patient's address. NULL for EMIS stub rows. |  |
| ADDRESS_LINE5 | VARCHAR | Fifth line of the patient's address. NULL for EMIS stub rows. |  |
| POSTCODE | VARCHAR | Patient's postcode. NULL for EMIS stub rows. |  |
| PREFERRED_CONTACT_METHOD | VARCHAR | PDS preferred contact method code. NULL for EMIS stub rows. |  |
| NOMINATED_PHARMACY | VARCHAR | PDS nominated pharmacy ODS code. NULL for EMIS stub rows. |  |
| DISPENSING_DOCTOR | VARCHAR | PDS dispensing doctor code. NULL for EMIS stub rows. |  |
| MEDICAL_APPLIANCE_SUPPLIER | VARCHAR | PDS medical appliance supplier code. NULL for EMIS stub rows. |  |
| GP_PRACTICE_CODE | VARCHAR | ODS code of the patient's registered GP practice. For PDS rows this comes directly from the PDS response. For EMIS stub rows it is resolved from Organisation via the patient's LDS_BUSINESS_ID_ORGANISATION; defaults to 'Unknown' when no match is found. |  |
| GP_REGISTRATION_DATE | VARCHAR | Date the patient registered with their current GP practice. Populated for PDS rows only; NULL for EMIS stub rows. |  |
| NHAIS_POSTING_ID | VARCHAR | PDS NHAIS posting identifier. NULL for EMIS stub rows. |  |
| AS_AT_DATE | VARCHAR | The date the PDS record was valid as at. NULL for EMIS stub rows. |  |
| LOCAL_PATIENT_ID | VARCHAR | Local patient identifier from the PDS response. NULL for EMIS stub rows. |  |
| INTERNAL_ID | VARCHAR | PDS internal identifier. NULL for EMIS stub rows. |  |
| TELEPHONE_NUMBER | VARCHAR | Patient's telephone number from PDS. NULL for EMIS stub rows. |  |
| MOBILE_NUMBER | VARCHAR | Patient's mobile number from PDS. NULL for EMIS stub rows. |  |
| EMAIL_ADDRESS | VARCHAR | Patient's email address from PDS. NULL for EMIS stub rows. |  |
| MPS_ID | VARCHAR | Master Patient Service identifier from PDS. NULL for EMIS stub rows. |  |
| SENSITIVITY_FLAG | VARCHAR | Always NULL in this model. The source SENSITIVITY_FLAG from PDS is intentionally overridden with CAST(NULL AS VARCHAR(1)) to prevent accidental disclosure of sensitive flagging in downstream consumers. |  |
| ERROR_SUCCESS_CODE | VARCHAR | PDS response error_success code (sourced from the ERROR_SUCCESS_CODE column in PDS_DATA_MASKED). For EMIS stub rows, set to '92' when SPINE_SENSITIVE is TRUE; otherwise NULL. |  |
| Source | VARCHAR | Indicates the origin of the person record. 'Person' for records sourced from PDS (Person_Sequenced); 'EMIS' for stub records sourced from Admin_Patient_Sequenced where no PDS response exists. |  |

##  Entity Relationships
| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Organisation](Organisation.md) | Join | LDS_BUSINESS_ID_ORGANISATION | ID |  |

## Notes

