# Referral_Request

## Overview
Transformed model for Referral_Request. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| ID | VARCHAR | id. | PK |
| LDS_SOURCE_RECORD_ID | VARCHAR | lds record id. |  |
| PUBLISHER_ORGANISATION_CODE | VARCHAR | record owner organisation code. |  |
| SOURCE_EXTRACTION_DATE | TIMESTAMP | source extraction date. |  |
| ORGANISATION_ID | VARCHAR | organisation id. | FK -> [Organisation](Organisation.md).ID |
| LDS_IS_DELETED | BOOLEAN | lds is deleted. |  |
| PATIENT_ID | VARCHAR | patient id. | FK -> [Patient](Patient.md).ID |
| PERSON_ID | VARCHAR | person id. | FK -> [Person](Person.md).ID |
| ENCOUNTER_ID | UUID | encounter id. | FK -> [Encounter](Encounter.md).ID |
| PRACTITIONER_ID | VARCHAR | practitioner id. | FK -> [Practitioner](Practitioner.md).ID |
| PUBLISHER_ORGANISATION_ID | VARCHAR | organisation id publisher. |  |
| AUTHOR_ORGANISATION_ID | VARCHAR | organisation id author. |  |
| UNIQUE_BOOKING_REFERENCE_NUMBER | VARCHAR | unique booking reference number. |  |
| CLINICAL_EFFECTIVE_DATE | DATE | clinical effective date. |  |
| CLINICAL_EFFECTIVE_DATE_PRECISION_SOURCE_CONCEPT_ID | UUID | date precision concept id. |  |
| REQUESTER_ORGANISATION_ID | VARCHAR | requester organisation id. |  |
| RECIPIENT_ORGANISATION_ID | VARCHAR | recipient organisation id. |  |
| REFERRAL_REQUEST_PRIORITY_CONCEPT_ID | UUID | referral request priority concept id. |  |
| REFERRAL_REQUEST_TYPE_CONCEPT_ID | UUID | referral request type concept id. |  |
| REFERRAL_REQUEST_SPECIALTY_CONCEPT_ID | UUID | referral request specialty concept id. |  |
| MODE | VARCHAR | mode. |  |
| IS_OUTGOING_REFERRAL | BOOLEAN | is outgoing referral. |  |
| IS_REVIEW | INTEGER | is review. |  |
| REFERRAL_REQUEST_SOURCE_CONCEPT_ID | UUID | referral request source concept id. |  |
| AGE_AT_EVENT | INTEGER | age at event. |  |
| AGE_AT_EVENT_BABY | INTEGER | age at event baby. |  |
| AGE_AT_EVENT_NEONATE | BIGINT | age at event neonate. |  |
| DAYS_BETWEEN | Unknown | days between. |  |
| YEARS_BOUNDARY | Unknown | years boundary. |  |
| RECORDED_DATE | TIMESTAMP | recorded date. |  |
| LDS_SEQUENCE | Unknown | lds sequence. |  |
| VALUE | DOUBLE | value. |  |
| CODE_ID | VARCHAR | code id. |  |

## Immediate Entity Relationships
| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| Admin_Organisation_Sequenced | Join | LDS_BUSINESS_ID_ORGANISATION | LDS_BUSINESS_ID | Derived from transformed model join condition |
| [Patient_Person](Patient_Person.md) | Join | LDS_BUSINESS_ID_PATIENT | PATIENT_ID | Derived from transformed model join condition |
| Admin_User_In_Role_Sequenced | Join | CLINICIAN_USER_IN_ROLE_GUID | USER_IN_ROLE_GUID | Derived from transformed model join condition |
| [Practitioner](Practitioner.md) | Join | LDS_BUSINESS_ID_CLINICIAN_USER_IN_ROLE | ID | Derived from transformed model join condition |
| [Person](Person.md) | FK | PERSON_ID | ID | Derived from dbt relationship test or naming convention |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID | Derived from dbt relationship test or naming convention |
| [Patient](Patient.md) | FK | PATIENT_ID | ID | Derived from dbt relationship test or naming convention |
| [Encounter](Encounter.md) | FK | ENCOUNTER_ID | ID | Derived from dbt relationship test or naming convention |
| [Organisation](Organisation.md) | FK | ORGANISATION_ID | ID | Derived from dbt relationship test or naming convention |

## Notes
- Data types are sourced from dbt catalog metadata generated against the dev DuckDB target. Unknown indicates the documented YAML column was not present in the materialized table metadata.

