# OLIDS data dictionary

The tables below show the One London Integrated Data Set (OLIDS) schema definition.

## Contents

- [OLIDS data dictionary](#olids-data-dictionary)
  - [Contents](#contents)
  - [LDS_dataset_id](#lds_dataset_id)
  - [`[OLIDS_COMMON]` Schema](#olids_common-schema)
    - [allergy\_intolerance](#allergy_intolerance)
    - [appointment](#appointment)
    - [appointment\_practitioner](#appointment_practitioner)
    - [diagnostic\_order](#diagnostic_order)
    - [encounter](#encounter)
    - [episode\_of\_care](#episode_of_care)
    - [flag](#flag)
    - [location](#location)
    - [location\_contact](#location_contact)
    - [medication\_order](#medication_order)
    - [medication\_statement](#medication_statement)
    - [observation](#observation)
    - [organisation](#organisation)
    - [patient\_person](#patient_person)
    - [patient\_registered\_practitioner\_in\_role](#patient_registered_practitioner_in_role)
    - [practitioner](#practitioner)
    - [practitioner\_in\_role](#practitioner_in_role)
    - [procedure\_request](#procedure_request)
    - [referral\_request](#referral_request)
    - [schedule](#schedule)
    - [schedule\_practitioner](#schedule_practitioner)
  - [`[OLIDS_MASKED]` Schema](#olids_masked-schema)
    - [patient](#patient-masked)
    - [patient\_address](#patient_address-masked)
    - [patient\_contact](#patient_contact-masked)
    - [patient\_uprn](#patient_uprn-masked)
    - [person](#person-masked)
  - [`[OLIDS_PCD]` Schema](#olids_pcd-schema)
    - [patient](#patient)
    - [patient\_address](#patient_address)
    - [patient\_contact](#patient_contact)
    - [patient\_uprn](#patient_uprn)
    - [person](#person)
  - [`[OLIDS_TERMINOLOGY]` Schema](#olids_terminology-schema)
    - [concept](#concept)
    - [concept\_map](#concept_map)
  - [`[OLIDS_GOVERNANCE]` Schema](#olids_governance-schema)
    - [allocation](#allocation)   
  - [`[REFERENCE]` Schema](#reference-schema)
    - [postcode_hash](#postcode_hash)
  - [Ages](#ages)

## LDS_dataset_id

>[!NOTE]
>LDS assigned identifier for the source dataset

| LDS_dataset_id                          | dataset_name              |
|---------------------------------------|---------------------------|
| 07F337BD-E189-484A-9350-D9C6442AA829  |PrimaryCareTPP             |
| 6A62313A-7442-462E-B6E8-DEC541DDD0BA  | PrimaryCareEMIS           |
| 87C94392-B46F-484D-BF01-09E97EB9E506  | RegistrarPatientRequest   |
| E5F50BA6-32C8-482E-87D3-8EA629FACEAC  | RegistrarNDOORequest      |
| 39188746-F9CD-4246-9799-FAF6D3895B2E  | RegistrarAddressRequest   |
| 424ECE83-CA5E-4DFE-BB94-50F1A3BB1121  | RegistrarPatientResponse  |
| C26B7031-750D-4B75-A048-87A722F3F712  | RegistrarNDOOResponse     |
| 72AE46CB-F09E-4395-A977-F37EEC37916C  | RegistrarAddressResponse  |

## `[OLIDS_COMMON]` Schema

### allergy_intolerance

> [!NOTE]
>
> Risk of harmful or undesirable physiological response which is specific to an individual and associated with exposure to a substance. A record of a clinical assessment of an allergy or intolerance; a propensity, or a potential risk to an individual, to have an adverse reaction on future exposure to the specified substance, or class of substance.
>
> Where a propensity is identified, to record information or evidence about a reaction event that is characterised by any harmful or undesirable physiological response that is specific to the individual and triggered by exposure of an individual to the identified substance or class of substance.
>
> Substances include, but are not limited to: a therapeutic substance administered correctly at an appropriate dosage for the individual; food; material derived from plants or animals; or venom from insect stings.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  `none` |
| `ID` | uniqueidentifier | LDS assigned Unique Identifier for the business key of this table (unique allergy intolerance record) | `id` |
| `PATIENT_ID` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician in role that the activity is recorded against' | `practitioner_id` |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter this allergy was record in | `encounter_id` |
| `CLINICAL_STATUS` | varchar(20) | unmapped - prepared to match FHIR |  `clinical_status` |
| `VERIFICATION_STATUS` | varchar(20) | unmapped - prepared to match FHIR' |  |
| `CATEGORY` | varchar(20) | unmapped - prepared to match FHIR' |  |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the clinical code is recorded for | `clinical_effective_date` |
| `DATE_PRECISION_CONCEPT_ID` | uniqueidentifier | Identifies the precision of the clinical effectiveness date' | `date_precision_concept_id` |
| `IS_REVIEW` | bit | Is this instance of the code a review of a previous encounter | `is_review` |
| `MEDICATION_NAME` | varchar(255) | Reference to the clinical name of the medication the patient has an allergy to |  |
| `MULTI_LEX_ACTION` | varchar(25) |  | |
| `ALLERGY_INTOLERANCE_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the allergy provided by the supplier | `non_core_concept_id` |
| `AGE_AT_EVENT` | int | The age the patient was at the time of this event | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int |  The age the patient was at the time of this event. Shown in integer/whole years if the patient is one (1) years or older, else shown as a categorised (7001-7007) value representing an age category for babies under 1 years old. See [Ages](#ages) for more details. |  |
| `AGE_AT_EVENT_NEONATE` | int |The age the patient was at the time of this event if less than 28 days. Null where patient is older than 27 days. See [Ages](#ages) |  |
| `DATE_RECORDED` | datetime(3) |  The date the allergy was recorded | `date_recorded` |
| `IS_CONFIDENTIAL` | bit | True/False - is this allergy flagged as a confidential observation |  |
| `PERSON_ID` | uniqueidentifier |  Unique individual across all organisation |  `person_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | datetime that the business id value was first witnessed |  |
| `LDS_IS_DELETED` | bit | LDS flag standardising presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `allocation.lds_record_id` | each `allergy_intolerance` can have one to many `allocation` instructions (administrative object only) |
| `PATIENT_ID` | `patient.id` | one `patient` can have none to many `allergy_intolerance` items |
| `PRACTITIONER_ID` | `practitioner.id` | one `practitioner` can have none to many `allergy_intolerance` items |
| `ENCOUNTER_ID` | `encounter.id` | one `encounter` can have none to many `allergy_intolerance` items |
| `ALLERGY_INTOLERANCE_SOURCE_CONCEPT_ID` | `concept.id` | one `concept` can appear in one or many `allergy_intolerance` items |
| `PERSON_ID` | `person.id` | one `person` can have none to many `allergy_intolerance` items |

### appointment

> [!NOTE]
> A booking of a healthcare event among patient(s), practitioner(s), related person(s) and/or device(s) for a specific date/time. This may result in one or more Encounter(s).
> Appointment resources are used to provide information about a planned meeting that may be in the future or past. The resource only describes a single meeting, a series of repeating visits would require multiple appointment resources to be created for each instance. Examples include a scheduled surgery, a follow-up for a clinical visit, a scheduled conference call between clinicians to discuss a case (where the patient is a subject, but not a participant), the reservation of a piece of diagnostic equipment for a particular use, etc. The visit scheduled by an appointment may be in person or remote (by phone, video conference, etc.) All that matters is that the time and usage of one or more individuals, locations and/or pieces of equipment is being fully or partially reserved for a designated period of time.
> This definition takes the concepts of appointments in a clinical setting and also extends them to be relevant in the community healthcare space, and to ease exposure to other appointment / calendar standards widely used outside of healthcare.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | LDS assigned Unique Identifier for the business key of this table (unique allergy intolerance record) | `id` |
| `ORGANISATION_ID` | uniqueidentifier | Organisation ID at which the appointment occured | `organization_id` |
| `PATIENT_ID` | uniqueidentifier | The organisation’s record for this person’s registration. | `patient_id` |
| `PRACTITIONER_IN_ROLE_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `SCHEDULE_ID` | uniqueidentifier | The schedule the patient was put on to book multiple appointments. | `schedule_id` |
| `START_DATE` | datetime(3) | The start date of the appointment | `start_date` |
| `PLANNED_DURATION` | int | The time allocated for the appointment, not necessarily the actual duration (minutes) | `planned_duration` |
| `ACTUAL_DURATION` | int | Time between sent in and left (minutes) | `actual_duration` |
| `APPOINTMENT_STATUS_CONCEPT_ID` | uniqueidentifier | The status of the appointment e.g. arrived/sent in/left/DNA | `appointment_status_concept_id` |
| `PATIENT_WAIT` | int | How long the patient waited from being marked as arrived to being sent in | `patient_wait` |
| `PATIENT_DELAY` | int | How long the patient was delayed for | `patient_delay` |
| `DATE_TIME_BOOKED` | datetime(3) | Date and time the appointment booking was made |  |
| `DATE_TIME_SENT_IN` | datetime(3) | Date and time the patient was sent into the practitioner | `date_time_sent_in` |
| `DATE_TIME_LEFT` | datetime(3) | Date and time the patient left the practitioner | `date_time_left` |
| `CANCELLED_DATE` | datetime(3) | Date and time the appointment was cancelled (TPP only) | `cancelled_date` |
| `TYPE` | varchar(100) | Description of the slot type |  |
| `AGE_AT_EVENT` | int | The age the patient was at the time of this event |  |
| `AGE_AT_EVENT_BABY` | int | The age the patient was at the time of this event. Categorised for babies under 1 year old. |  |
| `AGE_AT_EVENT_NEONATE` | int | The age the patient was at the time of this event if less than 28 days |  |
| `BOOKING_METHOD_CONCEPT_ID` | uniqueidentifier | Method used to book the appointment |  |
| `CONTACT_MODE_CONCEPT_ID` | uniqueidentifier | Appointment mode of contact – e.g. telephone |  |
| `IS_BLOCKED` | bit | Indicates whether the appointment slot is blocked |  |
| `NATIONAL_SLOT_CATEGORY_NAME` | varchar(900) | The name of the national slot category |  |
| `CONTEXT_TYPE` | varchar(100) | The national slot category context type |  |
| `SERVICE_SETTING` | varchar(100) | The national slot category service setting |  |
| `NATIONAL_SLOT_CATEGORY_DESCRIPTION` | varchar(900) | The description of the national slot category |  |
| `CSDS_CARE_CONTACT_IDENTIFIER` | varchar(17) | A link to the commissioning dataset care contact identifier for community services |  |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that converted the data |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first received by LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardising presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `ALLOCATION.LDS_RECORD_ID` | Each `ALLERGY_INTOLERANCE` can have one to many `ALLOCATION` instructions (administrative object only) |
| `PATIENT_ID` | `PATIENT.ID` | One `PATIENT` can have none to many `ALLERGY_INTOLERANCE` items |
| `PRACTITIONER_IN_ROLE_ID` | `PRACTITIONER_IN_ROLE.ID` | One `PRACTITIONER_IN_ROLE` can have none to many `APPOINTMENT` items |
| `SCHEDULE_ID` | `SCHEDULE.ID` | One `SCHEDULE` can have none to many `APPOINTMENT` items |
| `APPOINTMENT_STATUS_CONCEPT_ID` | `CONCEPT.ID` | Each `CONCEPT` can appear in none to many `APPOINTMENT` items |
| `BOOKING_METHOD_CONCEPT_ID` | `CONCEPT.ID` | Each `CONCEPT` can appear in none to many `APPOINTMENT` items |
| `CONTACT_MODE_CONCEPT_ID` | `CONCEPT.ID` | Each `CONCEPT` can appear in none to many `APPOINTMENT` items |
| `PERSON_ID` | `PERSON.ID` | Each `PERSON` can have none to many `APPOINTMENT` items |

### appointment_practitioner

> [!NOTE]
> List of practitioner participants involved in the appointment

> [!TIP]
> This table has been added to OLIDS to allow for one-to-many cardinality between appointments and practitioners which was permitted in some source datasets.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | LDS assigned Unique Identifier for the business key of this table | `id` |
| `APPOINTMENT_ID` | uniqueidentifier | Unique Identifier for the appointment | `organization_id` |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `ALLOCATION.LDS_RECORD_ID` | Each `ALLERGY_INTOLERANCE` can have one to many `ALLOCATION` instructions (administrative object only) |
| `APPOINTMENT_ID` | `APPOINTMENT.ID` | One `APPOINTMENT` can have one to many `APPOINTMENT_PRACTITIONER` items |
| `PRACTITIONER_ID` | `PRACTITIONER.ID` | One `PRACTITIONER` can have none to many `APPOINTMENT_PRACTITIONER` items |

### diagnostic_order

> [!NOTE]
> A record of a request for service such as diagnostic investigations, treatments, or operations to be performed.
>
> This represents an order or proposal or plan to perform a diagnostic or other service on or for a patient. It represents a proposal or plan or order for a service to be performed that would result in a Procedure or Diagnostic Report, which in turn may reference one or more Observations, which summarize the performance of the procedures and associated documentation such as observations, images, findings that are relevant to the treatment/management of the subject. This resource may be used to share relevant information required to support a referral or a transfer of care request from one practitioner or organization to another when a patient is required to be referred to another provider for a consultation /second opinion and/or for short term or longer term management of one or more health issues or problems.
>
> The resource allows requesting only a single procedure. If a workflow requires requesting multiple procedures simultaneously, this is done using multiple instances of this resource.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | LDS assigned Unique Identifier for the business key of this table (unique allergy intolerance record) | `id` |
| `PATIENT_ID` | uniqueidentifier | The organisation’s record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter the observation was recorded at | `encounter_id` |
| `PRACTITIONER_ID` | uniqueidentifier | Reference to the practitioner that recorded the order | `practitioner_id` |
| `PARENT_OBSERVATION_ID` | uniqueidentifier | Reference to the parent observation in a complex observation (e.g., systolic & diastolic BP) | `parent_observation_id` |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the diagnostic order was identified by a clinician | `clinical_effective_date` |
| `DATE_PRECISION_CONCEPT_ID` | uniqueidentifier | Identifies the precision of the clinical effectiveness date | `date_precision_concept_id` |
| `RESULT_VALUE` | float | The value of the result of the observation | `result_value` |
| `RESULT_VALUE_UNITS_CONCEPT_ID` | uniqueidentifier | Concept ID for the units of the result of the observation | `result_value_units_concept_id` |
| `RESULT_DATE` | date(0) | The date of the result | `result_date` |
| `RESULT_TEXT` | varchar(8000) | Any text associated with the result | `result_text` |
| `IS_PROBLEM` | bit | Whether the observation is marked as a problem | `is_problem` |
| `IS_REVIEW` | bit | Whether the observation is a review of an existing problem | `is_review` |
| `PROBLEM_END_DATE` | datetime(3) | The end date of the problem | `problem_end_date` |
| `DIAGNOSTIC_ORDER_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the result provided by the supplier | `raw_concept_id` |
| `AGE_AT_EVENT` | int | The age of the patient at the time of the observation | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int | The age the patient was at the time of this event; categorised for babies under 1 year | `age_at_event_baby` |
| `AGE_AT_EVENT_NEONATE` | int | The age the patient was at the time of this event if less than 28 days | `age_at_event_neonate` |
| `EPISODICITY_CONCEPT_ID` | uniqueidentifier | Indicates the episodicity of the observation | `episodicity_concept_id` |
| `IS_PRIMARY` | bit | Will be false if the observation has a parent observation | `is_primary` |
| `DATE_RECORDED` | datetime(3) | Date the diagnostic order was recorded in the clinical system | `date_recorded` |
| `IS_DELETED` | bit | True/false — is the record in a deleted state |  |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `ALLOCATION.LDS_RECORD_ID` | Each `ALLERGY_INTOLERANCE` can have one to many `ALLOCATION` instructions (administrative object only) |
| `PATIENT_ID` | `PATIENT.ID` | One `PATIENT` can have none to many `DIAGNOSTIC_ORDER` items |
| `ENCOUNTER_ID` | `ENCOUNTER.ID` | One `ENCOUNTER` can have none to many `DIAGNOSTIC_ORDER` items |
| `PRACTITIONER_ID` | `PRACTITIONER.ID` | One `PRACTITIONER` can have none to many `DIAGNOSTIC_ORDER` items |
| `PARENT_OBSERVATION_ID` | `OBSERVATION.ID` | One `OBSERVATION` can be a parent to none to many `DIAGNOSTIC_ORDER` items |
| `DATE_PRECISION_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referred to by none to many `DIAGNOSTIC_ORDER` items |
| `EPISODICITY_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referred to by none to many `DIAGNOSTIC_ORDER` items |
| `PERSON_ID` | `PERSON.ID` | One `PERSON` can have none to many `DIAGNOSTIC_ORDER` items |

### encounter

> [!NOTE]
> An interaction between a patient and healthcare provider(s) for the purpose of providing healthcare service(s) or assessing the health status of a patient.
>
> A patient encounter is further characterized by the setting in which it takes place. Amongst them are ambulatory, emergency, home health, inpatient and virtual encounters. An Encounter encompasses the lifecycle from pre-admission, the actual encounter (for ambulatory encounters), and admission, stay and discharge (for inpatient encounters). During the encounter the patient may move from practitioner to practitioner and location to location.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique ID of the encounter | `id` |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `PATIENT_ID` | uniqueidentifier | The organisation’s record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `APPOINTMENT_ID` | uniqueidentifier | Reference to the appointment this encounter took part on | `appointment_id` |
| `EPISODE_OF_CARE_ID` | uniqueidentifier | The episode of care under which this encounter occurred | `episode_of_care_id` |
| `SERVICE_PROVIDER_ORGANISATION_ID` | uniqueidentifier | Reference to the service provider organisation of the encounter | `service_provider_organisation_id` |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the clinical code is recorded for | `clinical_effective_date` |
| `DATE_PRECISION_CONCEPT_ID` | int | Reference to the precision of the date of the encounter | `date_precision_concept_id` |
| `LOCATION` | varchar(200) | Reference to the location that the encounter took place at | `institution_location_id` |
| `ENCOUNTER_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the type of encounter | `non_core_concept_id` |
| `AGE_AT_EVENT` | int | The age the patient was when this encounter took place | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int | Age in integer years if ≥1; else categorised for babies under 1 year |  |
| `AGE_AT_EVENT_NEONATE` | int | Age if less than 28 days; null if patient >27 days |  |
| `TYPE` | varchar(50) | Reference to the type of encounter | `type` |
| `SUB_TYPE` | varchar(50) | Reference to the sub-type of the encounter | `sub_type` |
| `ADMISSION_METHOD` | varchar(40) | The admission method of the encounter | `admission_method` |
| `END_DATE` | datetime(3) | The end date of the encounter | `end_date` |
| `DATE_RECORDED` | datetime(3) | The date the encounter was recorded | `date_recorded` |
| `IS_DELETED` | bit | True/false — is the record deleted |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `ALLOCATION.LDS_RECORD_ID` | Each `ENCOUNTER` can have one to many `ALLOCATION` instructions (administrative object only) |
| `PERSON_ID` | `PERSON.ID` | One `PERSON` can have none to many `ENCOUNTER` items |
| `PATIENT_ID` | `PATIENT.ID` | One `PATIENT` can have none to many `ENCOUNTER` items |
| `PRACTITIONER_ID` | `PRACTITIONER.ID` | One `PRACTITIONER` can have none to many `ENCOUNTER` items |
| `APPOINTMENT_ID` | `APPOINTMENT.ID` | One `APPOINTMENT` can have none to many `ENCOUNTER` items |
| `EPISODE_OF_CARE_ID` | `EPISODE_OF_CARE.ID` | One `EPISODE_OF_CARE` can have none to many `ENCOUNTER` items |
| `SERVICE_PROVIDER_ORGANISATION_ID` | `ORGANISATION.ID` | One `ORGANISATION` can have none to many `ENCOUNTER` items |
| `DATE_PRECISION_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referenced by none to many `ENCOUNTER` items |
| `ENCOUNTER_SOURCE_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referenced by none to many `ENCOUNTER` items |

### episode_of_care

> [!NOTE]
> An association between a patient and an organisation / healthcare provider(s) during which time encounters may occur. The managing organisation assumes a level of responsibility for the patient during this time.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique ID of the encounter event | `id` |
| `ORGANISATION_ID` | uniqueidentifier | organisation at which the episode of care took place | `organization_id` |
| `PATIENT_ID` | uniqueidentifier | The patient this event belongs to | `patient_id` |
| `PERSON_ID` | uniqueidentifier | The person this event belongs to | `person_id` |
| `EPISODE_TYPE_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the registration type of the patient | `registration_type_concept_id` |
| `EPISODE_STATUS_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the registration status of the patient | `registration_status_concept_id` |
| `EPISODE_OF_CARE_START_DATE` | datetime(3) | The date the episode of care started | `date_registered` |
| `EPISODE_OF_CARE_END_DATE` | datetime(3) | The date the episode of care ended | `date_registered_end` |
| `CARE_MANAGER_PRACTITIONER_ID` | uniqueidentifier | Reference to the usual GP for this episode of care | `usual_gp_practitioner_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

*Foreign keys:*

| column | target | cardinality |
| :--- | :--- | :--- |
| `LDS_RECORD_ID` | `ALLOCATION.LDS_RECORD_ID` | Each `ENCOUNTER` can have one to many `ALLOCATION` instructions (administrative object only) |
| `PATIENT_ID` | `PATIENT.ID` | One `PATIENT` can have none to many `EPISODE_OF_CARE` items |
| `PERSON_ID` | `PERSON.ID` | One `PERSON` can have none to many `EPISODE_OF_CARE` items |
| `EPISODE_TYPE_SOURCE_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referenced by none to many `EPISODE_OF_CARE` items |
| `EPISODE_STATUS_SOURCE_CONCEPT_ID` | `CONCEPT.ID` | One `CONCEPT` can be referenced by none to many `EPISODE_OF_CARE` items |
| `CARE_MANAGER_PRACTITIONER_ID` | `PRACTITIONER.ID` | One `PRACTITIONER` can be a care manager in none to many `EPISODE_OF_CARE` items |

### flag

> [!NOTE]
> prospective warnings of potential issues when providing care to the patient
>
> A flag is a warning or notification of some sort presented to the user - who may be a clinician or some other person involved in patient care. It usually represents something of sufficient significance to warrant a special display of some sort - rather than just a note in the resource

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique ID of the flag | `id` |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `PATIENT_ID` | uniqueidentifier | The organisation’s record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `EFFECTIVE_DATE` | datetime(3) | The date the flag was effective from onto the patient’s record | `effective_date` |
| `EXPIRED_DATE` | datetime(3) | The expiry date of the flag |  |
| `IS_ACTIVE` | bit | Whether the flag is active or not | `is_active` |
| `FLAG_TEXT` | varchar(8000) | This is a warning set by the publisher regarding the patient | `flag_text` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### location

>[!NOTE]
> Details and position information for a place where services are provided and resources and participants may be stored, found, contained, or accommodated.
>
> A Location includes both incidental locations (a place which is used for healthcare without prior designation or authorization) and dedicated, formally appointed locations. Locations may be private, public, mobile or fixed and scale from small freezers to full hospital buildings or parking garages.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique ID of the location | `id` |
| `NAME` | varchar(100) | The name of a location set by the publisher. E.g. ward, clinic, domiciliary | `name` |
| `TYPE_CODE` | uniqueidentifier | The type of location | `type_code` |
| `TYPE_DESC` | varchar(50) | Textual description of the type of location e.g. GP Practice | `type_desc` |
| `IS_PRIMARY_LOCATION` | bit | True/false - is this the primary location of the parent organisation |  |
| `HOUSE_NAME` | nvarchar | Location property name |  |
| `HOUSE_NUMBER` | nvarchar | Location property number |  |
| `HOUSE_NAME_FLAT_NUMBER` | nvarchar | Location property number |  |
| `STREET` | nvarchar | Location street/road name |  |
| `ADDRESS_LINE_1` | nvarchar | Location address line 1 |  |
| `ADDRESS_LINE_2` | nvarchar | Location address line 2 |  |
| `ADDRESS_LINE_3` | nvarchar | Location address line 3 |  |
| `ADDRESS_LINE_4` | nvarchar | Location address line 4 |  |
| `POSTCODE` | varchar(200) | Location postcode | `postcode` |
| `MANAGING_ORGANISATION_ID` | uniqueidentifier | Reference to the parent organisation of the location | `managing_organization_id` |
| `OPEN_DATE` | date(0) | Location opening date |  |
| `CLOSE_DATE` | date(0) | Location closing date (if applicable) |  |
| `IS_OBSOLETE` | bit | True/false - is the location closed |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | Does not exist for this table but included for consistency |  |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### location_contact

> [!NOTE]
> The contact details of communication devices available at the location. This can include addresses, phone numbers, fax numbers, mobile numbers, email addresses and web sites.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique Identifier for this location contact |  |
| `LOCATION_ID` | uniqueidentifier | Reference to the location |  |
| `IS_PRIMARY_CONTACT` | bit | True/false - is this the primary contact for the location |  |
| `CONTACT_TYPE` | varchar(50) | Type of contact (Telephone, Fax, Email) |  |
| `CONTACT_TYPE_CONCEPT_ID` | uniqueidentifier | Type of contact (Telephone, Fax, Email) |  |
| `VALUE` | nvarchar | The value of the contact information e.g., phone number, email address |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### medication_order

> [!NOTE]
> An order or request for both supply of the medication and the instructions for administration of the medication to a patient
>
> This resource covers all type of orders for medications for a patient. This includes inpatient medication orders as well as community orders (whether filled by the prescriber or by a pharmacy). It also includes orders for over-the-counter medications (e.g. Aspirin), total parenteral nutrition and diet/ vitamin supplements. It may be used to support the order of medication-related devices e.g., prefilled syringes such as patient-controlled analgesia (PCA) syringes, or syringes used to administer other types of medications. e.g., insulin, narcotics.
>
>It is not intended for use in prescribing particular diets, or for ordering non-medication-related items (eyeglasses, supplies, etc.). In addition, the MedicationRequest may be used to report orders/request from external systems that have been reported for informational purposes and are not authoritative and are not expected to be acted upon (e.g. dispensed or administered)

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version |  |
| `ID` | uniqueidentifier | Unique ID of the medication order | `id` |
| `ORGANISATION_ID` | uniqueidentifier | the organisation that initiated the medication order or request and has responsibility for its activation | `organization_id` |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `PATIENT_ID` | uniqueidentifier | The organisation’s record for this person’s registration | `patient_id` |
| `MEDICATION_STATEMENT_ID` | uniqueidentifier | Reference to the medication statement. A medication statement can have many medication orders | `medication_statement_id` |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter the medication order was issued in |  |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `OBSERVATION_ID` | uniqueidentifier | Reference to the observation that required the medication order |  |
| `ALLERGY_INTOLERANCE_ID` | uniqueidentifier | Reference to allergy intolerance observations attached to this medication order |  |
| `DIAGNOSTIC_ORDER_ID` | uniqueidentifier | Reference to diagnostic order observations attached to this medication order |  |
| `REFERRAL_REQUEST_ID` | uniqueidentifier | Reference to referral requests attached to this medication order |  |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the medication order was issued | `clinical_effective_date` |
| `DATE_PRECISION_CONCEPT_ID` | uniqueidentifier | Identifies the precision of the clinical effectiveness date | `date_precision_concept_id` |
| `DOSE` | varchar(1000) | Textual description of the dose | `dose` |
| `QUANTITY_VALUE` | float | The value of the medication that was prescribed e.g., 50 | `quantity_value` |
| `QUANTITY_UNIT` | varchar(255) | The unit of the medication that was prescribed e.g., tablets | `quantity_unit` |
| `DURATION_DAYS` | int | How many days the medication is prescribed for | `duration_days` |
| `ESTIMATED_COST` | float | The estimated cost of the medication | `estimated_cost` |
| `MEDICATION_NAME` | varchar(500) | The name of the medication in the order |  |
| `MEDICATION_ORDER_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the medication provided by the supplier | `non_core_concept_id` |
| `BNF_REFERENCE` | varchar(10) | Reference to the clinical coding of the medication | `bnf_reference` |
| `AGE_AT_EVENT` | int | The age the patient was at the time of this event | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int | Age categorisation for babies under 1 year |  |
| `AGE_AT_EVENT_NEONATE` | int | Age of the patient if less than 28 days, else a calculated category |  |
| `ISSUE_METHOD` | varchar(8000) | The issue method of the medication e.g., handwritten | `issue_method` |
| `DATE_RECORDED` | datetime(3) | Date the medication order was recorded | `date_recorded` |
| `IS_CONFIDENTIAL` | bit | True/false - is the medication order flagged as confidential |  |
| `IS_DELETED` | bit | True/false - is the record deleted |  |
| `ISSUE_METHOD_DESCRIPTION` | varchar | Description of the issue method |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### medication_statement

> [!NOTE]
> A record of a medication that is being consumed by a patient. A Medication Statement may indicate that the patient may be taking the medication now or has taken the medication in the past or will be taking the medication in the future. The source of this information can be the patient, significant other (such as a family member or spouse), or a clinician. A common scenario where this information is captured is during the history taking process during a patient visit or stay. The medication information may come from sources such as the patient's memory, from a prescription bottle, or from a list of medications the patient, clinician or other party maintains.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the medication | `id` |
| `ORGANISATION_ID` | uniqueidentifier | Author of the medication statement | `organization_id` |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | `person_id` |
| `PATIENT_ID` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter this medication was recorded in | `encounter_id` |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `OBSERVATION_ID` | uniqueidentifier | Reference to the observation that required the medication order | |
| `ALLERGY_INTOLERANCE_ID` | uniqueidentifier | Reference to allergy intolerance observations attached to this medication order |  |
| `DIAGNOSTIC_ORDER_ID` | uniqueidentifier | Reference to diagnostic order observations attached to this medication order |  |
| `REFERRAL_REQUEST_ID` | uniqueidentifier | Reference to referral requests attached to this medication order |  |
| `AUTHORISATION_TYPE_CONCEPT_ID` | int | Reference to the authorisation type | `authorisation_type_concept_id` |
| `DATE_PRECISION_CONCEPT_ID` | int | Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14) | `date_precision_concept_id` |
| `MEDICATION_STATEMENT_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the medication provided by the supplier | `non_core_concept_id` |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the medication was clinical relevant | `clinical_effective_date` |
| `CANCELLATION_DATE` | datetime(3) | The date the medication was cancelled | `cancellation_date` |
| `DOSE` | varchar(1000) | Textual description of the dose of the medication | `dose` |
| `QUANTITY_VALUE_DESCRIPTION` | varchar(500) | The value of the medication that was prescribed eg 50 |  |
| `QUANTITY_VALUE` | float | The value of the medication that was prescribed eg 50 | `quantity_value` |
| `QUANTITY_UNIT` | varchar(255) | The unit of the medication that was prescribed eg tablets | `quantity_unit` |
| `MEDICATION_NAME` | varchar(500) | The name of the medication attached to the statement |  |
| `BNF_REFERENCE` | varchar(10) | A reference to the drug in the BNF dictionary | `bnf_reference` |
| `AGE_AT_EVENT` | int | The age the patient was at the time of this event | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int | The age the patient was at the time of this event. Shown in integer/whole years if the patient is one (1) years or older, else shown as a categorised (7001-7007) value representing an age category for babies under 1 years old | |
| `AGE_AT_EVENT_NEONATE` | int | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |
| `ISSUE_METHOD` | varchar(8000) | The issue method of the medication eg hand written | `issue_method` |
| `DATE_RECORDED` | datetime(3) | Date the medication statement was recorded | `date_recorded` |
| `IS_ACTIVE` | bit | Is the record active |  |
| `IS_CONFIDENTIAL` | bit | True/false - is the statement marked as confidential/sensitive |  |
| `EXPIRY_DATE` | datetime | Expiry date of drug | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### observation

> [!NOTE]
> Measurements and simple assertions made about a patient, device or other subject
>
> Observations are a central element in healthcare, used to support diagnosis, monitor progress, determine baselines and patterns and even capture demographic characteristics, as well as capture results of tests performed on products and substances. Most observations are simple name/value pair assertions with some metadata, but some observations group other observations together logically, or even are multi-component observations.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the observation | `id` |
| `PATIENT_ID` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `PERSON_ID` | uniqueidentifier | The unique reference for the person | `person_id` |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter the observation was recorded at | `encounter_id` |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the activity is recorded against | `practitioner_id` |
| `PARENT_OBSERVATION_ID` | uniqueidentifier | Reference to the parent observation in a complex observation eg systolic and diastolic blood pressures will have a parent observation of Blood pressure | `parent_observation_id` |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the observation was identified by a clinician | `clinical_effective_date` |
| `DATE_PRECISION_CONCEPT_ID` | uniqueidentifier | Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14) | `date_precision_concept_id` |
| `RESULT_VALUE` | float | The value of the result of the observation | `result_value` |
| `RESULT_VALUE_UNITS_CONCEPT_ID` | uniqueidentifier | The units of the result of the observation | `result value units` |
| `RESULT_DATE` | date(0) | The date of the result | `result_date` |
| `RESULT_TEXT` | varchar(8000) | Any text associated with the result | `result_text` |
| `IS_PROBLEM` | bit | Whether the observation is marked as a problem | `is_problem` |
| `IS_REVIEW` | bit | Whether the observation is a review of an existing problem | `is_review` |
| `PROBLEM_END_DATE` | datetime(3) | The end date of the problem | `problem_end_date` |
| `OBSERVATION_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the observation provided by the supplier | `non_core_concept_id` |
| `AGE_AT_EVENT` | int | The age of the patient at the time of the observation in whole integer years | `age_at_event` |
| `AGE_AT_EVENT_BABY` | int | The age the patient was at the time of this event. Shown in integer/whole years if the patient is one (1) years or older, else shown as a categorised (7001-7007) value representing an age category for babies under 1 years old | |
| `AGE_AT_EVENT_NEONATE` | int | The age of the patient at the time of the observation | `age_at_event` |
| `EPISODICITY_CONCEPT_ID` | bigint | Reference to the episodicity of the problem eg First, review, flare | `episodicity_concept_id` |
| `IS_PRIMARY` | bit | Whether the observation is a primary observation | `is_primary` |
| `DATE_RECORDED` | datetime(3) | The date the observation was recorded in the system | `date_recorded` |
| `IS_PROBLEM_DELETED` | bit | true/false - whether the problem relating to the observation is deleted |  |
| `IS_CONFIDENTIAL` | bit | true/false - is the observation marked as confidential/sensitive |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### organisation

> [!NOTE]
> A formally or informally recognized grouping of people or organisations formed for the purpose of achieving some form of collective action. Includes companies, institutions, corporations, departments, community groups, healthcare practice groups etc.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | 'Unique ID of the organisation' | `id` |
| `ORGANISATION_CODE` | varchar(255) | Organisation Code | `ods_code` |
| `ASSIGNING_AUTHORITY_CODE` | varchar(255) | The assigning authority of the organisation code |  |
| `NAME` | varchar(255) | 'Name of the organisation' | `name` |
| `TYPE_CODE` | int | 'The type of organisation' | `type_code` |
| `TYPE_DESC` | varchar(255) | 'The type of organisation' | `type_desc` |
| `POSTCODE` | varchar(200) | 'The postcode of the organisation' | `postcode` |
| `PARENT_ORGANISATION_ID` | uniqueidentifier | The id of the parent organisation | `parent_organization_id` |
| `OPEN_DATE` | date(0) | Date the organisation opened (minimum of operational or legal dates) |  |
| `CLOSE_DATE` | date(0) | Date the organisation closed (maximum of operational or legal dates) |  |
| `IS_OBSOLETE` | bit | Is the organisation closed |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access.<br>*This will be null for this table, as this table contains shared reference data only*. | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### patient (masked)

> [!NOTE]
> Demographics and other administrative information about an individual or animal receiving care or other health-related services.
>
> note that this encompasses an anonymous in context (pseudonymised) representation of patients. Additionally, a single person can exist as many patients undergoing separate episodes of care at differing healthcare provider services. A patient represents a single person undergoing care at one or more specific healthcare providers, typically assigned a local system patient identifier or patient administration system number.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the patient | `id` |
| `NHS_NUMBER_HASH` | binary(32) | internal irreversible hash of the patient NHS number |  |
| `SK_PATIENT_ID` | int | Consistent LDS pseudonym for secondary care planning purposes |  |
| `TITLE` | varchar(50) | 'The title of the patient' |  |
| `GENDER_CONCEPT_ID` | uniqueidentifier | 'Reference to the gender of the patient' |  |
| `REGISTERED_PRACTICE_ID` | uniqueidentifier | LDS assigned identifier for patient's registered practice |  |
| `BIRTH_YEAR` | int | year of the date of birth |  |
| `BIRTH_MONTH` | int | month of the date of birth |  |
| `DEATH_YEAR` | int | year of the date of death |  |
| `DEATH_MONTH` | int | month of the date of death |  |
| `IS_CONFIDENTIAL` | bit | true/false - is the observation marked as confidential/sensitive |  |
| `IS_DUMMY_PATIENT` | bit | true/false - is the patient flagged or denoted as a test patient in the source system |  |
| `IS_SPINE_SENSITIVE` | bit | true/false - is the patient marked as spine sensitive within the source system. **Important note: This column is sourced from local practice systems, and may not reflect values held within the PDS spine service. It is not advised to use this column to inform sensitivity filtering policies.** |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access. | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS. **Note: this column is absent in source CDM for this table (to be corrected).** |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### patient_address (masked)

> [!NOTE]
> An address for the individual patient

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | 'Unique ID of the address' | `id` |
| `PATIENT_ID` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | `patient_id` |
| `ADDRESS_TYPE_CONCEPT_ID` | uniqueidentifier | Type of address (i.e. Temporary, Correspondence only, Home) | `use_concept_id` |
| `POSTCODE_HASH` | binary(32) | The postcode of the address - hashed | `postcode` |
| `START_DATE` | datetime(3) | The start date of this address being relevant | `start_date` |
| `END_DATE` | datetime(3) | The end date of this address being relevant | `end_date` |
| `PERSON_ID` | uniqueidentifier | The Unique Identifier for the person | `person_id` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access. | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS. **Note: this column is absent in source CDM for this table (to be corrected).** |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record. **Note this column is currently absent, but will be added in a later release**. | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### patient_contact (masked)

> [!NOTE]
> telecommunication contact details for the patient.
>
> note that this is the anonymous in context (pseudonymised) edition of the contact information and as a result will merely show the presence of a communication method with no details of the contact itself.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | 'Unique ID of the patient contact' | `id` |
| `PERSON_ID` | uniqueidentifier | 'Unique individual across all organisations' | `person_id` |
| `PATIENT_ID` | varchar(255) | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' | `patient_id` |
| `DESCRIPTION` | varchar(255) | <to be confirmed> |  |
| `CONTACT_TYPE_CONCEPT_ID` | varchar(255) | use of contact (e.g. mobile, home, work) (Combines type into single concept) | `use_concept_id` |
| `START_DATE` | varchar(255) | 'The start date of the contact being valid' | `start_date` |
| `END_DATE` | varchar(255) | 'The end date of the contact being valid' | `end_date` |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access. | `organization_id` |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS. **Note: this column is absent in source CDM for this table (to be corrected).** |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record. | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_END_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### patient_person

> [!NOTE]
> relationship bridging table between patient and person

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique Identifier for the patient to practitioner relationship |  |
| `PATIENT_ID` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  |
| `PERSON_ID` | uniqueidentifier | 'Unique individual across all organisations' |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record. | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

### patient_registered_practitioner_in_role

> [!NOTE]
> Denotes the patients registered healthcare professional responsible for their care.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique Identifier for the patient to practitioner relationship | |
| `PERSON_ID` | uniqueidentifier | 'Unique individual across all organisations' | |
| `PATIENT_ID` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' | |
| `ORGANISATION_ID` | uniqueidentifier | 'Owning organisation (i.e. publisher)' | |
| `PRACTITIONER_ID` | uniqueidentifier | The clinician the episode of care is registered under | |
| `EPISODE_OF_CARE_ID` | uniqueidentifier | The episode of care (registration to service provider) that the patient is recorded under with this practitioner/clinician | |
| `START_DATE` | datetime(3) | Start date of the relationship between patient and practitioner | |
| `END_DATE` | datetime(3) | End date of the relationship between patient and practitioner | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that conducted interchange protocol conversion of the data from incoming batch into existing held data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### patient_uprn (masked)

> [!NOTE]
> unique property reference details from address matching of the supplied patient address details

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the patient UPRN match | |
| `REGISTRAR_EVENT_ID` | uniqueidentifier | LDS processing event identifier for the processing of the UPRN match. (*this is now duplicated by an audit column below and will be removed*) | |
| `MASKED_UPRN` | varchar(255) | The matched unique property reference number, with hashing applied | |
| `MASKED_UPSN` | varchar(255) | The matched unique street reference number, with hashing applied | |
| `MASKED_POSTCODE` | varchar(255) | The masked input postcode | |
| `ADDRESS_FORMAT_QUALITY` | varchar(255) | The quality of the input address (i.e. 'good') | |
| `POSTCODE_QUALITY` | varchar(255) | The quality of the input postcode (i.e. 'good') | |
| `MATCHED_WITH_ASSIGN` | varchar(255) | True/false - was a match possible | |
| `QUALIFIER` | varchar(255) | Type of matched address (residential, child) | |
| `UPRN_PROPERTY_CLASSIFICATION` | varchar(255) | <to be confirmed> | |
| `ALGORITHM` | varchar(255) | <to be confirmed> | <to be confirmed> |
| `MATCH_PATTERN` | varchar(255) | <to be confirmed> | <to be confirmed> |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_REGISTRAR_EVENT_ID` | uniqueidentifier | LDS processing event identifier for the processing of the UPRN match | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access.<br>*This will be null for this table*. | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS. *This will be null for this table.* | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record. | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### person (masked)

> [!NOTE]
> harmonised person details extracted from person demographics services (PDS), or presented as a stub of known details where no PDS entry is found.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Reference to the patient identifier | |
| `REQUESTING_PATIENT_RECORD_ID` | uniqueidentifier | Reference to the patient record that was used to trace the patient details | |
| `UNIQUE_REFERENCE` | uniqueidentifier | Unique request reference of the submission made to PDS | |
| `REQUESTING_NHS_NUMBER_HASH` | binary(32) | The hash of the requesting NHS number for tracing | |
| `ERROR_SUCCESS_CODE` | varchar | The PDS response success or error code | |
| `MATCHED_NHS_NUMBER_HASH` | binary(32) | The PDS responded NHS number hashed | |
| `SK_PATIENT_ID_MATCHED` | bigint | The LDS standard pseudonym for the NHS number that was matched in PDS | |
| `SENSITIVITY_FLAG` | char(1) | The returned value of the sensitivity of the patient. Note: this value is rarely populated | |
| `MATCHED_ALGORITHM_INDICATOR` | char(1) | Reference to the algorithm used to match the patient | |
| `REQUESTING_PATIENT_ID` | uniqueidentifier | Reference to the patient that holds the details used in the trace | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_REGISTRAR_EVENT_ID` | uniqueidentifier | LDS processing event identifier for the processing of the UPRN match | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS. May be null | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_END_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was no longer the latest. Obsolete | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### practitioner

> [!NOTE]
> A person who is directly or indirectly involved in the provisioning of healthcare or related services. Practitioner covers all individuals who are engaged in the healthcare process and healthcare-related services as part of their formal responsibilities and this Resource is used for attribution of activities and responsibilities to these individuals

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the practitioner | `id` |
| `GMC_CODE` | varchar(255) | The GMC code of the practitioner | `gmc_code` |
| `TITLE` | varchar(50) | The title of the practitioner | |
| `FIRST_NAME` | nvarchar | The first name of the practitioner | `name` |
| `LAST_NAME` | nvarchar | The last name of the practitioner | `name` |
| `NAME` | nvarchar | Name of the practitioner | |
| `IS_OBSOLETE` | bit | True/false - is the practitioner no longer active | |
| `LDS_END_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version is no longer correct/latest. Obsolete | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS processing event identifier for sequencing the data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### practitioner_in_role

> [!NOTE]
> A specific set of Roles/Locations/specialties/services that a practitioner may perform at an organization for a period of time.

> [!WARNING]
> TPP records do not relate a source `SRStaffMemberRole` to a specific organisation as record owner. As such these will be listed as owned by the Organisation under which the role occurs. This may later be altered to a static value (to be agreed with users).

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the practitioner role record | |
| `PRACTITIONER_ID` | uniqueidentifier | Unique ID of the practitioner | |
| `ORGANISATION_ID` | uniqueidentifier | The organisation under which the practitioners role takes place | |
| `ROLE_CODE` | varchar(5) | The role code for the practitioner’s role | |
| `ROLE` | varchar(200) | The role description for the practitioner’s role | |
| `DATE_EMPLOYMENT_START` | datetime(3) | Date from which this role was applicable to the practitioner | |
| `DATE_EMPLOYMENT_END` | datetime(3) | Date from which this role was no longer applicable to the practitioner | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS processing event identifier for sequencing the data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | Organisation code for the organisation that owns the record | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### procedure_request

> [!NOTE]
> A record of a request for diagnostic investigations, treatments, or operations to be performed.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | Unique ID of the procedure request | id |
| `PERSON_ID` | uniqueidentifier | Unique individual across all organisations | patient_id |
| `PATIENT_ID` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times | person_id |
| `ENCOUNTER_ID` | uniqueidentifier | Reference to the encounter the procedure was administered at | encounter_id |
| `PRACTITIONER_ID` | uniqueidentifier | Unique ID of the practitioner | practitioner_id |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | The date the procedure was administered by a clinician | clinical_effective_date |
| `DATE_PRECISION_CONCEPT_ID` | int | Identifies the precision of the clinical effectiveness date to either year (1), month (2), day (5), minute (12), second (13), millisecond (14) | date_precision_concept_id |
| `DATE_RECORDED` | datetime(3) | The date the procedure was recorded in the source system | date_recorded |
| `DESCRIPTION` | varchar(255) | Procedure request description | |
| `PROCEDURE_REQUEST_SOURCE_CONCEPT_ID` | uniqueidentifier | Reference to the clinical coding of the procedure | non_core_concept_id |
| `STATUS_CONCEPT_ID` | uniqueidentifier | Reference to the status of the procedure | status_concept_id |
| `AGE_AT_EVENT` | int | The age of the patient at the time of the procedure | age_at_event |
| `AGE_AT_EVENT_BABY` | int | Age at the time of event; integer years if ≥1, else categorized 7001-7007 for babies under 1 year | |
| `AGE_AT_EVENT_NEONATE` | int | Age at the time of event if less than 28 days, else categorized value | |
| `IS_CONFIDENTIAL` | bit | True/false - is the observation marked as confidential/sensitive | |
| `IS_DELETED` | bit | Source data deletion indicator | |
| `LDS_END_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version is no longer correct/latest.<br>**this column is obsolete and will be removed** |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version | |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table | |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | LDS processing event identifier for sequencing the data | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS | |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse | |

### referral_request

> [!NOTE]
> Used to record and send details about a request for referral service or transfer of a patient to the care of another provider or provider organisation

> [!WARNING]
> EMIS records are currently not mapped to populate `ORGANISATION_ID`.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | 'Unique ID of the referral request' | id |
| `ORGANISATION_ID` | uniqueidentifier | Organisation where the referral was recorded. Typically the requesting organisation. | organization_id |
| `PERSON_ID` | uniqueidentifier | 'Unique individual across all organisations' | person_id |
| `PATIENT_ID` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' | patient_id |
| `ENCOUNTER_ID` | uniqueidentifier | 'Reference to the encounter the referral was made in' | encounter_id |
| `PRACTITIONER_ID` | uniqueidentifier | 'The clinician the activity is recorded against' | practitioner_id |
| `UNIQUE_BOOKING_REFERENCE_NUMBER` | varchar(14) | 'Unique booking reference number of the referral request' | |
| `CLINICAL_EFFECTIVE_DATE` | datetime(3) | 'The date the referral was made' | clinical_effective_date |
| `DATE_PRECISION_CONCEPT_ID` | uniqueidentifier | 'Identifies the precision of the clinical effectiveness date to either year (1), month (2), day (5), minute (12), second (13), millisecond (14)' | date_precision_concept_id |
| `REQUESTER_ORGANISATION_ID` | uniqueidentifier | 'Reference to the organisation that made the referral request' | requester_organization_id |
| `RECIPIENT_ORGANISATION_ID` | uniqueidentifier | 'Organisation identifier of the recipient of the referral request' | recipient_organization_id |
| `REFERRAL_REQUEST_PRIORITY_CONCEPT_ID` | int | 'Reference to the priority of the referral' | referral_request_priority_concept_id |
| `REFERRAL_REQUEST_TYPE_CONCEPT_ID` | int | 'Reference to the type of referral request' | referral_request_type_concept_id |
| `REFERRAL_REQUEST_SPECIALTY_CONCEPT_ID` | int | 'Reference to the specialty of the referral' | referral_request_specialty_concept_id |
| `MODE` | varchar(50) | 'The mode of the referral' | mode |
| `IS_OUTGOING_REFERRAL` | bit | 'Whether this is an outgoing referral' | outgoing_referral |
| `IS_REVIEW` | bit | 'Whether this referral is a review' | is_review |
| `REFERRAL_REQUEST_SOURCE_CONCEPT_ID` | bigint | 'The source clinical coding of primary diagnosis provided by the supplier' | raw_concept_id |
| `AGE_AT_EVENT` | int | 'The age of the patient at the time of the referral' | age_at_event |
| `AGE_AT_EVENT_BABY` | int | 'The age the patient was at the time of this event. Shown in integer/whole years if the patient is one (1) years or older, else shown as a categorised (7001-7007) value representing an age category for babies under 1 years old. See [Ages](#ages) for more details.' | |
| `AGE_AT_EVENT_NEONATE` | int | 'The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category' | |
| `DATE_RECORDED` | datetime(3) | 'The date the referral request was added to the source system' | date_recorded |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' | |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' | |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' | |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' | |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' | |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' | |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' | |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' | |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' | |

### schedule

> [!NOTE]
> A container for slots of time that may be available for booking appointments.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | LDS assigned Unique Identifier for the source record version | |
| `ID` | uniqueidentifier | 'Unique ID of the schedule' | id |
| `LOCATION_ID` | uniqueidentifier | 'Reference to the location of the schedule' | |
| `LOCATION` | varchar(100) | 'Textual description of the location the schedule was held at' | location |
| `PRACTITIONER_ID` | uniqueidentifier | 'Reference to the practitioner who owns the schedule' | practitioner_id |
| `START_DATE` | datetime(3) | 'The start date of the schedule' | start_date |
| `END_DATE` | datetime(3) | 'The end date of the schedule' |  |
| `TYPE` | varchar(255) | 'The type of schedule eg Timed Appointments' | type |
| `NAME` | varchar(150) | 'The name of the schedule' | name |
| `IS_PRIVATE` | bit | 'True/false - is the schedule marked as private' |  |
| `IS_DELETED` | bit | 'True/false - is the schedule marked as deleted' |  |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' | |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' | |

### schedule_practitioner

> [!NOTE]
> The relationship between a schedule and the practitioner(s) involved on the schedule.

| Column Name | Data Type | Description | Compass Equivalent |
| --- | --- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for the source record version' | |
| `ID` | uniqueidentifier | 'Unique Identifier for this practitioner to schedule relation' |  |
| `SCHEDULE_ID` | uniqueidentifier | 'Reference to the schedule' |  |
| `PRACTITIONER_ID` | uniqueidentifier | 'Reference to the practitioner' |  |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' | |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' | |

## `[OLIDS_PCD]` Schema

### patient

> [!NOTE]
> Demographics and other administrative information about an individual or animal receiving care or other health-related services.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `LDS_RECORD_ID` | uniqueidentifier | 'Unique Identifier for the record' | |
| `ID` | uniqueidentifier | 'Unique ID of the patient' | id |
| `NHS_NUMBER` | char(10) | 'The NHS number of the patient' | nhs_number |
| `TITLE` | varchar(50) | 'The title of the patient' | title |
| `FIRST_NAME` | nvarchar(50) | 'The first names of the patient' | first_names |
| `MIDDLE_NAME` | nvarchar(256) | 'The middle names of the patient' |  |
| `LAST_NAME` | nvarchar(100) | 'The last name of the patient' | last_name |
| `BIRTH_DATE` | date(0) | 'The date of birth of the patient' | date_of_birth |
| `BIRTH_YEAR` | smallint | 'Birth year of the patient' | birth_year |
| `BIRTH_MONTH` | smallint | 'Birth month of the patient' | birth_month |
| `BIRTH_WEEK_ISO` | smallint | 'Birth week of the patient (iso standard)' | birth_week |
| `BIRTH_DAY` | smallint | 'Birth day of the patient' |  |
| `DEATH_YEAR` | smallint | 'Death year of the patient' |  |
| `DEATH_MONTH` | smallint | 'Death month of the patient' |  |
| `DEATH_WEEK_ISO` | smallint | 'Death week of the patient (iso standard)' |  |
| `DEATH_DAY` | smallint | 'Death day of the patient' |  |
| `DEATH_DATE` | date(0) | 'The date of death of the patient' | date_of_death |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' | |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' | |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' | |

### patient_address

> [!NOTE]
> An address for the individual patient

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | 'Unique Identifier for the record' | |
| `ID` | uniqueidentifier | 'Unique ID of the address' | id |
| `PATIENT_ID` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' | patient_id |
| `ADDRESS_TYPE_CONCEPT_ID` | uniqueidentifier | 'Type of address (i.e. Temporary, Correspondence only, Home)' | use_concept_id |
| `IS_HOME_ADDRESS` | bit | 'Indicates whether this address is the patient’s home address' |  |
| `ADDRESS_LINE_1` | nvarchar(255) | 'The first line of the address' | address_line_1 |
| `ADDRESS_LINE_2` | nvarchar(255) | 'The second line of the address' | address_line_2 |
| `ADDRESS_LINE_3` | nvarchar(255) | 'The third line of the address' | address_line_3 |
| `ADDRESS_LINE_4` | nvarchar(255) | 'The fourth line of the address' | address_line_4 |
| `CITY` | nvarchar(255) | 'The city' | city |
| `POSTCODE` | varchar(255) | 'The postcode of the address' | postcode |
| `START_DATE` | datetime(3) | 'The start date of this address being relevant' | start_date |
| `END_DATE` | datetime(3) | 'The end date of this address being relevant' | end_date |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access |  |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' |  |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_END_DATE_TIME` | datetime(3) | 'LDS datetime stamp from when the record was replaced or deleted' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' |  |

### patient_contact

> [!NOTE]
> telecommunication contact details for the patient.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `LDS_RECORD_ID` | uniqueidentifier | 'Unique Identifier for the record' | |
| `ID` | uniqueidentifier | 'Unique ID of the patient contact' | id |
| `PERSON_ID` | uniqueidentifier | 'Unique individual across all organisations' | person_id |
| `PATIENT_ID` | varchar(255) | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' | patient_id |
| `DESCRIPTION` | varchar(255) | '<to be confirmed>' |  |
| `CONTACT_TYPE_CONCEPT_ID` | uniqueidentifier | 'Use of contact (e.g. mobile, home, work). Combines type into single concept' | type_concept_id |
| `START_DATE` | varchar(255) | 'The start date of the contact being valid' | start_date |
| `END_DATE` | varchar(255) | 'The end date of the contact being valid' | end_date |
| `VALUE` | varchar(255) | 'The value of the contact information eg phone number, email address' | value |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access |  |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' |  |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' |  |

### patient_uprn

> [!NOTE]
> unique property reference details from address matching of the supplied patient address details

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `LDS_RECORD_ID` | uniqueidentifier | 'Unique Identifier for the record' |  |
| `ID` | uniqueidentifier | 'Unique ID of the patient uprn match' |  |
| `UPRN` | varchar(255) | 'The matched unique property reference number' | uprn |
| `USRN` | varchar(255) | 'The matched unique street reference number' |  |
| `ORGANISATION_NAME` | varchar(255) | 'The organisation name of the address of the UPRN' | abp_address_organisation |
| `DEPARTMENT_NAME` | varchar(255) | 'The department name of the address of the UPRN' |  |
| `SUB_BUILDING_NAME` | varchar(255) | 'The sub-building name of the address of the UPRN' |  |
| `BUILDING_NAME` | varchar(255) | 'The building name of the address of the UPRN' |  |
| `BUILDING_NUMBER` | varchar(255) | 'The building number of the address of the UPRN' | abp_address_number |
| `DEPENDENT_THOROUGHFARE` | varchar(255) | 'Added to uniquely distinguish addresses where the same thoroughfare exists twice in the same district' |  |
| `THOROUGHFARE` | varchar(255) | 'Road or street name' | abp_address_street |
| `DOUBLE_DEPENDENT_LOCALITY` | varchar(255) | 'A business park, industrial estate or hamlet which is smaller than a Dependent Locality' |  |
| `DEPENDENT_LOCALITY` | varchar(255) | 'A small town or village name sometimes included in an address when the Delivery Point is outside the boundary of the main Post Town that serves it' | abp_address_locality |
| `POST_TOWN` | varchar(255) | 'Also known as postal district, the outbound portion of the postcode (i.e. CM3) which denotes a postal distribution centre' | abp_address_town |
| `POSTCODE` | varchar(255) | 'The postal code used for the Unique Property' | abp_address_postcode |
| `ADDRESS_FORMAT_QUALITY` | varchar(255) | 'The quality of the input address (i.e. "good")' |  |
| `POSTCODE_QUALITY` | varchar(255) | 'The quality of the input postcode (i.e. "good")' |  |
| `MATCHED_WITH_ASSIGN` | varchar(255) | 'True/false - was a match possible' |  |
| `QUALIFIER` | varchar(255) | 'Type of matched address (residential, child)' | qualifier |
| `UPRN_PROPERTY_CLASSIFICATION` | varchar(255) | '<to be confirmed>' | uprn_property_classification |
| `ALGORITHM` | varchar(255) | '<to be confirmed>' | match_rule |
| `MATCH_PATTERN` | varchar(255) | '<to be confirmed>' | 'Concatenates match_pattern_flat, building, number and postcode fields' |
| `UNSTRUCTURED_POSTAL_ADDRESS` | varchar(255) | 'The full input address as a string' |  |
| `X_COORDINATE` | float(53) | 'The Ordnance Survey X co-ordinate of the address' | uprn_xcoordinate |
| `Y_COORDINATE` | float(53) | 'The Ordnance Survey Y co-ordinate of the address' | uprn_ycoordinate |
| `LATITUDE` | float(53) | 'The latitude of the address' | latitude |
| `LONGITUDE` | float(53) | 'The longitude of the address' | longitude |
| `LDS_ID` | uniqueidentifier | 'LDS assigned Unique Identifier for this common modelled record version' |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | 'Natural or source key for the unique event/entity of the table' |  |
| `LDS_DATASET_ID` | uniqueidentifier | 'LDS assigned identifier for the source dataset' |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the process run that transformed the source data into the common modelled item' |  |
| `LDS_REGISTRAR_EVENT_ID` | uniqueidentifier | 'LDS assigned identifier for the registrar event that processed the record' |  |
| `LDS_VERSIONER_EVENT_ID` | uniqueidentifier | 'LDS processing event identifier for sequencing the data' |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access |  |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | 'Date the data was extracted by, received by or supplied to LDS' |  |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | 'Date the business id was first witnessed by, received by or supplied to LDS' |  |
| `LDS_IS_DELETED` | bit | 'LDS flag standardised presentation of deleted state of the record.' |  |
| `LDS_START_DATE_TIME` | datetime(3) | 'LDS datetime stamp from which the record version was correct' |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | 'LDS date stamp when the data was landed into the lakehouse' |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | 'LDS datetime stamp when the data was updated in the lakehouse' |  |

### person

> [!NOTE]
> harmonised person details extracted from person demographics services (PDS), or presented as a stub of known details where no PDS entry is found.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- | ---- |  ---- |
| `LDS_RECORD_ID` | uniqueidentifier | Unique Identifier for the record |  |  |
| `ID` | uniqueidentifier | 'Unique ID of the person' | No Foreign Key reference |  |
| `REQUESTING_RECORD_ID` | uniqueidentifier | The unique record id for the item that acted as the basis for the PDS trace request |  |  |
| `UNIQUE_REFERENCE` | uniqueidentifer | The unique reference for the PDS trace request | |  |
| `REQUESTING_NHS_NUMBER` | varchar(10) | Requested NHS number. Populated with the value provided in the request file. The matched NHS number is provided in the column MATCHED _NHS_NO. |  |  |
| `LAST_NAME` | varchar(40) | Surname, or family name. |  |  |
| `FIRST_NAME` | varchar(40) | Forename, or given name. |  |  |
| `MIDDLE_NAME` | varchar(100) | Other given, or middle, name. |  |  |
| `GENDER` | varchar(1) | Gender (sex) of the person, values:<br>0 = Not Known<br>1 = Male<br>2 = Female<br>9 = Not Specified |  |  |
| `BIRTH_DATE` | varchar(12) | In one of the following formats:<br>full date and time (YYYYMMDDHHMM)<br>full date (YYYYMMDD)<br>year & month (YYYYMM)<br>year only (YYYY) |  |  |
| `BIRTH_YEAR` | smallint | Birth year of the patient |  | birth_year |
| `BIRTH_MONTH` | tinyint | Birth month of the patient |  | birth_month |
| `BIRTH_DAY` | smallint | Birth day of the patient |  |  |
| `BIRTH_TIME` | time(0) | Birth time of the patient | |  |
| `DEATH_DATE` | varchar(12) | In one of the following formats:<br>full date and time (YYYYMMDDHHMM)<br>full date (YYYYMMDD)<br>year & month (YYYYMM)<br>year only (YYYY) |  |  |
| `DEATH_YEAR` | smallint | Death year of the patient |  |  |
| `DEATH_MONTH` | tinyint | Death month of the patient |  |  |
| `DEATH_DAY` | smallint | Death day of the patient |  |  |
| `DEATH_TIME` | time(0) | Death time of the patient | |  |
| `DEATH_NOTIFICATION_STATUS` | varchar(1) | Single digit number code, 1 or 2. 1 is Informal death status where death is reported, but unconfirmed. 2 is formal death status, death has been confirmed officially. |  |  |
| `ADDRESS_LINE_1` | varchar(4000) | First line of a person’s usual address. |  |  |
| `ADDRESS_LINE_2` | varchar(4000) | Second line of a person’s usual address. |  |  |
| `ADDRESS_LINE_3` | varchar(4000) | Third line of a person’s usual address. |  |  |
| `ADDRESS_LINE_4` | varchar(4000) | Fourth line of a person’s usual address. |  |  |
| `ADDRESS_LINE_5` | varchar(4000) | Fifth line of a person’s usual address. |  |  |
| `POSTCODE` | varchar(8) | Postcode of the person’s usual address. |  |  |
| `PREFERRED_CONTACT_METHOD` | varchar(1) | Single digit number code as follows: 1=Letter, 2=Visit, 3=Phone, 4=Email, 5=TextPhone, 6=TextPhoneProxy, 7=Sign language, 8=NoPhone |  |  |
| `NOMINATED_PHARMACY` | varchar(5) | Code to designate which community pharmacy is used for patient. Composed of double capital letters then 3 numbers, for example FC890 |  |  |
| `DISPENSING_DOCTOR` | varchar(6) | Code to designate which dispensing doctor is used for patient. Composed of first character is a capital letter followed by 5 numbers, for example N85004 |  |  |
| `MEDICAL_APPLIANCE_SUPPLIER` | varchar(5) | Code to designate which medical appliance supplier is used for patient. Composed of triple capital letters followed by 2 numbers, for example FFF14 |  |  |
| `GP_PRACTICE_CODE` | varchar(8) | Primary Care Provider GP practice code. |  |  |
| `GP_REGISTRATION_DATE` | varchar(14) | Date the patient was registered with a GP. |  |  |
| `NHAIS_POSTING_ID` | varchar(3) | Unique code that represents the NHAIS box. |  |  |
| `AS_AT_DATE` | varchar(8) | Ignore this field. |  |  |
| `LOCAL_PATIENT_ID` | varchar(8000) | Ignore this field. |  |  |
| `INTERNAL_ID` | varchar(8) | Ignore this field. |  |  |
| `TELEPHONE_NUMBER` | varchar(8000) | Person's telephone number. |  |  |
| `MOBILE_NUMBER` | varchar(8000) | Person's mobile number. |  |  |
| `EMAIL_ADDRESS` | varchar(8000) | Person's email address. |  |  |
| `MPS_ID` | varchar(10) | Ignore this field. |  |  |
| `ERROR_SUCCESS_CODE` | varchar(2) | The code corresponding to this record. <br>See the person level response code table for details.  |  |  |
| `MATCHED_NHS_NO` | varchar(10) | This field needs to be checked for one of the values below. If there is a match with the values below, the record has not been successfully matched. Any other number indicates a match. <br>0000000000: No match was found <br>9999999999: Multiple matches were found. <br><blank>: Not enough fields provided for the trace. |  |  |
| `MATCHED_ALGORITHM_INDICATOR` | varchar(1) | This will be one of the following values: <br>0: No Match <br>1: Cross Check <br>3: Alphanumeric | | |
| `REQUESTING_PATIENT_ID` | uniqueidentifier | The patient_id for the patient record used to create the PDS trace request | | |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |
| `LDS_CDM_EVENT_ID` | uniqueidentifier | LDS assigned identifier for the process run that transformed the source data into the common modelled item | |
| `LDS_REGISTRAR_EVENT_ID` | uniqueidentifier | LDS processing event identifier for sequencing the data |  |
| `RECORD_OWNER_ORGANISATION_CODE` | varchar(50) | The organisation code of the publisher / controller of the record governing access; this is null as the record owner is the Personal Demographic Service | |
| `LDS_DATETIME_DATA_ACQUIRED` | datetime(3) | Date the data was extracted by, received by or supplied to LDS | |
| `LDS_INITIAL_DATA_RECEIVED_DATE` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record. | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |
| `LDS_LAKEHOUSE_DATETIME_UPDATED` | datetime(3) | LDS datetime stamp when the data was updated in the lakehouse |  |

## `[OLIDS_TERMINOLOGY]` Schema

### concept

> [!NOTE]
> Used to declare the existence of and describe a code system or code system supplement and its key properties, and optionally define a part or all of its content.
>
> Code systems define which codes (symbols and/or expressions) exist, and how they are understood. Value sets select a set of codes from one or more code systems to specify which codes can be used in a particular context

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- | ---- | ---- |
| `ID` | uniqueidentifier | 'Unique ID of the person' | No Foreign Key reference |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `SYSTEM` | varchar(255) | The code system reference |  |  |
| `CODE` | varchar(255) | The codified concept contained within the code system |  |  |
| `DISPLAY` | varchar(255) |  The displayable description for the concept |  |   |
| `IS_MAPPED` | bit | true/false is the code mapped to a standard concept within the `concept_map` object |  |  |
| `USE_COUNT` | int | the calculated frequency of use of the encoded concept within the processed data to date |  |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |

### concept_map

> [!NOTE]
> A statement of relationships from one set of concepts to one or more other concepts - either concepts in code systems, or data element/data element concepts, or classes in class models.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- |  ---- | ---- |
| `ID` | uniqueidentifier | 'Unique ID of the person' | No Foreign Key reference |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `CONCEPT_MAP_ID` | uniqueidentifier | The Unique Identifier for the mapping group |  |  |
| `SOURCE_CODE_ID` | uniqueidentifier | The Unique Identifier for the source concept_id  |  |  |
| `TARGET_CODE_ID` | uniqueidentifier | The Unique Identifier for the target concept_id  |  |  |
| `IS_PRIMARY` | bit | True/false is this the primary mapping for the code |  |  |
| `EQUIVALENCE` | varchar(255) | type of mapping equivalence, values include 'equivalent', 'wider', 'narrower', 'subsumes', 'inexact', 'unmatched', 'specializes', 'relatedto', 'unmatched' |  | |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |


## `[OLIDS_GOVERNANCE]` Schema

### allocation
> [!NOTE]
> Allocation table capturing subscription and subscriber allocation details along with LDS audit metadata.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- | ---- | ---- |
| `ID` | uniqueidentifier | Unique business key generated as concatenation of LDSRecordId, SubscriberId, and SubscriptionId  | No Foreign Key reference |  |
| `LDS_START_DATE_TIME` | timestamp | Timestamp indicating when this allocation record became active; taken from DateTimeUpdated or DateTimeCreated |  |  |
| `LDS_RECORD_ID` | varchar(8000) | LDS assigned unique identifier for the record |  |  |
| `LDS_SOURCE_DATASET_ID` | varchar(8000) | LDS identifier for the source dataset |  |  |
| `LDS_SOURCE_DATASET_OBJECT_ID` | varchar(8000) | LDS identifier for the specification object within the source dataset |  |  |
| `LDS_SOURCE_FILE_ID` | varchar(8000) | LDS identifier for the source file from which this record was sourced |  |  |
| `LDS_BATCH_ID` | varchar(8000) | LDS identifier for the batch processing this record |  |  |
| `LDS_DATETIME_DATA_SUPPLIED` | timestamp | Date and time when the data was supplied to LDS |  |  |
| `LDS_SUBSCRIBER_ID` | varchar(8000) | Unique identifier for the subscriber |  |  |
| `LDS_SUBSCRIPTION_ID` | varchar(8000) | Unique identifier for the subscription |  |  |
| `LDS_SUBSCRIBER_CODE` | varchar(50) | Subscriber code assigned by the source system |  |  |
| `LDS_SUBSCRIPTION_ENDPOINT_CODE` | varchar(50) | Subscriber endpoint or subscription endpoint code |  |  |
| `LDS_ALLOCATION_STATE` | varchar(20) | Status of the allocation, values: 'active', 'rescinded', 'expired' |  |  |
| `LDS_CREATED_DATE` | timestamp | Date and time the record was created in LDS |  |  |
| `LDS_CREATED_BY_RUN_ID` | varchar(8000) | Pipeline run identifier that created the record |  |  |
| `LDS_UPDATED_DATE` | timestamp | Date and time the record was last updated in LDS |  |  |
| `LDS_UPDATED_BY_RUN_ID` | varchar(8000) | Pipeline run identifier that last updated the record |  |  |

## `[REFERENCE]` Schema

### postcode_hash

> [!NOTE]  
> Stores hashed postcodes along with associated organisations and geographic areas for reference, including effective date ranges and LDS audit metadata.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | --- | --- | --- |
| `ID` | BINARY(32) | Unique identifier for the record | No Foreign Key reference |  |
| `LDS_ID` | uniqueidentifier | LDS assigned Unique Identifier for this common modelled record version |  |  |
| `LDS_BUSINESS_KEY` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |  |
| `LDS_DATASET_ID` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `POSTCODE_HASH` | BINARY(32) | Unique hashed value representing the postcode, also acts as a unique identifier |  |  |
| `PRIMARY_CARE_ORGANISATION` | VARCHAR(9) | Primary care organisation associated with the postcode |  |  |
| `LOCAL_AUTHORITY_ORGANISATION` | VARCHAR(5) | Local authority organisation linked to the postcode |  |  |
| `YR2011_LSOA` | VARCHAR(9) | 2011 Lower Super Output Area (LSOA) code for the postcode |  |  |
| `YR2011_MSOA` | VARCHAR(9) | 2011 Middle Super Output Area (MSOA) code for the postcode |  |  |
| `YR2021_LSOA` | VARCHAR(9) | 2021 Lower Super Output Area (LSOA) code for the postcode |  |  |
| `YR2021_MSOA` | VARCHAR(9) | 2021 Middle Super Output Area (MSOA) code for the postcode |  |  |
| `EFFECTIVE_FROM` | TIMESTAMP_NTZ(9) | Start date/time from which this record is effective |  |  |
| `EFFECTIVE_TO` | TIMESTAMP_NTZ(9) | End date/time until which this record is effective |  |  |
| `IS_LATEST` | NUMBER(38,0) NOT NULL | Flag indicating if this is the latest record (1 = yes, 0 = no) |  |  |
| `LDS_IS_DELETED` | bit | LDS flag standardised presentation of deleted state of the record |  |  |
| `LDS_START_DATE_TIME` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `LAKEHOUSE_DATE_PROCESSED` | DATE NOT NULL | Date when the data was landed into the lakehouse |  |  |
| `HIGH_WATERMARK_DATE_TIME` | TIMESTAMP_NTZ(9) NOT NULL | High watermark timestamp for incremental loads |  |  |
| `LDS_LAKEHOUSE_DATE_PROCESSED` | date | LDS date stamp when the data was landed into the lakehouse |  |  |

## Ages

Ages shown in the OLIDS dataset for de-identified (also known as "masked" or "pseudonymised") data are shown in:

- whole integer years
- age brackets aligned to HES child ages
- days since birth up to 27 days for neonates

This is aligned with the Hospital Episode Statistics age categorisation as below:

| OLIDS Column | HES column | Definitions | Values |
| :--- | :--- | :--- | :--- |
| `AGE_AT_EVENT` | `age` | **HES:** <br> Number of whole years between patient's date of birth and the event. <br>The event date typically used is the end date, unless otherwise stated within the column name. <br><br>**OLIDS:**<br> Number of whole years between patient's date of birth and the event. <br>The event date typically used is the end date, unless otherwise stated within the column name. | nnn = Age in years |
| `AGE_AT_EVENT_BABY` | `ENDAGE` and `STARTAGE` (APC) <br> `APPTAGE` (OP) <br> `ARRIVALAGE` (AE) | **HES:**<br>The patient's age, in completed years, at the end of a finished episode. <br>For patients under 1 year old, special codes in the range 7001 to 7007 apply.<br><br>**OLIDS:**<br>The patient's age, in completed years, at the end of an event. <br>For patients under 1 year old, special codes in the range 7001 to 7007 apply. | nnn = Age in years<br> 120 = 120 years or more<br> 7001 = Less than 1 day  <br> 7002 = 1 to 6 days  <br> 7003 = 7 to 28 days  <br> 7004 = 29 to 90 days (under 3 months)  <br> 7005 = 91 to 181 days (approximately 3 months to under 6  months)  <br> 7006 = 182 to 272 days (approximately 6 months to under 9 months)  <br> 7007 = 273 to <1 year (approximately 9 months to under 1 year)  <br> Null = Not applicable (other maternity event) or not known <br> [See HES Data Dictionary](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics/hospital-episode-statistics-data-dictionary)|
| `AGE_AT_EVENT_NEONATE` | `NEODUR` (APC) | **HES:** <br>The age in days of a baby admitted as a patient. It is derived from the Admission Date (ADMIDATE) and Date of Birth (DOB). <br>If the baby is older than 27 days, NEODUR is not calculated. <br><br>**OLIDS:** <br>The age of a patient at the end of an event where the patient is under 28 days old.<br> If the baby is older than 27 days, no age in days is given. | 2n = Age of patient in days from 0 to 27. <br> `NULL` = Not applicable. Patient is older than 27 days. |
