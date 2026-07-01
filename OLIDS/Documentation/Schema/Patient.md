# Patient

## Overview
Transformed model for Patient. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| `ID` | VARCHAR | id. | PK |
| `LDS_SOURCE_RECORD_ID` | VARCHAR | lds record id. |  |
| `PERSON_ID` | UUID | linked person id. | FK -> [Person](Person.md).ID |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id of the record publisher^1^. | FK -> [Organisation](Organisation.md).ID |
| `PROVIDER_ORGANISATION_ID` | `UUID` | organisation id of the care provider^1^. | FK -> [Organisation](Organisation.md).ID |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id record author^1^. | FK -> [Organisation](Organisation.md).ID |
| `REGISTERED_PRACTICE_ORGANISATION_ID` | UUID | registered practice id. | FK -> [Organisation](Organisation.md).ID |
| `DATE_OF_REGISTRATION` | DATE | date of registration. |  |
| `DATE_OF_DEACTIVATION` | DATE | date of deactivation. |  |
| `NHS_NUMBER` | VARCHAR | nhs number. |  |
| `SK_PATIENT_ID` | NUMBER | sk patient id. |  |
| `TITLE` | VARCHAR | title. |  |
| `FIRST_NAME` | VARCHAR | first name. |  |
| `MIDDLE_NAME` | VARCHAR | middle name. |  |
| `LAST_NAME` | VARCHAR | last name. |  |
| `GENDER_SOURCE_CONCEPT_ID` | Unknown | gender concept id. | FK -> [Concept](Concept.md).ID |
| `BIRTH_DATE` | DATE | birth date. |  |
| `BIRTH_YEAR` | BIGINT | birth year. |  |
| `BIRTH_MONTH` | BIGINT | birth month. |  |
| `BIRTH_WEEK_ISO` | BIGINT | birth week iso. |  |
| `BIRTH_DAY` | BIGINT | birth day. |  |
| `DEATH_DATE` | DATE | death date. |  |
| `DEATH_YEAR` | BIGINT | death year. |  |
| `DEATH_MONTH` | BIGINT | death month. |  |
| `DEATH_WEEK_ISO` | BIGINT | death week iso. |  |
| `IS_CONFIDENTIAL` | BOOLEAN | is confidential. |  |
| `IS_TEST_PATIENT` | Unknown | is test patient. |  |
| `IS_SPINE_SENSITIVE` | BOOLEAN | is spine sensitive. |  |
| `LDS_SOURCE_DATASET` | VARCHAR | name of the source dataset |  |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. |  |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The Organisation Data Service (ODS) code of the organisation who, acting as the data controller, publishes the data. |  |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. |  |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. |  |

1. See the [schema notes section on publisher, provider, author organisation definitions](_schema_notes.md#provider-author-publisher-organisation-id)

## Immediate Entity Relationships
| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Person](Person.md) | FK | PERSON_ID | ID | |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | REGISTERED_PRACTICE_ORGANISATION_ID | ID | |
| [Concept](Concept.md) | FK |  GENDER_SOURCE_CONCEPT_ID | CONCEPT_ID | |


## Notes

