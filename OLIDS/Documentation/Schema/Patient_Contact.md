# Patient_Contact

## Overview
Transformed model for Patient_Contact. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| `ID` | `UUID` | id. |  |
| `LDS_SOURCE_RECORD_ID` | `VARCHAR` | Unique record identifier including file row number for deduplication. |  |
| `PATIENT_ID` | `VARCHAR` | patient id. | FK -> [Patient](Patient.md).ID |
| `PERSON_ID` | `VARCHAR` | person id. | FK -> [Person](Person.md).ID |
| `PUBLISHER_ORGANISATION_ID` | `VARCHAR` | organisation id publisher. |  |
| `PROVIDER_ORGANISATION_ID` | `VARCHAR` | organisation id provider. |  |
| `AUTHOR_ORGANISATION_ID` | `VARCHAR` | organisation id author. |  |
| `CONTACT_TYPE_SOURCE_CONCEPT_ID` | `UUID` | contact type concept id. | FK -> [Concept](Concept.md).ID |
| `VALUE` | `VARCHAR` | value. | available in PID views only |
| `START_DATE` | `DATE` | start date. |  |
| `END_DATE` | `DATE` | end date. |  |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. |  |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The Organisation Data Service (ODS) code of the organisation who, acting as the data controller, publishes the data. |  |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. |  |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. |  |

## Entity Relationships

| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Patient](Patient.md) | FK | PATIENT_ID | ID | |
| [Person](Person.md) | FK | PERSON_ID | ID | |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID |  |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID |  |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID |  |
| [Concept](Concept.md) | FK | CONTACT_TYPE_SOURCE_CONCEPT_ID | CONCEPT_ID |  |

## Notes


