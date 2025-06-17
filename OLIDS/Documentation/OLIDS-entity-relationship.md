# OLIDS Entity Relationships

- [OLIDS Entity Relationships](#olids-entity-relationships)
  - [Overview](#overview)
  - [High-level entity relationships](#high-level-entity-relationships)
    - [Allergy Intolerance relations](#allergy-intolerance-relations)
    - [Appointment and Appointment Practitioner relations](#appointment-and-appointment-practitioner-relations)
    - [Diagnostic Order relations](#diagnostic-order-relations)
    - [Encounter relations](#encounter-relations)
    - [Episode of Care relations](#episode-of-care-relations)
    - [Flag relations](#flag-relations)
    - [Location, Location Contact relations](#location%2C-location-contact-relations)
    - [Medication Order relations](#medication-order-relations)
    - [Medication Statement relations](#medication-statement-relations)
    - [Observation relations](#observation-relations)
    - [Organisation relations](#organisation-relations)
    - [Patient and Person relations](#patient-and-person-relations)
      - [patient objects](#patient-objects)
      - [patient-event objects](#patient-event-objects)
    - [Practitioner and Practitioner in Role relations](#practitioner-and-practitioner-in-role-relations)
    - [Procedure Request relations](#procedure-request-relations)
    - [Referral Request relations](#referral-request-relations)
    - [Schedule and Schedule Practitioner relations](#schedule-and-schedule-practitioner-relations)


## Overview

This article describes the relationships betwen objects that exist within the One London Integrated Data Set (OLIDS)

## High-level entity relationships

The diagram below outlines the high-level relationships between table objects.

It is not possible to display all relationships in a single table, due to the number of relationships and overlaps that exist across commonly used entities such as concept, person and patient.

As such, we have broken the diagrams down into a view per table as below.

### Allergy Intolerance relations

:::mermaid
erDiagram
    PERSON ||--o{ ALLERGY_INTOLERANCE: person_id
    PATIENT ||--o{ ALLERGY_INTOLERANCE: patient_id
    PRACTITIONER ||--o{ ALLERGY_INTOLERANCE: practitioner_id
    ENCOUNTER ||--o{ ALLERGY_INTOLERANCE: encounter_id
    CONCEPT ||--o{ ALLERGY_INTOLERANCE: data_precision_concept_id
    CONCEPT ||--o{ ALLERGY_INTOLERANCE: allergy_intolerance_raw_concept_id
    ALLERGY_INTOLERANCE ||--o{ MEDICATION_ORDER: allergy_intolerance_id
    ALLERGY_INTOLERANCE ||--o{ MEDICATION_STATEMENT: allergy_intolerance_id 
:::

### Appointment and Appointment Practitioner relations

:::mermaid
erDiagram
    ORGANISATION ||--o{ APPOINTMENT: organisation_id
    PERSON ||--o{ APPOINTMENT: person_id
    PATIENT ||--o{ APPOINTMENT: patient_id
    PRACTITIONER_IN_ROLE ||--o{ APPOINTMENT: practitioner_in_role_id
    SCHEDULE ||--o{ APPOINTMENT: schedule_id
    CONCEPT ||--|{ APPOINTMENT: appointment_status_concept_id
    CONCEPT ||--|{ APPOINTMENT: booking_method_concept_id
    CONCEPT ||--|{ APPOINTMENT: contact_mode_concept_id
:::

### Diagnostic Order relations

:::mermaid
erDiagram
    PERSON ||--o{ DIAGNOSTIC_ORDER: person_id
    PATIENT ||--o{ DIAGNOSTIC_ORDER: patient_id
    ENCOUNTER ||--o{ DIAGNOSTIC_ORDER: encounter_id
    PRACTITIONER ||--o{ DIAGNOSTIC_ORDER: practitioner_id
    OBSERVATION ||--o{ DIAGNOSTIC_ORDER: parent_observation_id
    CONCEPT ||--o{ DIAGNOSTIC_ORDER: date_precision_concept_id
    CONCEPT ||--o{ DIAGNOSTIC_ORDER: diagnostic_order_raw_concpt_id
    CONCEPT ||--o{ DIAGNOSTIC_ORDER: episodicity_concept_id
    DIAGNOSTIC_ORDER ||--o{ MEDICATION_ORDER: allergy_intolerance_id
    DIAGNOSTIC_ORDER ||--o{ MEDICATION_STATEMENT: allergy_intolerance_id 
:::

### Encounter relations

:::mermaid
erDiagram
    PERSON ||--o{ ENCOUNTER: person_id
    PATIENT ||--o{ ENCOUNTER: patient_id
    PRACTITIONER ||--o{ ENCOUNTER: practitioner_id
    APPOINTMENT ||--o{ ENCOUNTER: appointment_id
    EPISODE_OF_CARE ||--o{ ENCOUNTER: episode_of_care_id
    ORGANISATION ||--o{ ENCOUNTER: service_provider_organisation_id
    CONCEPT ||--o{ ENCOUNTER: date_precision_concept_id
    CONCEPT ||--o{ ENCOUNTER: encounter_core_concept_id
    ENCOUNTER ||--o{ MEDICATION_ORDER: allergy_intolerance_id
    ENCOUNTER ||--o{ MEDICATION_STATEMENT: allergy_intolerance_id
    ENCOUNTER ||--o{ OBSERVATION: encounter_id
:::

### Episode of Care relations

:::mermaid
erDiagram
    PERSON ||--o{ EPISODE_OF_CARE: person_id
    PATIENT ||--o{ EPISODE_OF_CARE: patient_id
    CONCEPT ||--o{ EPISODE_OF_CARE: episode_type_raw_concept_id
    CONCEPT ||--o{ EPISODE_OF_CARE: episode_status_raw_concept_id
    PRACTITIONER ||--o{ EPISODE_OF_CARE: care_manager_practitioner_id
:::

### Flag relations

:::mermaid
erDiagram
    PERSON ||--o{ FLAG: person_id
    PATIENT ||--o{ FLAG: patient_id
:::

### Location, Location Contact relations

:::mermaid
erDiagram
    ORGANISATION ||--o{ LOCATION: managing_organisation_id
    LOCATION ||--o{ LOCATION_CONTACT: location_id
    CONCEPT ||--o{ LOCATION_CONTACT: contact_type_concept_id
    SCHEDULE }o--|| LOCATION: location_id
:::

### Medication Order relations

:::mermaid
erDiagram
    PERSON ||--o{ MEDICATION_ORDER: person_id
    PATIENT ||--o{ MEDICATION_ORDER: patient_id
    ENCOUNTER ||--o{ MEDICATION_ORDER: encounter_id
    PRACTITIONER ||--o{ MEDICATION_ORDER: practitioner_id
    OBSERVATION ||--o{ MEDICATION_ORDER: observation_id
    ORGANISATION ||--o{ MEDICATION_ORDER: organisation_id

    MEDICATION_ORDER }o--|| ALLERGY_INTOLERANCE: allergy_intolerance_id
    MEDICATION_ORDER }o--|| DIAGNOSTIC_ORDER: diagnostic_order_id
    MEDICATION_ORDER }o--|| REFERRAL_REQUEST: referral_request_id
    MEDICATION_ORDER }o--|| MEDICATION_STATEMENT: medication_statement_id
    MEDICATION_ORDER }o--|| CONCEPT: date_precision_concept_id
    CONCEPT ||--o{ MEDICATION_ORDER: medication_order_raw_concept_id
:::

### Medication Statement relations

:::mermaid
erDiagram
    PERSON ||--o{ MEDICATION_STATEMENT: person_id
    PATIENT ||--o{ MEDICATION_STATEMENT: patient_id
    ENCOUNTER ||--o{ MEDICATION_STATEMENT: encounter_id
    PRACTITIONER ||--o{ MEDICATION_STATEMENT: practitioner_id
    OBSERVATION ||--o{ MEDICATION_STATEMENT: observation_id
    ORGANISATION ||--o{ MEDICATION_STATEMENT: organisation_id

    MEDICATION_STATEMENT }o--|| ALLERGY_INTOLERANCE: allergy_intolerance_id
    MEDICATION_STATEMENT }o--|| DIAGNOSTIC_ORDER: diagnostic_order_id
    MEDICATION_STATEMENT }o--|| REFERRAL_REQUEST: referral_request_id
    MEDICATION_ORDER }o--|| MEDICATION_STATEMENT: medication_statement_id
    MEDICATION_STATEMENT }o--|| CONCEPT: date_precision_concept_id
    CONCEPT ||--o{ MEDICATION_STATEMENT: medication_statement_raw_concept_id
:::

### Observation relations

:::mermaid
erDiagram
    PATIENT ||--o{ OBSERVATION: patient_id
    ENCOUNTER ||--o{ OBSERVATION: encounter_id
    PRACTITIONER ||--o{ OBSERVATION: practitioner_id
    OBSERVATION ||--o{ OBSERVATION: parent_observation_id

    OBSERVATION }o--|| CONCEPT: date_precision_concept_id
    OBSERVATION }o--|| CONCEPT: result_value_unit_concept_id
    OBSERVATION }o--|| CONCEPT: observation_raw_concept_id
    OBSERVATION }o--|| CONCEPT: episodicity_concept_id
:::

### Organisation relations

:::mermaid
erDiagram
    ORGANISATION ||--o{ LOCATION: managing_organisation_id
    APPOINTMENT }o--|| ORGANISATION: organisation_id
    DIAGNOSTIC_ORDER }o--|| ORGANISATION: organisation_id
    ENCOUNTER }o--|| ORGANISATION: organisation_id
    EPISODE_OF_CARE }o--|| ORGANISATION: organisation_id
    ORGANISATION ||--o{ MEDICATION_ORDER: organisation_id
    ORGANISATION ||--o{ MEDICATION_STATEMENT: organisation_id
    ORGANISATION ||--o{ PRACTITIONER_IN_ROLE: organisation_id
    ORGANISATION ||--o{ REFERRAL_REQUEST: organisation_id
:::

### Patient and Person relations

#### patient objects

:::mermaid
erDiagram
    PATIENT_REGISTERED_PRACTITIONER_IN_ROLE }o--|| PATIENT: patient_id
    PATIENT_UPRN }o--|| PATIENT: patient_id

    PATIENT }o--|| ORGANISATION: registered_practice_id
    PATIENT }o--|| CONCEPT: gender_concept_id
    PATIENT ||--o{ PATIENT_ADDRESS: patient_id
    PATIENT ||--o{ PATIENT_CONTACT: patient_id
    PATIENT ||--o{ PATIENT_PERSON: patient_id
    PATIENT_PERSON }o--|| PERSON: person_id
:::

#### patient-event objects

:::mermaid
erDiagram
    PATIENT_REGISTERED_PRACTITIONER_IN_ROLE }o--|| PATIENT: patient_id
    PATIENT_UPRN }o--|| PATIENT: patient_id
    ALLERGY_INTOLERANCE }o--|| PATIENT: patient_id
    APPOINTMENT }o--|| PATIENT: patient_id
    DIAGNOSTIC_ORDER }o--|| PATIENT: patient_id
    ENCOUNTER }o--|| PATIENT: patient_id
    EPISODE_OF_CARE }o--|| PATIENT: patient_id

    PATIENT }o--|| ORGANISATION: registered_practice_id
    PATIENT }o--|| CONCEPT: gender_concept_id
    PATIENT ||--o{ PATIENT_ADDRESS: patient_id
    PATIENT ||--o{ PATIENT_CONTACT: patient_id
    PATIENT ||--o{ PATIENT_PERSON: patient_id
    PATIENT_PERSON }o--|| PERSON: person_id

    PATIENT ||--o{ MEDICATION_ORDER: patient_id
    PATIENT ||--o{ MEDICATION_STATEMENT: patient_id
    PATIENT ||--o{ OBSERVATION: patient_id
    PATIENT ||--o{ PROCEDURE_REQUEST: patient_id
    PATIENT ||--o{ REFERRAL_REQUEST: patient_id
:::

### Practitioner and Practitioner in Role relations

:::mermaid
erDiagram
    PRACTITIONER ||--o{ PRACTITIONER_IN_ROLE: practitioner_id
:::

### Procedure Request relations

:::mermaid
erDiagram
    PROCEDURE_REQUEST }o--|| PERSON: person_id
    PROCEDURE_REQUEST }o--|| PATIENT: patient_id
    PROCEDURE_REQUEST }o--|| ENCOUNTER: encounter_id
    PROCEDURE_REQUEST }o--|| PRACTITIONER: practitioner_id
    CONCEPT ||--o{ PROCEDURE_REQUEST: date_precision_concept_id
    CONCEPT ||--o{ PROCEDURE_REQUEST: procedure_raw_concept_id
    CONCEPT ||--o{ PROCEDURE_REQUEST: status_concept_id
:::

### Referral Request relations

:::mermaid
erDiagram
    REFERRAL_REQUEST }o--|| ORGANISATION: organisation_id
    REFERRAL_REQUEST }o--|| PERSON: person_id
    REFERRAL_REQUEST }o--|| PATIENT: patient_id
    REFERRAL_REQUEST }o--|| ENCOUNTER: encounter_id
    REFERRAL_REQUEST }o--|| PRACTITIONER: practitioner_id
    CONCEPT ||--o{ REFERRAL_REQUEST: date_precision_concept_id
    ORGANISATION ||--o{ REFERRAL_REQUEST: requester_organisation_id
    ORGANISATION ||--o{ REFERRAL_REQUEST: recipient_organisation_id
    CONCEPT ||--o{ REFERRAL_REQUEST: referral_request_raw_concept_id
:::

### Schedule and Schedule Practitioner relations

:::mermaid
erDiagram
    SCHEDULE }o--|| LOCATION: location_id
    PRACTITIONER ||--o{ SCHEDULE: practitioner_id
    SCHEDULE_PRACTITIONER }o--|| SCHEDULE: schedule_id
    SCHEDULE_PRACTITIONER }o--|| PRACTITIONER: practitioner_id
:::
