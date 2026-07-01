# Schedule_Practitioner

## Overview
Transformed model for Schedule_Practitioner. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| LDS_SOURCE_RECORD_ID | VARCHAR | Unique record identifier including file row number for deduplication. |  |
| ID | VARCHAR | id. | PK |
| SCHEDULE_ID | VARCHAR | schedule id. | FK -> [Schedule](Schedule.md).ID |
| PRACTITIONER_ID | VARCHAR | practitioner id. | FK -> [Practitioner](Practitioner.md).ID |
| PUBLISHER_ORGANISATION_CODE | VARCHAR | record owner organisation code. |  |
| SOURCE_EXTRACTION_DATE | TIMESTAMP | source extraction date. |  |
| LDS_IS_DELETED | BOOLEAN | lds is deleted. |  |
| LDS_TRANSFORM_DATE_TIME | TIMESTAMP WITH TIME ZONE | lds transform date time. |  |
| LDS_SEQUENCE | Unknown | lds sequence. |  |

## Immediate Entity Relationships
| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| Appointment_Session_Sequenced | Join | SESSION_GUID | APPOINTMENT_SESSION_GUID | Derived from transformed model join condition |
| [Organisation](Organisation.md) | Join | LDS_BUSINESS_ID_ORGANISATION | ID | Derived from transformed model join condition |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID | Derived from dbt relationship test or naming convention |
| [Schedule](Schedule.md) | FK | SCHEDULE_ID | ID | Derived from dbt relationship test or naming convention |

## Notes
- Data types are sourced from dbt catalog metadata generated against the dev DuckDB target. Unknown indicates the documented YAML column was not present in the materialized table metadata.

