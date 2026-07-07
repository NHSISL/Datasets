# Referral_Request

- [Referral\_Request](#referral_request)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity Relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

Linked FHIR resource: [Referral Request](https://hl7.org/fhir/STU3/referralrequest.html)

> [!WARNING]
> The linked FHIR resource is from FHIR Release 3, which is now deprecated.
> <br>HL7 International consolidated all procedure requests, diagnostic orders, and service requests into a single, unified resource called `ServiceRequest`
> <br>See [ServiceRequest](https://hl7.org/fhir/servicerequest.html)

ReferralRequest is one of the request resources in the FHIR workflow specification.

This resource is used to share relevant information required to support a referral request or a transfer of care request from one practitioner or organisation to another. It is intended for use when a patient is required to be referred to another provider for a consultation/second opinion and/or for short term or longer term management of one or more health issues or problems.

Examples include:

- Request for a consultation from a specialist
- Referral for support from community services
- District nursing services referral
- Request for aged care placement assessment
- Request for a pharmacist medication review
- Referral for physiotherapy or occupational therapy

ReferralRequest is also intended for use when there is a complete and more permanent transfer of care responsibility from one practitioner/organisation to another (for example, as in the case of requesting the transfer of care for a patient from an acute care setting to rehabilitation, aged care, or a skilled nursing facility).

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Compass Equivalent |
| --- | --- | --- | --- | --- |
| `ID` | `UUID` | id. | PK | `id` |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. | - | -- |
| `PATIENT_ID` | `UUID` | patient id. | FK -> [Patient](Patient.md).ID | `patient_id` |
| `PERSON_ID` | `UUID` | person id. | FK -> [Person](Person.md).ID | `person_id` |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | linked organisaiton id publisher. see [schema notes: publisher, provider, author](_schema_notes.md#provider-author-publisher-organisation-id) | FK -> [ORANGANISATION](Organisation.md).ID | `organization_id` |
| `PROVIDER_ORGANISATION_ID` | `UUID` | linked organisaiton id provider. see [schema notes: publisher, provider, author](_schema_notes.md#provider-author-publisher-organisation-id) | FK -> [ORANGANISATION](Organisation.md).ID | -- |
| `AUTHOR_ORGANISATION_ID` | `UUID` | linked organisaiton id author. see [schema notes: publisher, provider, author](_schema_notes.md#provider-author-publisher-organisation-id) | FK -> [ORANGANISATION](Organisation.md).ID | `organization_id` |
| `ENCOUNTER_ID` | `UUID` | encounter id. | FK -> [Encounter](Encounter.md).ID | `encounter_id` |
| `PRACTITIONER_ID` | `UUID` | practitioner id. | FK -> [Practitioner](Practitioner.md).ID | `practitioner_id` |
| `UNIQUE_BOOKING_REFERENCE_NUMBER` | `VARCHAR` | unique booking reference number. | | -- |
| `CLINICAL_EFFECTIVE_DATE` | `DATE` | clinical effective date. | | `clinical_effective_date` |
| `CLINICAL_EFFECTIVE_DATE_PRECISION_SOURCE_CONCEPT_ID` | `UUID` | date precision concept id. | FK->[Concept](Concept.md).CONCEPT_ID | `date_precision_concept_id` |
| `REQUESTER_ORGANISATION_ID` | `UUID` | requester organisation id. | [ORANGANISATION](Organisation.md).ID | `requester_organization_id` |
| `RECIPIENT_ORGANISATION_ID` | `UUID` | recipient organisation id. | [ORANGANISATION](Organisation.md).ID | `recipient_organization_id` |
| `REFERRAL_REQUEST_PRIORITY_SOURCE_CONCEPT_ID` | `UUID` | referral request priority concept id. | FK->[Concept](Concept.md).CONCEPT_ID | `referral_request_priority_concept_id` |
| `REFERRAL_REQUEST_TYPE_SOURCE_CONCEPT_ID` | `UUID` | referral request type concept id. | FK->[Concept](Concept.md).CONCEPT_ID | `referral_request_type_concept_id` |
| `REFERRAL_REQUEST_SPECIALTY_SOURCE_CONCEPT_ID` | `UUID` | referral request specialty concept id. | FK->[Concept](Concept.md).CONCEPT_ID | `referral_request_specialty_concept_id` |
| `MODE` | `VARCHAR` | mode. | | `mode` |
| `IS_OUTGOING_REFERRAL` | `BOOLEAN` | is outgoing referral. | | `outgoing_referral` |
| `IS_REVIEW` | `BOOLEAN` | is review. | | `is_review` |
| `REFERRAL_REQUEST_SOURCE_CONCEPT_ID` | `UUID` | referral request source concept id. | FK->[Concept](Concept.md).CONCEPT_ID | `raw_concept_id` |
| `AGE_AT_EVENT` | `NUMBER` | age at event. | | `age_at_event` |
| `AGE_AT_EVENT_BABY` | `NUMBER` | age at event baby. | | -- |
| `AGE_AT_EVENT_NEONATE` | `NUMBER` | age at event neonate. | | -- |
| `RECORDED_DATE` | `TIMESTAMP` | recorded date. | | `date_recorded` |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. | | -- |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | record owner organisation code. | | -- |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. | | -- |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_NTZ` | The timestamp when the record was transformed by LDS into OLIDS. | - | -- |
| `VALUE` | `DOUBLE` | value. | | -- |
| `CODE_ID` | `VARCHAR` | code id. | | -- |

## Entity Relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

```mermaid
erDiagram
    ORG_PB["ORGANISATION<br>(publisher)"]
    ORG_PV["ORGANISATION<br>(provider)"]
    ORG_AU["ORGANISATION<br>(author)"]
    ORG_RQ["ORGANISATION<br>(requestor)"]
    ORG_RP["ORGANISATION<br>(recipient)"]

    CON_DATE["CONCEPT<br>(date precision)"]
    CON_PRTY["CONCEPT<br>(priority)"]
    CON_TYPE["CONCEPT<br>(type)"]
    CON_SPEC["CONCEPT<br>(specialty)"]
    CON_SRC["CONCEPT<br>(source)"]

    REFERRAL_REQUEST }o--|| ORG_PB: publisher_organisation_id
    REFERRAL_REQUEST }o--|| ORG_PV: provider_organisation_id
    REFERRAL_REQUEST }o--|| ORG_AU: author_organisation_id

    ORG_RQ ||--o{ REFERRAL_REQUEST: requestor_organisation_id
    ORG_RP ||--o{ REFERRAL_REQUEST: recipient_organisation_id
    PATIENT ||--o{ REFERRAL_REQUEST: patient_id
    PERSON ||--o{ REFERRAL_REQUEST: person_id

    PRACTITIONER ||--o{ REFERRAL_REQUEST: practitioner_id
    ENCOUNTER ||--o{ REFERRAL_REQUEST: encounter_id

    REFERRAL_REQUEST }o--|| CON_DATE: clinical_effective_date_precision_source_concept_id
    REFERRAL_REQUEST }o--|| CON_PRTY: referral_request_priority_source_concept_id
    REFERRAL_REQUEST }o--|| CON_TYPE: referral_request_type_source_concept_id
    REFERRAL_REQUEST }o--|| CON_SPEC: referral_request_specialty_source_concept_id
    REFERRAL_REQUEST }o--|| CON_SRC: referral_request_source_concept_id
    
```

| Related Table | Relationship Type | Local Key | Related Key | Notes |
| --- | --- | --- | --- | --- |
| [Patient](Patient.md) | FK | PATIENT_ID | ID | |
| [Person](Person.md) | FK | PERSON_ID | ID | |
| [Practitioner](Practitioner.md) | FK | PRACTITIONER_ID | ID | |
| [Encounter](Encounter.md) | FK | ENCOUNTER_ID | ID | |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID | - |
| [Organisation](Organisation.md) | FK | PROVIDER_ORGANISATION_ID | ID | - |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID | - |
| [Concept](Concept.md) | FK | CLINICAL_EFFECTIVE_DATE_PRECISION_SOURCE_CONCEPT_ID | CONCEPT_ID | - |
| [Concept](Concept.md) | FK | REFERRAL_REQUEST_SOURCE_CONCEPT_ID | CONCEPT_ID | - |
| [Concept](Concept.md) | FK | REFERRAL_REQUEST_PRIORITY_SOURCE_CONCEPT_ID | CONCEPT_ID | - |
| [Concept](Concept.md) | FK | REFERRAL_REQUEST_TYPE_SOURCE_CONCEPT_ID | CONCEPT_ID | - |
| [Concept](Concept.md) | FK | REFERRAL_REQUEST_SOURCE_CONCEPT_ID | CONCEPT_ID | - |

## Notes
