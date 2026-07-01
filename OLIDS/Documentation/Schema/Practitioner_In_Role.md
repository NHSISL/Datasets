# Practitioner_In_Role

## Overview
Transformed model for Practitioner_In_Role. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| `ID` | `VARCHAR` | id. |  |
| `LDS_SOURCE_RECORD_ID` | `VARCHAR` | Unique record identifier including file row number for deduplication. |  |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id of the record publisher^1^. | FK -> [Organisation](Organisation.md).ID |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id record author^1^. | FK -> [Organisation](Organisation.md).ID |
| `PRACTITIONER_ID` | `VARCHAR` | practitioner id. | FK -> [Practitioner](Practitioner.md).ID |
| `EMPLOYER_ORGANISATION_ID` | `VARCHAR` | organisation id of the employing organisation for this record. |  |
| `ROLE_CODE` | `VARCHAR` | role code. |  |
| `ROLE` | `VARCHAR` | role. |  |
| `DATE_EMPLOYMENT_START` | `DATE` | date employment start. |  |
| `DATE_EMPLOYMENT_END` | `DATE` | date employment end. |  |
| `LDS_IS_DELETED` | `BOOLEAN` | True if the record has been marked as deleted. |  |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | ODS code of the owning organisation for this record. |  |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | Timestamp extracted from source file name indicating extraction time. |  |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. |  |

## Entity Relationships

| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID |  |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID |  |
| [Organisation](Organisation.md) | FK | EMPLOYER_ORGANISATION_ID | ID |  |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID |  |

## Notes

