# Schedule

## Overview
Transformed model for Schedule. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| LDS_SOURCE_RECORD_ID | VARCHAR | lds record id. |  |
| ID | VARCHAR | id. |  |
| LOCATION_ID | VARCHAR | location id. | FK -> [Location](Location.md).ID |
| LOCATION | VARCHAR | location. |  |
| PRACTITIONER_ID | VARCHAR | practitioner id. | FK -> [Practitioner](Practitioner.md).ID |
| START_DATE | TIMESTAMP | start date. |  |
| END_DATE | TIMESTAMP | end date. |  |
| TYPE | VARCHAR | type. |  |
| NAME | VARCHAR | name. |  |
| IS_PRIVATE | BOOLEAN | is private. |  |
| PUBLISHER_ORGANISATION_CODE | VARCHAR | record owner organisation code. |  |
| SOURCE_EXTRACTION_DATE | TIMESTAMP | source extraction date. |  |
| LDS_TRANSFORM_DATE_TIME | TIMESTAMP WITH TIME ZONE | lds transform date time. |  |
| LDS_SEQUENCE | Unknown | lds sequence. |  |
| LDS_IS_DELETED | BOOLEAN | lds is deleted. |  |

## Immediate Entity Relationships
| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Organisation](Organisation.md) | Join | LDS_BUSINESS_ID_ORGANISATION | ID | Derived from transformed model join condition |
| [Location](Location.md) | Join | LDS_BUSINESS_ID_LOCATION | ID | Derived from transformed model join condition |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID | Derived from dbt relationship test or naming convention |
| [Location](Location.md) | FK | LOCATION_ID | ID | Derived from dbt relationship test or naming convention |

## Notes
- Data types are sourced from dbt catalog metadata generated against the dev DuckDB target. Unknown indicates the documented YAML column was not present in the materialized table metadata.

