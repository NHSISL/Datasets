# Practitioner

## Overview
Transformed model for Practitioner. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| `ID` | `UUID` | id. | PK |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. |  |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id of the record publisher^1^. | FK -> [Organisation](Organisation.md).ID |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id record author^1^. | FK -> [Organisation](Organisation.md).ID || GMC_CODE | VARCHAR | gmc code. |  |
| `GMC_CODE` | `VARCHAR` | general medical council code | |
| `TITLE` | `VARCHAR` | title. |  |
| `FIRST_NAME` | `VARCHAR` | first name. |  |
| `SURNAME` | `VARCHAR` | surname. |  |
| `NAME` | `VARCHAR` | name. |  |
| `IS_OBSOLETE` | `BOOLEAN` | is obsolete. |  |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. |  |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The Organisation Data Service (ODS) code of the organisation who, acting as the data controller, publishes the data. |  |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. |  |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. |  |

## Entity Relationships

| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID |  |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID |  |


## Notes


