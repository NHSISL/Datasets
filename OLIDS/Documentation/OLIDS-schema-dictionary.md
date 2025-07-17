# OLIDS data dictionary

The tables below show the One London Integrated Data Set (OLIDS) schema definition.

## Contents

- [OLIDS data dictionary](#olids-data-dictionary)
  - [Contents](#contents)
  - [`[OLIDS_MASKED]` Schema](#%60%5Bolids_masked%5D%60-schema)
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
    - [patient (masked)](#patient-(masked))
    - [patient\_address (masked)](#patient_address-(masked))
    - [patient\_contact (masked)](#patient_contact-(masked))
    - [patient\_person](#patient_person)
    - [patient\_registered\_practitioner\_in\_role](#patient_registered_practitioner_in_role)
    - [patient\_uprn (masked)](#patient_uprn-(masked))
    - [person (masked)](#person-(masked))
    - [practitioner](#practitioner)
    - [practitioner\_in\_role](#practitioner_in_role)
    - [procedure\_request](#procedure_request)
    - [referral\_request](#referral_request)
    - [schedule](#schedule)
    - [schedule\_practitioner](#schedule_practitioner)
  - [`[OLIDS_PCD]` Schema](#%60%5Bolids_pcd%5D%60-schema)
    - [patient](#patient)
    - [patient\_address](#patient_address)
    - [patient\_contact](#patient_contact)
    - [patient\_uprn](#patient_uprn)
    - [person](#person)
  - [`[OLIDS_TERMINOLOGY]` Schema](#%60%5Bolids_terminology%5D%60-schema)
    - [concept](#concept)
    - [concept\_map](#concept_map)

## `[OLIDS_MASKED]` Schema

### allergy_intolerance

> [!NOTE] Allergy Intolerance
>
> Risk of harmful or undesirable physiological response which is specific to an individual and associated with exposure to a substance. A record of a clinical assessment of an allergy or intolerance; a propensity, or a potential risk to an individual, to have an adverse reaction on future exposure to the specified substance, or class of substance.
> 
> Where a propensity is identified, to record information or evidence about a reaction event that is characterised by any harmful or undesirable physiological response that is specific to the individual and triggered by exposure of an individual to the identified substance or class of substance.
> 
> Substances include, but are not limited to: a therapeutic substance administered correctly at an appropriate dosage for the individual; food; material derived from plants or animals; or venom from insect stings.

| Column Name | Data Type | Description | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | `id` |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) | 'Owning organisation (i.e. publisher)' |  | `organization_id` |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | datetime that the business id value was first witnessed |  |  |
| `lds_is_deleted` | bit | LDS flag standardising presentation of deleted state of the record | |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `patient_id` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times |  | patient_id |
| `practitioner_id` | uniqueidentifier | The clinician in role that the activity is recorded against' |  | `practitioner_id` |
| `encounter_id` | uniqueidentifier | Reference to the encounter this allergy was record in |  | `encounter_id` |
| `clinical_status` | varchar(20) | unmapped - prepared to match FHIR |  | `clinical_status` |
| `verification_status` | varchar(20) | unmapped - prepared to match FHIR' |  |  |
| `category` | varchar(20) | unmapped - prepared to match FHIR' |  |  |
| `clinical_effective_date` | datetime(3) | The date the clinical code is recorded for |  | `clinical_effective_date` |
| `date_precision_concept_id` | uniqueidentifier | Identifies the precision of the clinical effectiveness date' |  | `date_precision_concept_id` |
| `is_review` | bit | Is this instance of the code a review of a previous encounter |  | `is_review` |
| `medication_name` | varchar(255) | Reference to the clinical name of the medication the patient has an allergy to |  |  |
| `multi_lex_action` | varchar(25) |  |  | |
| `allergy_intolerance_source_concept_id` | uniqueidentifier | Reference to the clinical coding of the allergy provided by the supplier |  |  |
| `age_at_event` | int | The age the patient was at the time of this event |  | |
| `age_at_event_baby` | int |  The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int |The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `date_recorded` | datetime(3) |  The date the allergy was recorded |  |  |
| `is_confidential` | bit | True/False - is this allergy flagged as a confidential observation' |  |  |
| `person_id` | uniqueidentifier |  Unique individual across all organisation |  | `person_id` |

### appointment

> [!NOTE] Appointment
> A booking of a healthcare event among patient(s), practitioner(s), related person(s) and/or device(s) for a specific date/time. This may result in one or more Encounter(s).
> Appointment resources are used to provide information about a planned meeting that may be in the future or past. The resource only describes a single meeting, a series of repeating visits would require multiple appointment resources to be created for each instance. Examples include a scheduled surgery, a follow-up for a clinical visit, a scheduled conference call between clinicians to discuss a case (where the patient is a subject, but not a participant), the reservation of a piece of diagnostic equipment for a particular use, etc. The visit scheduled by an appointment may be in person or remote (by phone, video conference, etc.) All that matters is that the time and usage of one or more individuals, locations and/or pieces of equipment is being fully or partially reserved for a designated period of time.
> This definition takes the concepts of appointments in a clinical setting and also extends them to be relevant in the community healthcare space, and to ease exposure to other appointment / calendar standards widely used outside of healthcare.

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_is_deleted` | bit |  | LDS flag standardising presentation of deleted state of the record | |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `practitioner_in_role_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `schedule_id` | uniqueidentifier |  | 'The schedule the patient was put on to book multiple appointments. ID unique to the applied schedule' |  | schedule_id |
| `start_date` | datetime(3) |  | 'The start date of the appointment' |  | start_date |
| `planned_duration` | int |  | 'The time allocated for the appointment, not necessarily the actual duration always in minutes' |  | planned_duration |
| `actual_duration` | int |  | 'Time between sent in and left always in minutes' |  | actual_duration |
| `appointment_status_concept_id` | uniqueidentifier |  | 'The status of the appointment e.g. arrived/sent in/left/DNA' |  | appointment_status_concept_id |
| `patient_wait` | int |  | 'How long the patient waited from being marked as arrived to being sent in' |  | patient_wait |
| `patient_delay` | int |  | 'How long the patient was delayed for' |  | patient_delay |
| `date_time_booked` | datetime(3) |  | Date and time the appointment booking was made' |  |  |
| `date_time_sent_in` | datetime(3) |  | 'Date and time the patient was sent into the practitioner' |  | date_time_sent_in |
| `date_time_left` | datetime(3) |  | Date and time the patient left the practitioner' |  | date_time_left |
| `cancelled_date` | datetime(3) | TPP ONLY | Date and time the appointment was cancelled' |  | cancelled_date |
| `type` | varchar(100) |  | Description of the slot type' |  |  |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  |  |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `booking_method_concept_id` | uniqueidentifier |  | Method used to book the appointment |  |  |
| `contact_mode_concept_id` | uniqueidentifier |  | Appointment mode of contact - e.g. telephone |  |  |
| `is_blocked` | bit | | Indicates whether the appointment slot is blocked |  |  |
| `national_slot_category_name` | varchar(900) |  | The name of the national slot category |  |  |
| `context_type` | varchar(100) |  | The national slot category context type | |  |
| `service_setting` | varchar(100) |  | The national slot category service setting |  |  |
| `national_slot_category_description` | varchar(900) |  | The description of the national slot category | |  |
| `csds_care_contact_identifier` | varchar(17) |  | **TO BE ADDED** |  |  |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |

### appointment_practitioner

> [!NOTE] Appointment practitioner
> 
> List of practitioner participants involved in the appointment

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_record_id_user` | uniqueidentifier | <to be confirmed> |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `appointment_id` | uniqueidentifier | Unique identifier for the appointment |  | organization_id |
| `practitioner_id` | uniqueidentifier | 'The clinician the activity is recorded against' |  | practitioner_id |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### diagnostic_order

> [!NOTE] diagnostic order
> A record of a request for service such as diagnostic investigations, treatments, or operations to be performed.
>
> This represents an order or proposal or plan to perform a diagnostic or other service on or for a patient. It represents a proposal or plan or order for a service to be performed that would result in a Procedure or Diagnostic Report, which in turn may reference one or more Observations, which summarize the performance of the procedures and associated documentation such as observations, images, findings that are relevant to the treatment/management of the subject. This resource may be used to share relevant information required to support a referral or a transfer of care request from one practitioner or organization to another when a patient is required to be referred to another provider for a consultation /second opinion and/or for short term or longer term management of one or more health issues or problems.
>
> The resource allows requesting only a single procedure. If a workflow requires requesting multiple procedures simultaneously, this is done using multiple instances of this resource.

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | 
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier | 'Reference to the encounter the observation was recorded at' |  | encounter_id |
| `practitioner_id` | uniqueidentifier | Reference to the practitioner that recorded the order' |  | practitioner_id |
| `parent_observation_id` | uniqueidentifier | 'Reference to the parent observation in a complex observation eg systolic and diastolic blood pressures will have a parent observation of Blood pressure' |  | parent_observation_id |
| `clinical_effective_date` | datetime(3) |  The date the diagnostic order was identified by a clinician |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier | Identifies the precision of the clinical effectiveness date |  | date_precision_concept_id |
| `result_value` | float | The value of the result of the observation |  | result_value |
| `result_value_units` | uniqueidentifier | Concept ID for the units of the result of the observation |  | result_value_units |
| `result_date` | date(0) | The date of the result |  | result_date |
| `result_text` | varchar(8000) | Any text associated with the result |  | result_text |
| `is_problem` | bit | Whether the observation is marked as a problem |  | is_problem |
| `is_review` | bit | Whether the observation is a review of an existing problem |  | is_review |
| `problem_end_date` | datetime(3) | 'The end date of the problem' |  | problem_end_date |
| `diagnostic_order_source_concept_id` | uniqueidentifier | 'Reference to the clinical coding of the result provided by the supplier' |  | raw_concept_id |
| `age_at_event` | int | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_baby` | int | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `episodicity_concept_id` | uniqueidentifier | Indicates the episodicity of the observation |  |  |
| `is_primary` | bit | will be false if the observation has a parent observation  |  |  |
| `date_recorded` | datetime(3) |  **TO ADD** |  |  |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | person_id |

### encounter

> [!NOTE] encounter
> An interaction between a patient and healthcare provider(s) for the purpose of providing healthcare service(s) or assessing the health status of a patient.
> 
> A patient encounter is further characterized by the setting in which it takes place. Amongst them are ambulatory, emergency, home health, inpatient and virtual encounters. An Encounter encompasses the lifecycle from pre-admission, the actual encounter (for ambulatory encounters), and admission, stay and discharge (for inpatient encounters). During the encounter the patient may move from practitioner to practitioner and location to location.

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the encounter' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `appointment_id` | uniqueidentifier |  | 'Reference to the appointment this encounter took part on' |  | appointment_id |
| `episode_of_care_id` | uniqueidentifier |  | The episode of care under which this encounter occurred |  | episode_of_care_id |
| `service_provider_organisation_id` | uniqueidentifier |  | 'Reference to the service provider organisation' |  | service_provider_organisation_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the clinical code is recorded for' |  | clinical_effective_date |
| `date_precision_concept_id` | int |  | 'Reference to the precision of the date of the encounter' |  | date_precision_concept_id |
| `location` | varchar(200) |  | Reference to the location that the encounter took place at' |  | institution_location_id |
| `encounter_source_concept_id` | uniqueidentifier |  | 'Reference to the type of encounter' |  | non_core_concept_id |
| `age_at_event` | int |  | 'The age the patient was when this encounter took place' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `type` | varchar(50) |  | 'Reference to the type of encounter' |  | type |
| `sub_type` | varchar(50) |  | 'Reference to the type of encounter' |  | sub_type |
| `admission_method` | varchar(40) |  | 'The admission method of the encounter' |  | admission_method |
| `end_date` | datetime(3) |  | 'The end date of the encounter' |  | end_date |
| `is_deleted` | bit |  |  true/false is the record deleted |  |  |
| `date_recorded` | datetime(3) |  | 'The date the encounter was recorded' |  | date_recorded |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### episode_of_care

> [!NOTE] episode of care
> An association between a patient and an organisation / healthcare provider(s) during which time encounters may occur. The managing organisation assumes a level of responsibility for the patient during this time.

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the encounter event' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `patient_id` | uniqueidentifier |  | 'The patient this event belongs to' |  | patient_id |
| `person_id` | uniqueidentifier |  | 'The person this event belongs to' |  | person_id |
| `episode_type_source_concept_id` | uniqueidentifier |  | 'Reference to the registration type of the patient' |  | registration_type_concept_id |
| `episode_status_source_concept_id` | uniqueidentifier |  | 'Reference to the registration status of the patient' |  | registration_status_concept_id |
| `episode_of_care_start_date` | datetime(3) |  | The date the episode of care started' |  | date_registered |
| `episode_of_care_end_date` | datetime(3) |  | The date the episode of care ended' |  | date_registered_end |
| `care_manager_practitioner_id` | uniqueidentifier |  | 'Reference to the usual GP for this episode of care' |  | usual_gp_practitioner_id |

### flag

> [!NOTE] flag
> prospective warnings of potential issues when providing care to the patient
>
> A flag is a warning or notification of some sort presented to the user - who may be a clinician or some other person involved in patient care. It usually represents something of sufficient significance to warrant a special display of some sort - rather than just a note in the resource

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the flag' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `person_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | patient_id |
| `effective_date` | datetime(3) |  | 'The date the flag was entered onto the patients record' |  | effective_date |
| `expired_date` | datetime(3) |  | The expiry date of the flag |  |  |
| `is_active` | bit |  | 'Whether the flag is active or not' |  | is_active |
| `flag_text` | varchar(8000) |  | This is a warning set by the publisher regarding the patient' |  | flag_text |

### location

>[!NOTE] location
> Details and position information for a place where services are provided and resources and participants may be stored, found, contained, or accommodated.
>
> A Location includes both incidental locations (a place which is used for healthcare without prior designation or authorization) and dedicated, formally appointed locations. Locations may be private, public, mobile or fixed and scale from small freezers to full hospital buildings or parking garages.

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the location' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `name` | varchar(100) |  | 'The name of a location set by the publisher. E.g. ward, clinic, domiciliary' |  | name |
| `type_code` | uniqueidentifier |  | 'The type of location' |  | type_code |
| `type_desc` | varchar(50) |  | 'Textual description of the type of location eg GP Practice' |  | type_desc |
| `is_primary_location` | bit |  | true/false - is this the primary location of the parent organisation |  |  |
| `house_name` | nvarchar |  | location property name |  |  |
| `house_number` | nvarchar |  | location property number |  |  |
| `house_name_flat_number` | nvarchar |  | location property number |  |  |
| `street` | nvarchar |  | location street/road name |  |  |
| `address_line_1` | nvarchar |  | location address line 1 |  |  |
| `address_line_2` | nvarchar |  | location address line 2 |  |  |
| `address_line_3` | nvarchar |  | location address line 3 |  |  |
| `address_line_4` | nvarchar |  | location address line 4 |  |  |
| `postcode` | varchar(200) |  | location postcode |  | postcode |
| `managing_organisation_id` | uniqueidentifier |  | reference to the parent organisation of the location |  | managing_organization_id |
| `open_date` | date(0) |  | location opening date |  |  |
| `close_date` | date(0) |  | location closing date (if applicable) |  |  |
| `is_obsolete` | bit |  | true/false - is the location closed |  |  |

### location_contact

> [!NOTE] location contact
> The contact details of communication devices available at the location. This can include addresses, phone numbers, fax numbers, mobile numbers, email addresses and web sites.

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique identifier for this location contact |  |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `location_id` | uniqueidentifier | reference to the location |  |  |
| `is_primary_contact` | bit | true/false - is this the primary contact for the location |  |  |
| `contact_type` | varchar(50) | type of contact (Telephone, Fax, Email) |  |  |
| `contact_type_concept_id` | uniqueidentifier | type of contact (Telephone, Fax, Email) |  |  |
| `value` | nvarchar | 'The value of the contact information eg phone number, email address' |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### medication_order

> [!NOTE] medication order
> An order or request for both supply of the medication and the instructions for administration of the medication to a patient
>
> This resource covers all type of orders for medications for a patient. This includes inpatient medication orders as well as community orders (whether filled by the prescriber or by a pharmacy). It also includes orders for over-the-counter medications (e.g. Aspirin), total parenteral nutrition and diet/ vitamin supplements. It may be used to support the order of medication-related devices e.g., prefilled syringes such as patient-controlled analgesia (PCA) syringes, or syringes used to administer other types of medications. e.g., insulin, narcotics.
>
>It is not intended for use in prescribing particular diets, or for ordering non-medication-related items (eyeglasses, supplies, etc.). In addition, the MedicationRequest may be used to report orders/request from external systems that have been reported for informational purposes and are not authoritative and are not expected to be acted upon (e.g. dispensed or administered)

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the medication order' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `organisation_id` | uniqueidentifier | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `medication_statement_id` | uniqueidentifier | 'Reference to the medication statement.  A medication statement can have many medication orders' |  | medication_statement_id |
| `encounter_id` | uniqueidentifier | 'Reference to the encounter the medication order was issued in' |  |  |
| `practitioner_id` | uniqueidentifier | 'The clinician the activity is recorded against' |  | practitioner_id |
| `observation_id` | uniqueidentifier | Reference to the observation that required the medication order |  |  |
| `allergy_intolerance_id` | uniqueidentifier | Reference to allergy intolerance observations attached to this medication order |  |  |
| `diagnostic_order_id` | uniqueidentifier | Reference to diagnostic order observations attached to this medication order |  |  |
| `referral_request_id` | uniqueidentifier | Reference to referral requests attached to this medication order |  |  |
| `clinical_effective_date` | datetime(3) | 'The date the medication order was issued' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `dose` | varchar(1000) | 'Textual description of the dose' |  | dose |
| `quantity_value` | float | 'The value of the medication that was prescribed eg 50' |  | quantity_value |
| `quantity_unit` | varchar(255) | 'The unit of the medication that was prescribed eg tablets' |  | quantity_unit |
| `duration_days` | int | 'How many days the medication is prescribed for' |  | duration_days |
| `estimated_cost` | float | 'The estimated cost of the medication' |  | estimated_cost |
| `medication_name` | varchar(500) | The name of the medication in the order |  |  |
| `medication_order_source_concept_id` | uniqueidentifier | 'Reference to the clinical coding of the medication provided by the supplier' |  | non_core_concept_id |
| `bnf_reference` | varchar(10) | 'Reference to the clinical coding of the medication' |  | bnf_reference |
| `age_at_event` | int | 'The age the patient was at the time of this event' |  | age_at_event |
| `age_at_event_baby` | int | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `issue_method` | varchar(8000) | 'The issue method of the medication eg hand written' |  | issue_method |
| `date_recorded` | datetime(3) | No comment yet added |  | date_recorded |
| `is_confidential` | bit | true/false - is the medication order flagged as confidential/closed |  |  |
| `is_deleted` | bit | true/false - is the record deleted |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### medication_statement

> [!NOTE] medication statement
> A record of a medication that is being consumed by a patient. A Medication Statement may indicate that the patient may be taking the medication now or has taken the medication in the past or will be taking the medication in the future. The source of this information can be the patient, significant other (such as a family member or spouse), or a clinician. A common scenario where this information is captured is during the history taking process during a patient visit or stay. The medication information may come from sources such as the patient's memory, from a prescription bottle, or from a list of medications the patient, clinician or other party maintains.

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the medication' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_is_deleted` | bit |  | supplier agnostic representation of whether the record is deleted |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  |  |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter this medication was recorded in' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `observation_id` | uniqueidentifier |  | Reference to the observation that required the medication order |  |  |
| `allergy_intolerance_id` | uniqueidentifier |  | Reference to allergy intolerance observations attached to this medication order |  |  |
| `diagnostic_order_id` | uniqueidentifier |  | Reference to diagnostic order observations attached to this medication order |  |  |
| `referral_request_id` | uniqueidentifier |  | Reference to referral requests attached to this medication order |  |  |
| `authorisation_type_concept_id` | int |  | 'Reference to the authorisation type' |  | authorisation_type_concept_id |
| `date_precision_concept_id` | int |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `medication_statement_source_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the medication provided by the supplier' |  | non_core_concept_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the medication was clinical relevant' |  | clinical_effective_date |
| `cancellation_date` | datetime(3) |  | 'The date the medication was cancelled' |  | cancellation_date |
| `dose` | varchar(1000) |  | 'Textual description of the dose of the medication' |  | dose |
| `quantity_value_description` | varchar(500) |  | 'The value of the medication that was prescribed eg 50' |  |  |
| `quantity_value` | float |  | 'The value of the medication that was prescribed eg 50' |  | quantity_value |
| `quantity_unit` | varchar(255) |  | 'The unit of the medication that was prescribed eg tablets' |  | quantity_unit |
| `medication_name` | varchar(500) |  | The name of the medication attached to the statement |  |  |
| `bnf_reference` | varchar(10) |  | 'A reference to the drug in the BNF dictionary' |  | bnf_reference |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `issue_method` | varchar(8000) |  | 'The issue method of the medication eg hand written' |  | issue_method |
| `date_recorded` | datetime(3) |  | date the medication statement was recorded |  | date_recorded |
| `is_active` | bit |  | is the record active |  |  |
| `is_confidential` | bit |  | true/false - is the statement marked as confidential/sensitive |  |  |
| `is_deleted` | bit | | true/false - is the record in a deleted state |  |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |

### observation

> [!NOTE] observation
> Measurements and simple assertions made about a patient, device or other subject
>
> Observations are a central element in healthcare, used to support diagnosis, monitor progress, determine baselines and patterns and even capture demographic characteristics, as well as capture results of tests performed on products and substances. Most observations are simple name/value pair assertions with some metadata, but some observations group other observations together logically, or even are multi-component observations.

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier |  | 'Unique Id of the observation' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier |  | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  |  |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `person_id` | uniqueidentifier |  | The unique reference for the person |  | person_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter the observation was recorded at' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `parent_observation_id` | uniqueidentifier |  | 'Reference to the parent observation in a complex observation eg systolic and diastolic blood pressures will have a parent observation of Blood pressure' |  | parent_observation_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the observation was identified by a clinician' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `result_value` | float |  | 'The value of the result of the observation' |  | result_value |
| `result_value_unit_concept_id` | uniqueidentifier |  | 'The units of the result of the observation' |  |  |
| `result_date` | date(0) |  | 'The date of the result' |  | result_date |
| `result_text` | varchar(8000) |  | 'Any text associated with the result' |  | result_text |
| `is_problem` | bit |  | 'Whether the observation is marked as a problem' |  | is_problem |
| `is_review` | bit |  | 'Whether the observation is a review of an existing problem' |  | is_review |
| `problem_end_date` | datetime(3) |  | 'The end date of the problem' |  | problem_end_date |
| `observation_source_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the observation provide by the supplier' |  | non_core_concept_id |
| `age_at_event` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_baby` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_neonate` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `episodicity_concept_id` | bigint |  | 'Reference to the episodicity of the problem eg First, review, flare' |  | episodicity_concept_id |
| `is_primary` | bit |  | 'Whether the observation is a primary observation' |  | is_primary |
| `date_recorded` | datetime(3) |  | 'The date the observation was recorded in the system' |  | date_recorded |
| `is_problem_deleted` | bit |  | true/false - whether the problem relating to the observation is deleted |  |  |
| `is_confidential` | bit |  | true/false - is the observation marked as confidential/sensitive |  |  |

### organisation

> [!NOTE] organisation
> A formally or informally recognized grouping of people or organisations formed for the purpose of achieving some form of collective action. Includes companies, institutions, corporations, departments, community groups, healthcare practice groups etc.

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | 
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the organisation' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_initial_data_received_date` | datetime(3) | Date the business id was first witnessed by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_is_deleted` | bit | data source agnostic deletion indicator |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `organisation_code` | varchar(255) | Organisation Code |  | ods_code |
| `assigning_authority_code` | varchar(255) | The assigning authority of the organisation code |  |  |
| `name` | varchar(255) | 'Name of the organisation' |  | name |
| `type_code` | int | 'The type of organisation' |  | type_code |
| `type_desc` | varchar(255) | 'The type of organisation' |  | type_desc |
| `postcode` | varchar(200) | 'The postcode of the organisation' |  | postcode |
| `parent_organisation_id` | uniqueidentifier | 'The id of the parent organisation' |  | parent_organization_id |
| `open_date` | date(0) | Date the organisation opened (minimum of operational or legal dates) |  |  |
| `close_date` | date(0) | Date the organisation closed (maximum of operational or legal dates) |  |  |
| `is_obsolete` | bit | Is the organisation closed |  |  |

### patient (masked)

> [!NOTE] patient (masked)
> Demographics and other administrative information about an individual or animal receiving care or other health-related services.
>
> note that this encompasses an anonymous in context (pseudonymised) representation of patients. Additionally, a single person can exist as many patients undergoing separate episodes of care at differing healthcare provider services. A patient represents a single person undergoing care at one or more specific healthcare providers, typically assigned a local system patient identifier or patient administration system number.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the patient' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `nhs_number_hash` | binary(32) | internal irreversible hash of the patient NHS number |  |  |
| `sk_patient_id` | int | Consistent LDS pseudonym for secondary care planning purposes |  |  |
| `title` | varchar(50) | 'The title of the patient' |  |  |
| `gender_concept_id` | uniqueidentifier | 'Reference to the gender of the patient' |  |  |
| `registered_practice_id` | uniqueidentifier | LDS assigned identifier for patient's registered practice |  |  |
| `birth_year` | int | year of the date of birth |  |  |
| `birth_month` | int | month of the date of birth |  |  |
| `death_year` | int | year of the date of death |  |  |
| `death_month` | int | month of the date of death |  |  |
| `is_confidential` | bit | true/false - is the observation marked as confidential/sensitive |  |  |
| `is_dummy_patient` | bit | true/false - is the patient flagged or denoted as a test patient in the source system |  |  |
| `is_spine_sensitive` | bit | true/false - is the patient marked as spine sensitive |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### patient_address (masked)

> [!NOTE] patient address (masked)
> An address for the individual patient

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the address' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `patient_id` | uniqueidentifier | The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times |  | patient_id |
| `address_type_concept_id` | uniqueidentifier | Type of address (i.e. Temporary, Correspondence only, Home) |  | use_concept_id |
| `post_code_hash` | binary(32) | The postcode of the address - hashed |  | postcode |
| `start_date` | datetime(3) | The start date of this address being relevant |  | start_date |
| `end_date` | datetime(3) | The end date of this address being relevant |  | end_date |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |
| `person_id` | uniqueidentifier | the unique identifier for the person |  | person_id |

### patient_contact (masked)

> [!NOTE] patient contact (masked)
> telecommunication contact details for the patient.
> 
> note that this is the anonymous in context (pseudonymised) edition of the contact information and as a result will merely show the presence of a communication method with no details of the contact itself.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- |  ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the patient contact' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | varchar(255) | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `description` | varchar(255) | <to be confirmed> |  |  |
| `contact_type_concept_id` | varchar(255) | use of contact (e.g. mobile, home,work' (Combines type into single concept) |  | use_concept_id |
| `start_date` | varchar(255) | 'The start date of the contact being valid' |  | start_date |
| `end_date` | varchar(255) | 'The end date of the contact being valid' |  | end_date |

### patient_person

> [!NOTE] patient person
> relationship bridging table between patient and person

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- |  ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique identifier for the patient to practitioner relationship |  |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version was superseded |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  |  |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  |  |

### patient_registered_practitioner_in_role

> [!NOTE] patient registered practitioner in role
> Denotes the patients registered healthcare professional responsible for their care.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique identifier for the patient to practitioner relationship |  |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_is_deleted` | bit | LDS marker for the deleted state of the record (should be false/0 in all subscribed cases) |  |  |
| `lds_dataset_id` | uniqueidentifier | the identifier for the source of the data |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  |  |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  |  |
| `organisation_id` | uniqueidentifier | 'Owning organisation (i.e. publisher)' |  |  |
| `practitioner_id` | uniqueidentifier | The clinician the episode of care is registered under' |  |  |
| `episode_of_care_id` | uniqueidentifier | The episode of care (registration to service provider) that the patient is recorded under with this practitioner/clinician |  |  |
| `start_date` | datetime(3) | start date of the relationship between patient and practitioner |  |  |
| `end_date` | datetime(3) | end date of the relationship between patient and practitioner |  |  |

### patient_uprn (masked)

> [!NOTE] patient unique property reference number (masked)
> unique property reference details from address matching of the supplied patient address details

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique Id of the patient uprn match' |  |  |
| `lds_datetime_data_acquired` | datetime(3) |  Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `registrar_event_id` | uniqueidentifier | LDS processing event identifier for the processing of the uprn match |  |  |
| `masked_uprn` | varchar(255) | the matched unique property reference number, with hashing applied |  |  |
| `masked_upsn` | varchar(255) | the matched unique street reference number, with hashing applied |  |  |
| `masked_postcode` | varchar(255) | the masked input postcode |  |  |
| `address_format_quality` | varchar(255) | The quality of the input address (i.e. 'good') |  |  |
| `post_code_quality` | varchar(255) | The quality of the input postcode (i.e. 'good') |  |  |
| `matched_with_assign` | varchar(255) | True/false - was a match possible |  |  |
| `qualifier` | varchar(255) | type of matched address (residential, child) |  |  |
| `classification` | varchar(255) | <to be confirmed> |  |  |
| `algorithm` | varchar(255) | <to be confirmed> | <to be confirmed> |  |  |
| `match_pattern` | varchar(255) | <to be confirmed> | <to be confirmed> |  |  |
| `unstructured_postal_address` | varchar(255) | **MUST BE REMOVED** The full input address as a string |  |  |
| `lds_end_date_time` | datetime(3) |  LDS datetime stamp from which the record version was no longer correct |  |  |

### person (masked)

> [!NOTE] person
> harmonised person details extracted from person demographics services (PDS), or presented as a stub of known details where no PDS entry is found.

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | reference to the patient identifier |  |  |
| `lds_dataset_id` | uniqueidentifier | reference to the source of the data for this item |  |  |
| `lds_business_key` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `primary_patient_id` | uniqueidentifier | reference to the patient identifier that conforms to the primary representation of the person |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version was no longer correct |  |  |
| `requesting_patient_record_id` | uniqueidentifier | the record identifier for the patient information that was used to trace the patient |  |  |
| `unique_reference` | uniqueidentifier | the unique identifier for the tracing request | |  |
| `requesting_nhs_number_hash` |  binary(32) | the hash of the requesting NHS number for tracing | |  |
| `sensivity_flag` | char(1) | the returned value of the sensitivity of the patient |  |  |
| `matched_algorithm_indicator` | char(1) | reference to the algorithm used to match the patient |  |  |
| `requesting_patient_id` | uniqueidentifier | reference to the patient that holds the details used in the trace |  |  |

### practitioner

> [!NOTE] practitioner
> A person who is directly or indirectly involved in the provisioning of healthcare or related services. Practitioner covers all individuals who are engaged in the healthcare process and healthcare-related services as part of their formal responsibilities and this Resource is used for attribution of activities and responsibilities to these individuals

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the practitioner' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `gmc_code` | varchar(255) | 'The GMC code of the practitioner' |  | gmc_code |
| `title` | varchar(50) | The title of the practitioner |  |  |
| `first_name` | nvarchar | the first name of the practitioner |  | name |
| `last_name` | nvarchar | the last name of the practitioner |  | name |
| `name` | nvarchar | 'Name of the practitioner' |  |  |
| `is_obsolete` | bit | true/false - is the practitioner no longer active |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### practitioner_in_role

> [!NOTE] practitioner in role
> A specific set of Roles/Locations/specialties/services that a practitioner may perform at an organization for a period of time.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the practitioner' |  |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `practitioner_id` | uniqueidentifier | 'Unique Id of the practitioner' |  |  |
| `organisation_id` | uniqueidentifier | 'Owning organisation (i.e. publisher)' |  |  |
| `role_code` | varchar(5) | the role code for the practitioners role |  |  |
| `role` | varchar(200) | the role description for the practitioners role |  |  |
| `date_employment_start` | datetime(3) | date from which this role was applicable to the practitioner |  |  |
| `date_employment_end` | datetime(3) | date from which this role was no longer applicable to the practitioner |  |  |

### procedure_request

> [!NOTE] procedure request
> A record of a request for diagnostic investigations, treatments, or operations to be performed.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the procedure' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_is_deleted` | bit | dataset agnostic deletion indicator |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | patient_id |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | person_id |
| `encounter_id` | uniqueidentifier | 'Reference to the encounter the procedure was administered at' |  | encounter_id |
| `practitioner_id` | uniqueidentifier | 'Unique Id of the practitioner' |  | practitioner_id |
| `clinical_effective_date` | datetime(3) | 'The date the procedure was administered by a clinician' |  | clinical_effective_date |
| `date_precision_concept_id` | int | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `date_recorded` | datetime(3) | 'The date the procedure was recorded in the source system' |  | date_recorded |
| `description` | varchar(255) | procedure request description |  |  |
| `procedure_source_concept_id` | uniqueidentifier | 'Reference to the clinical coding of the procedure' |  | non_core_concept_id |
| `status_concept_id` | uniqueidentifier | 'Reference to the status of the procedure' |  | status_concept_id |
| `age_at_event` | int | 'The age of the patient at the time of the procedure' |  | age_at_event |
| `age_at_event_baby` | int | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `is_confidential` | bit | true/false - is the observation marked as confidential/sensitive |  |  |
| `is_deleted` | bit | source data deletion indicator |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### referral_request

> [!NOTE] referral request
> Used to record and send details about a request for referral service or transfer of a patient to the care of another provider or provider organisation

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the referral' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_data_initial_received_date` | datetime(3) | Date the data was business key was first witnessed by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_is_deleted` | bit | LDS standardised and data source agnostic deletion indicator |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `organisation_id` | uniqueidentifier | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier | 'Reference to the encounter the referral was made in' |  | encounter_id |
| `practitioner_id` | uniqueidentifier | 'The clinician the activity is recorded against' |  | practitioner_id |
| `unique_booking_reference_number` | varchar(14) | unique booking reference number of the referral request |  |  |
| `clinical_effective_date` | datetime(3) | 'The date the referral was made' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `requester_organisation_id` | uniqueidentifier | 'Reference to the organisation that made the refereral request' |  | requester_organization_id |
| `recipient_organisation_id` | uniqueidentifier | Organisation identifier of the recipient of the referral request |  | recipient_organization_id |
| `referral_request_priority_concept_id` | int | 'Reference to the priority of the referral' |  | referral_request_priority_concept_id |
| `referal_request_type_concept_id` | int | 'Reference to the type of referral request' |  | referral_request_type_concept_id |
| `referral_request_specialty_concept_id` | int | Reference to the specialty of the referral' |  | referral_request_type_concept_id |
| `mode` | varchar(50) | 'The mode of the referral' |  | mode |
| `is_outgoing_referral` | bit | 'Whether this is an outgoing referral' |  | outgoing_referral |
| `is_review` | bit | 'Whether this referral is a review' |  | is_review |
| `referral_request_source_concept_id` | bigint | The source clinical coding of primary diagnosis provided by the supplier |  | raw_concept_id |
| `age_at_event` | int | 'The age of the patient at the time of the referral' |  | age_at_event |
| `age_at_event_baby` | int | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  |  |
| `date_recorded` | datetime(3) | 'The date the referral request was added to the source system' |  | date_recorded |

### schedule

> [!NOTE] schedule
> A container for slots of time that may be available for booking appointments.

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- |  ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the schedule' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `location_id` | uniqueidentifier | Reference to the location of the schedule |  |  |
| `location` | varchar(100) | 'Textual description of the location the schedule was held at' |  | location |
| `practitioner_id` | uniqueidentifier | 'Reference to the practitioner who owns the schedule' |  | practitioner_id |
| `start_date` | datetime(3) | 'The start date of the schedule' |  | start_date |
| `end_date` | datetime(3) | The end date of the schedule' |  |  |
| `type` | varchar(255) | 'The type of schedule eg Timed Appointments' |  | type |
| `name` | varchar(150) | 'The name of the schedule' |  | name |
| `is_private` | bit | true/false - is the schedule marked as private |  |  |

### schedule_practitioner

> [!NOTE] schedule practitioner
> The relationship between a schedule and the practitioner(s) involved on the schedule.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique identifier for this practitioner to schedule relation |  |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `schedule_id` | uniqueidentifier | Reference to the schedule |  |  |
| `practitioner_id` | uniqueidentifier | Reference to the practitioner |  |  |

## `[OLIDS_PCD]` Schema

### patient

> [!NOTE] patient
> Demographics and other administrative information about an individual or animal receiving care or other health-related services.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the patient' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  |  |
| `nhs_number` | char | 'The NHS number of the patient' |  | nhs_number |
| `title` | varchar(50) | 'The title of the patient' |  |  |
| `first_name` | nvarchar | 'The first names of the patient' |  | first_names |
| `middle_name` | nvarchar | The middle names of the patient' |  |  |
| `last_name` | nvarchar | 'The last name of the patient' |  | last_name |
| `birth_date` | date(0) | 'The date of birth of the patient' |  | date_of_birth |
| `birth_year` | smallint | Birth year of the patient |  | birth_year |
| `birth_month` | smallint | Birth month of the patient |  | birth_month |
| `birth_week_iso` | smallint | Birth week of the patient (iso standard) |  | birth_week |
| `birth_day` | smallint | Birth day of the patient |  |  |
| `death_date` | date(0) | 'The date of death of the patient' |  | date_of_death |
| `death_year` | smallint | Death year of the patient |  |  |
| `death_month` | smallint | Death month of the patient |  |  |
| `death_week_iso` | smallint | Death week of the patient (iso standard) |  |  |
| `death_day` | smallint | Death day of the patient |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### patient_address

> [!NOTE] patient address
> An address for the individual patient

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the address' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `patient_id` | uniqueidentifier | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `address_type_concept_id` | bigint | Type of address (i.e. Temporary, Correspondence only, Home) |  | use_concept_id |
| `is_home_address` | bit |  |  |  |
| `address_line_1` | nvarchar | 'The first line of the address' |  | address_line_1 |
| `address_line_2` | nvarchar | 'The second line of the address' |  | address_line_2 |
| `address_line_3` | nvarchar | 'The third line of the address' |  | address_line_3 |
| `address_line_4` | nvarchar | 'The fourth line of the address' |  | address_line_4 |
| `city` | nvarchar | 'The city' |  | city |
| `post_code` | varchar(255) | The postcode of the address |  | postcode |
| `start_date` | datetime(3) | 'The start date of this address being relevant' |  | start_date |
| `end_date` | datetime(3) | 'The end date of this address being relevant' |  | end_date |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### patient_contact

> [!NOTE] patient contact (masked)
> telecommunication contact details for the patient.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the patient contact' |  | id |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `record_owner_organisation_code` | varchar(50) | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | varchar(255) | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `description` | varchar(255) | <to be confirmed> |  |  |
| `contact_type_concept_id` | uniqueidentifier | use of contact (e.g. mobile, home,work' (Combines type into single concept) |  | use_concept_id |
| `start_date` | varchar(255) | 'The start date of the contact being valid' |  | start_date |
| `end_date` | varchar(255) | 'The end date of the contact being valid' |  | end_date |
| `value` | varchar(255) | 'The value of the contact information eg phone number, email address' |  | value |
| `lds_is_deleted` | bit | LDS flag standardising presentation of deleted state of the record | |  |

### patient_uprn

> [!NOTE] patient unique property reference number
> unique property reference details from address matching of the supplied patient address details

| Column Name | Data Type | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | Unique Id of the patient uprn match' |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `registrar_event_id` | uniqueidentifier | LDS processing event identifier for the processing of the uprn match |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `uprn` | varchar(255) | the matched unique property reference number |  |  |
| `upsn` | varchar(255) | the matched unique street reference number |  |  |
| `organisation_name` | varchar(255) | the organisation name of the address of the UPRN |  |  |
| `department_name` | varchar(255) | the department name of the address of the UPRN |  |  |
| `sub_building_name` | varchar(255) | the sub-building name of the address of the UPRN |  |  |
| `building_name` | varchar(255) | the building name of the address of the UPRN |  |  |
| `building_number` | varchar(255) | the building number of the address of the UPRN |  |  |
| `dependent_thoroughfare` | varchar(255) | Added to uniquely distinguish addresses where the same thoroughfare exists twice in the same district |  |  |
| `thoroughfare` | varchar(255) | road or street name |  |  |
| `double_dependent_locality` | varchar(255) | A business park, industrial estate or hamlet which is smaller than a Dependent Locality |  |  |
| `dependent_locality` | varchar(255) | A small town or village name sometimes included in an address when the Delivery Point is outside the boundary of the main Post Town that serves it |  |  |
| `post_town` | varchar(255) | Also known as postal district, the outbound portion of the postcode (i.e. CM3) which denotes a postal distribution centre |  |  |
| `post_code` | varchar(255) | The postal code used for the Unique Property |  |  |
| `address_format_quality` | varchar(255) | The quality of the input address (i.e. 'good') |  |  |
| `post_code_quality` | varchar(255) | The quality of the input postcode (i.e. 'good') |  |  |
| `matched_with_assign` | varchar(255) | True/false - was a match possible |  |  |
| `qualifier` | varchar(255) | type of matched address (residential, child) |  |  |
| `uprn_property_classification` | varchar(255) | <to be confirmed> |  |  |
| `algorithm` | varchar(255) | <to be confirmed> |  |  |
| `match_pattern` | varchar(255) | <to be confirmed> |  |  |
| `unstructured_postal_address` | varchar(255) | The full input address as a string |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### person

> [!NOTE] person
> harmonised person details extracted from person demographics services (PDS), or presented as a stub of known details where no PDS entry is found.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- | ---- |  ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the person' | No Foreign Key reference |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `lds_datetime_data_acquired` | datetime(3) | Date the data was extracted by, received by or supplied to LDS |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
| `lds_end_date_time` | datetime(3) | LDS datetime stamp from which the record version no longer correct/latest |  |  |
| `requesting_record_id` | uniqueidentifier | The unique record id for the item that acted as the basis for the PDS trace request |  |  |
| `unique_reference` | uniqueidentifer | The unique reference for the PDS trace request | |  |
| `requesting_nhs_number` | varchar(10) | Requested NHS number. Populated with the value provided in the request file. The matched NHS number is provided in the column MATCHED _NHS_NO. |  |  |
| `last_name` | varchar(40) | Surname, or family name. |  |  |
| `first_name` | varchar(40) | Forename, or given name. |  |  |
| `middle_name` | varchar(100) | Other given, or middle, name. |  |  |
| `gender` | varchar(1) | Gender (sex) of the person, values:<br>0 = Not Known<br>1 = Male<br>2 = Female<br>9 = Not Specified |  |  |
| `date_of_birth` | varchar(12) | In one of the following formats:<br>full date and time (YYYYMMDDHHMM)<br>full date (YYYYMMDD)<br>year & month (YYYYMM)<br>year only (YYYY) |  |  |
| `birth_year` | smallint | Birth year of the patient |  | birth_year |
| `birth_month` | tinyint | Birth month of the patient |  | birth_month |
| `birth_day` | smallint | Birth day of the patient |  |  |
| `birth_time` | time(0) | Birth time of the patient | |  |
| `date_of_death` | varchar(12) | In one of the following formats:<br>full date and time (YYYYMMDDHHMM)<br>full date (YYYYMMDD)<br>year & month (YYYYMM)<br>year only (YYYY) |  |  |
| `death_year` | smallint | Death year of the patient |  |  |
| `death_month` | tinyint | Death month of the patient |  |  |
| `death_day` | smallint | Death day of the patient |  |  |
| `death_time` | time(0) | Death time of the patient | |  |
| `death_notification_status` | varchar(1) | Single digit number code, 1 or 2. 1 is Informal death status where death is reported, but unconfirmed. 2 is formal death status, death has been confirmed officially. |  |  |
| `address_line1` | varchar(4000) | First line of a person’s usual address. |  |  |
| `address_line2` | varchar(4000) | Second line of a person’s usual address. |  |  |
| `address_line3` | varchar(4000) | Third line of a person’s usual address. |  |  |
| `address_line4` | varchar(4000) | Fourth line of a person’s usual address. |  |  |
| `address_line5` | varchar(4000) | Fifth line of a person’s usual address. |  |  |
| `post_code` | varchar(8) | Postcode of the person’s usual address. |  |  |
| `preferred_contact_method` | varchar(1) | Single digit number code as follows: 1=Letter, 2=Visit, 3=Phone, 4=Email, 5=TextPhone, 6=TextPhoneProxy, 7=Sign language, 8=NoPhone |  |  |
| `nominated_pharmacy` | varchar(5) | Code to designate which community pharmacy is used for patient. Composed of double capital letters then 3 numbers, for example FC890 |  |  |
| `dispensing_doctor` | varchar(6) | Code to designate which dispensing doctor is used for patient. Composed of first character is a capital letter followed by 5 numbers, for example N85004 |  |  |
| `medical_appliance_supplier` | varchar(5) | Code to designate which medical appliance supplier is used for patient. Composed of triple capital letters followed by 2 numbers, for example FFF14 |  |  |
| `gp_practice_code` | varchar(8) | Primary Care Provider GP practice code. |  |  |
| `gp_registration_date` | varchar(14) | Date the patient was registered with a GP. |  |  |
| `nhais_posting_id` | varchar(3) | Unique code that represents the NHAIS box. |  |  |
| `as_at_date` | varchar(8) | Ignore this field. |  |  |
| `local_patient_id` | varchar(8000) | Ignore this field. |  |  |
| `internal_id` | varchar(8) | Ignore this field. |  |  |
| `telephone_number` | varchar(8000) | Person's telephone number. |  |  |
| `mobile_number` | varchar(8000) | Person's mobile number. |  |  |
| `email_address` | varchar(8000) | Person's email address. |  |  |
| `mps_id` | varchar(10) | Ignore this field. |  |  |
| `error_success_code` | varchar(2) | The code corresponding to this record. <br>See the person level response code table for details.  |  |  |
| `matched__nhs_no` | varchar(10) | This field needs to be checked for one of the values below. If there is a match with the values below, the record has not been successfully matched. Any other number indicates a match. <br>0000000000: No match was found <br>9999999999: Multiple matches were found. <br><blank>: Not enough fields provided for the trace. |  |  |
| `matched_algorithm_indicator` | varchar(1) | This will be one of the following values: <br>0: No Match <br>1: Cross Check <br>3: Alphanumeric | | |

## `[OLIDS_TERMINOLOGY]` Schema

### concept

> [!NOTE] concept
> Used to declare the existence of and describe a code system or code system supplement and its key properties, and optionally define a part or all of its content.
>
> Code systems define which codes (symbols and/or expressions) exist, and how they are understood. Value sets select a set of codes from one or more code systems to specify which codes can be used in a particular context

| Column Name | Data Type |  Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the person' | No Foreign Key reference |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `system` | varchar(255) | The code system reference |  |  |
| `code` | varchar(255) | The codified concept contained within the code system |  |  |
| `display` | varchar(255) |  The displayable description for the concept |  |   |
| `is_mapped` | bit | true/false is the code mapped to a standard concept within the `concept_map` object |  |  |
| `use_count` | int | the calculated frequency of use of the encoded concept within the processed data to date |  |  |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |

### concept_map

> [!NOTE] concept map
> A statement of relationships from one set of concepts to one or more other concepts - either concepts in code systems, or data element/data element concepts, or classes in class models.

| Column Name | Data Type | Comment | Foreign Key Reference | Compass equivalent |
| --- | --- | ---- |  ---- | ---- |
| `lds_id` | uniqueidentifier | LDS assigned unique identifier for this common modelled record version |  |  |
| `id` | uniqueidentifier | 'Unique Id of the person' | No Foreign Key reference |  |
| `lds_business_key` | varchar(8000) | Natural or source key for the unique event/entity of the table |  |  |
| `lds_dataset_id` | uniqueidentifier | LDS assigned identifier for the source dataset |  |  |
| `concept_map_id` | uniqueidentifier | The unique identifier for the mapping group |  |  |
| `source_code_id` | uniqueidentifier | The unique identifier for the source concept_id  |  |  |
| `target_code_id` | uniqueidentifier | The unique identifier for the target concept_id  |  |  |
| `is_primary` | bit | True/false is this the primary mapping for the code |  |  |
| `equivalence` | varchar(255) | type of mapping equivalence, values include 'equivalent', 'wider', 'narrower', 'subsumes', 'inexact', 'unmatched', 'specializes', 'relatedto', 'unmatched' |  | |
| `lds_start_date_time` | datetime(3) | LDS datetime stamp from which the record version was correct |  |  |
