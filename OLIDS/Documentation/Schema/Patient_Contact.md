# Patient_Contact

- [Patient\_Contact](#patient_contact)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity Relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

Related FHIR resource [🔥 Patient.telecom](https://hl7.org/fhir/patient-definitions.html#Patient.telecom)

A Patient may have multiple ways to be contacted with different uses or applicable periods. May need to have options for contacting the person urgently and also to help with identification. The address might not go directly to the individual, but may reach another party that is able to proxy for the patient (i.e. home phone, or pet owner's phone).

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Masking policy | Compass Equivalent |
| --- | --- | --- | --- | --- | --- |
| `ID` | `UUID` | id. | | | `id` |
| `LDS_SOURCE_RECORD_ID` | `UUID` | Unique record identifier including file row number for deduplication. | | | -- |
| `PATIENT_ID` | `UUID` | patient id. | FK -> [Patient](Patient.md).ID | | `patient_id` |
| `PERSON_ID` | `UUID` | person id. | FK -> [Person](Person.md).ID | | `person_id` |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id publisher. | | | `organization_id` |
| `PROVIDER_ORGANISATION_ID` | `UUID` | organisation id provider. | | | `organization_id` |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id author. | | | `organization_id` |
| `CONTACT_TYPE_SOURCE_CONCEPT_ID` | `UUID` | contact type concept id. | FK -> [Concept](Concept.md).ID | | `type_concept_id` |
| `VALUE` | `VARCHAR` | value. | available in PID views only | ❌ column removed | `value` |
| `START_DATE` | `DATE` | start date. | | | `start_date` |
| `END_DATE` | `DATE` | end date. | | | `end_date` |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. | | | -- |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The Organisation Data Service (ODS) code of the organisation who, acting as the data controller, publishes the data. | | | `organization_id` |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. | | | -- |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. | | | -- |

## Entity Relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

| Related Table | Relationship Type | Local Key | Related Key | Notes |
| --- | --- | --- | --- | --- |
| [Patient](Patient.md) | FK | PATIENT_ID | ID | |
| [Person](Person.md) | FK | PERSON_ID | ID | |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID | |
| [Concept](Concept.md) | FK | CONTACT_TYPE_SOURCE_CONCEPT_ID | CONCEPT_ID | |

## Notes
