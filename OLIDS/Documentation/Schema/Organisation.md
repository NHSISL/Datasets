# Organisation

## Overview
Transformed model for Organisation. Includes transformed fields and lineage columns from Versioned models.

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| `ID` | `UUID` | id. |  |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. |  |
| `ORGANISATION_CODE` | `VARCHAR` | organisation code. |  |
| `ASSIGNING_AUTHORITY_CODE` | `VARCHAR` | assigning authority code. |  |
| `NAME` | `VARCHAR` | name. |  |
| `PRIMARY_LOCATION_TYPE_SOURCE_CONCEPT_ID` | `UUID` | type code. | FK --> [Concept](Concept.md).CONCEPT_ID |
| `TYPE_DESCRIPTION` | `VARCHAR` | type desc. |  |
| `POSTCODE` | `VARCHAR` | postcode. |  |
| `PARENT_ORGANISATION_ID` | `UUID` | parent organisation id. | FK --> [Organisation](Organisation.md).ID |
| `OPEN_DATE` | `DATE` | open date. |  |
| `CLOSE_DATE` | `DATE` | close date. |  |
| `IS_OBSOLETE` | `BOOLEAN` | is obsolete. |  |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. |  |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. |  |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. |  |

## Entity relations

See references to Organisation in other tables

## Notes

Table is provided by some suppliers (including both EMIS/Optum and TPP) as an 'unowned' reference dimension. As such it is not possible to allocate records to a specific recipient and instead the records are surfaced to consumers without row-access policies applied. There is no patient related data contained in this object and therefore no risk to sharing.

