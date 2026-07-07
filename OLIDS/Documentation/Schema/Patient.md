# Patient

- [Patient](#patient)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

Related FHIR resource: [🔥 Patient](https://build.fhir.org/patient.html)

This Resource covers data about patients involved in a wide range of health-related activities, including:

- Curative activities
- Psychiatric care
- Social services
- Pregnancy care
- Nursing and assisted living
- Dietary services
- Tracking of personal health and exercise data
- Tracking financial services (e.g. insurance subscriber/policy holder)
- Public health
- Population health

The data in the Resource covers the "who" information about the patient: its attributes are focused on the demographic information necessary to support the administrative, financial and logistic procedures. A Patient record is generally created and maintained by each organisation providing care for a patient. A "patient" receiving care at multiple organisations may therefore have its information present in multiple Patient Resources.

> [!TIP]
> A "Patient" is a person undergoing care at a particular care provider.
> A "Person" is not specific to a single care provider.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Masking policy | Compass Equivalent |
| --- | --- | --- | --- | --- | --- |
| `ID` | `UUID` | id. | PK | | `id` |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. | | | -- |
| `PERSON_ID` | `UUID` | linked person id. | FK -> [Person](Person.md).ID | | `person_id` |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id of the record publisher<sup>1</sup>. | FK -> [Organisation](Organisation.md).ID | | `organization_id` |
| `PROVIDER_ORGANISATION_ID` | `UUID` | organisation id of the care provider<sup>1</sup>. | FK -> [Organisation](Organisation.md).ID | | -- |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id record author<sup>1</sup>. | FK -> [Organisation](Organisation.md).ID | | -- |
| `REGISTERED_PRACTICE_ORGANISATION_ID` | `UUID` | registered practice id. | FK -> [Organisation](Organisation.md).ID | | -- |
| `DATE_OF_REGISTRATION` | `DATE` | date of registration. | | | -- |
| `DATE_OF_DEACTIVATION` | `DATE` | date of deactivation. | | | -- |
| `NHS_NUMBER` | `VARCHAR` | nhs number. | | ❌ column removed | `nhs_number` |
| `SK_PATIENT_ID` | `NUMBER` | sk patient id. | | ℹ️ pseudo view only | -- |
| `TITLE` | `VARCHAR` | title. | | | `title` |
| `FIRST_NAME` | `VARCHAR` | first name. | | ❌ column removed | `first_names` |
| `MIDDLE_NAME` | `VARCHAR` | middle name. | | ❌ column removed | -- |
| `LAST_NAME` | `VARCHAR` | last name. | | ❌ column removed | `last_name` |
| `GENDER_SOURCE_CONCEPT_ID` | `Unknown` | gender concept id. | FK -> [Concept](Concept.md).ID | | -- |
| `BIRTH_DATE` | `DATE` | birth date. | | 📅 date generalised | `date_of_birth` |
| `BIRTH_YEAR` | `BIGINT` | birth year. | | | -- |
| `BIRTH_MONTH` | `BIGINT` | birth month. | | | -- |
| `BIRTH_WEEK_ISO` | `BIGINT` | birth week iso. | | | -- |
| `BIRTH_DAY` | `BIGINT` | birth day. | | ❌ column removed | -- |
| `DEATH_DATE` | `DATE` | death date. | | 📅 date generalised | `date_of_death` |
| `DEATH_YEAR` | `BIGINT` | death year. | | | -- |
| `DEATH_MONTH` | `BIGINT` | death month. | | | -- |
| `DEATH_WEEK_ISO` | `BIGINT` | death week iso. | | | -- |
| `IS_CONFIDENTIAL` | `BOOLEAN` | is confidential. | | | -- |
| `IS_TEST_PATIENT` | `Unknown` | is test patient. | | | -- |
| `IS_SPINE_SENSITIVE` | `BOOLEAN` | is spine sensitive. | | | -- |
| `LDS_SOURCE_DATASET` | `VARCHAR` | name of the source dataset | | | -- |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. | | | -- |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The Organisation Data Service (ODS) code of the organisation who, acting as the data controller, publishes the  |data. | | `organization_id` |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. | | | -- |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. | | | -- |

1. See the [schema notes section on publisher, provider, author organisation definitions](_schema_notes.md#provider-author-publisher-organisation-id)

## Entity relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

| Related Table | Relationship Type | Local Key | Related Key | Notes |
| --- | --- | --- | --- | --- |
| [Person](Person.md) | FK | PERSON_ID | ID | |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID | |
| [Organisation](Organisation.md) | FK | REGISTERED_PRACTICE_ORGANISATION_ID | ID | |
| [Concept](Concept.md) | FK | GENDER_SOURCE_CONCEPT_ID | CONCEPT_ID | |

## Notes
