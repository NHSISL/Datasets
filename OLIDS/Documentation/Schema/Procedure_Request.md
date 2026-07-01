# Procedure_Request

## Overview
Transformed model for Procedure_Request. Includes transformed\n\

## Columns
| Column Name | Data Type (Size) | Description | PK/FK |
|---|---|---|---|
| ID | VARCHAR | id. | PK |
| LDS_SOURCE_RECORD_ID | VARCHAR | lds record id. |  |
| PUBLISHER_ORGANISATION_CODE | VARCHAR | record owner organisation code. |  |
| SOURCE_EXTRACTION_DATE | TIMESTAMP | source extraction date. |  |
| LDS_IS_DELETED | BOOLEAN | lds is deleted. |  |
| PATIENT_ID | VARCHAR | patient id. | FK -> [Patient](Patient.md).ID |
| PERSON_ID | VARCHAR | person id. | FK -> [Person](Person.md).ID |
| PRACTITIONER_ID | VARCHAR | practitioner id. | FK -> [Practitioner](Practitioner.md).ID |
| PUBLISHER_ORGANISATION_ID | VARCHAR | organisation id publisher. |  |
| PROVIDER_ORGANISATION_ID | VARCHAR | organisation id provider. |  |
| LDS_BUSINESS_ID_ORGANISATION_AUTHOR | Unknown | lds business id organisation author. |  |
| ENCOUNTER_ID | VARCHAR | encounter id. | FK -> [Encounter](Encounter.md).ID |
| CLINICAL_EFFECTIVE_DATE | DATE | clinical effective date. |  |
| CLINICAL_EFFECTIVE_DATE_PRECISION_SOURCE_CONCEPT_ID | UUID | date precision concept id. |  |
| DATE_RECORDED | TIMESTAMP | date recorded. |  |
| DESCRIPTION | VARCHAR | description. |  |
| PROCEDURE_REQUEST_SOURCE_CONCEPT_ID | UUID | procedure request source concept id. |  |
| AGE_AT_EVENT | INTEGER | age at event. |  |
| AGE_AT_EVENT_BABY | INTEGER | age at event baby. |  |
| AGE_AT_EVENT_NEONATE | BIGINT | age at event neonate. |  |
| IS_CONFIDENTIAL | BOOLEAN | is confidential. |  |
| LDS_SEQUENCE | Unknown | lds sequence. |  |
| LDS_CONCEPT_ID_STATUS | UUID | lds concept id status. |  |

## Entity Relationships

| Related Table | Relationship Type | Local Key | Related Key | Notes |
|---|---|---|---|---|
| [Practitioner](Practitioner.md) | Join | LDS_BUSINESS_ID_CLINICIAN_USER_IN_ROLE | ID | Derived from transformed model join condition |
| [Person](Person.md) | FK | PERSON_ID | ID | Derived from dbt relationship test or naming convention |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID | Derived from dbt relationship test or naming convention |
| [Patient](Patient.md) | FK | PATIENT_ID | ID | Derived from dbt relationship test or naming convention |
| [Encounter](Encounter.md) | FK | ENCOUNTER_ID | ID | Derived from dbt relationship test or naming convention |

## Notes


