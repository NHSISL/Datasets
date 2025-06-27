# OLIDS data dictionary

The tables below show the One London Integrated Data Set (OLIDS) schema definition.

## Contents

## Table inventory

## [OLIDS_MASKED] Schema

### allergy_intolerance

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | `id` |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | 'Owning organisation (i.e. publisher)' |  | `organization_id` |
| `lds_datetime_data_acquired` | datetime(3) | MAY BE REMOVED | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | <to be confirmed> |  | <none> |
| `lds_is_deleted` | bit |  | LDS flag standardising presentation of deleted state of the record | | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `practitioner_id` | uniqueidentifier |  | The clinician in role that the activity is recorded against' |  | `practitioner_id` |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter this allergy was record in' |  | `encounter_id` |
| `clinical_status` | varchar(20) | EMPTY | unmapped - prepared to match FHIR' |  | `clinical_status` |
| `verification_status` | varchar(20) | EMPTY | unmapped - prepared to match FHIR' |  | <none> |
| `category` | varchar(20) | EMPTY | unmapped - prepared to match FHIR' |  | <none> |
| `clinical_effective_date` | datetime(3) |  | 'The date the clinical code is recorded for' |  | `clinical_effective_date` |
| `date_precision_concept_id` | uniqueidentifier |  | Identifies the precision of the clinical effectiveness date' |  | `date_precision_concept_id` |
| `is_review` | bit |  | 'Is this instance of the code a review of a previous encounter' |  | `is_review` |
| `medication_name` | varchar(255) |  | Reference to the clinical name of the medication the patient has an allergy to' |  | <none> |
| `multi_lex_action` | varchar(25) |  |  |  | <none> |
| `allergy_intolerance_core_concept_id` | uniqueidentifier |  | Reference to the clinical coding of the allergy |  | <none> |
| `allergy_intolerance_raw_concept_id` | uniqueidentifier | TPP ONLY | Reference to the MultiLex Action clinical coding of the allergy' |  | <none> |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  | <none> |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `date_recorded` | datetime(3) |  | 'The date the allergy was recorded' |  | <none> |
| `is_confidential` | bit |  | True/False - is this allergy flagged as a confidential observation' |  | <none> |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | `person_id` |

### appointment

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_is_deleted` | bit |  | LDS flag standardising presentation of deleted state of the record | | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
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
| `date_time_booked` | datetime(3) |  | Date and time the appointment booking was made' |  | <none> |
| `date_time_sent_in` | datetime(3) |  | 'Date and time the patient was sent into the practitioner' |  | date_time_sent_in |
| `date_time_left` | datetime(3) |  | Date and time the patient left the practitioner' |  | date_time_left |
| `cancelled_date` | datetime(3) | TPP ONLY | Date and time the appointment was cancelled' |  | cancelled_date |
| `type` | varchar(100) |  | Description of the slot type' |  | <none> |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  | <none> |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `booking_method_concept_id` | uniqueidentifier |  | Method used to book the appointment |  | <none> |
| `contact_mode_concept_id` | uniqueidentifier |  | Appointment mode of contact - e.g. telephone |  | <none> |
| `is_blocked` | bit | | Indicates whether the appointment slot is blocked |  | <none> |
| `national_slot_category_name` | varchar(900) |  | The name of the national slot category |  | <none> |
| `context_type` | varchar(100) |  | The national slot category context type | | <none> |
| `service_setting` | varchar(100) |  | The national slot category service setting |  | <none> |
| `national_slot_category_description` | varchar(900) |  | The description of the national slot category | | <none> |
| `csds_care_contact_identifier` | varchar(17) |  | **TO BE ADDED** |  | <none> |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |

### appointment_practitioner

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_record_id_user` | int |  | <to be confirmed> |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `appointment_id` | uniqueidentifier |  | Unique identifier for the appointment |  | organization_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  |  |

### diagnostic_order

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | LDS assigned unique identifier for the business key of this table (unique allergy intolerance record) |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter the observation was recorded at' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | Reference to the practitioner that recorded the order' |  | practitioner_id |
| `parent_observation_id` | uniqueidentifier |  | 'Reference to the parent observation in a complex observation eg systolic and diastolic blood pressures will have a parent observation of Blood pressure' |  | parent_observation_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the diagnostic order was identified by a clinician' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier |  | Identifies the precision of the clinical effectiveness date' |  | date_precision_concept_id |
| `result_value` | float |  | 'The value of the result of the observation' |  | result_value |
| `result_value_units` | uniqueidentifier |  | Concept ID for the units of the result of the observation |  | result_value_units |
| `result_date` | date(0) |  | 'The date of the result' |  | result_date |
| `result_text` | varchar(8000) |  | 'Any text associated with the result' |  | result_text |
| `is_problem` | bit |  | 'Whether the observation is marked as a problem' |  | is_problem |
| `is_review` | bit |  | 'Whether the observation is a review of an existing problem' |  | is_review |
| `problem_end_date` | datetime(3) |  | 'The end date of the problem' |  | problem_end_date |
| `diagnostic_order_core_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the result' |  | core_concept_id |
| `diagnostic_order_raw_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the result' |  | non_core_concept_id |
| `age_at_event` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `episodicity_concept_id` | uniqueidentifier |  | Indicates the episodicity of the observation |  |  |
| `is_primary` | bit |  | will be false if the observation has a parent observation  |  |  |
| `date_recorded` | datetime(3) |  |  **TO ADD** |  |  |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |

### encounter

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the encounter' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
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
| `encounter_core_concept_id` | uniqueidentifier |  | 'Reference to the type of encounter' |  | non_core_concept_id |
| `age_at_event` | int |  | 'The age the patient was when this encounter took place' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `type` | varchar(50) |  | 'Reference to the type of encounter' |  | type |
| `sub_type` | varchar(50) |  | 'Reference to the type of encounter' |  | sub_type |
| `admission_method` | varchar(40) |  | 'The admission method of the encounter' |  | admission_method |
| `end_date` | datetime(3) |  | 'The end date of the encounter' |  | end_date |
| `is_deleted` | bit |  |  true/false is the record deleted |  | <none> |
| `date_recorded` | datetime(3) |  | 'The date the encounter was recorded' |  | date_recorded |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### episode_of_care

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the encounter event' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `patient_id` | uniqueidentifier |  | 'The patient this event belongs to' |  | patient_id |
| `person_id` | uniqueidentifier |  | 'The person this event belongs to' |  | person_id |
| `episode_type_raw_concept_id` | uniqueidentifier |  | 'Reference to the registration type of the patient' |  | registration_type_concept_id |
| `episode_status_raw_concept_id` | uniqueidentifier |  | 'Reference to the registration status of the patient' |  | registration_status_concept_id |
| `episode_of_care_start_date` | datetime(3) |  | The date the episode of care started' |  | date_registered |
| `episode_of_care_end_date` | datetime(3) |  | The date the episode of care ended' |  | date_registered_end |
| `care_manager_practitioner_id` | uniqueidentifier |  | 'Reference to the usual GP for this episode of care' |  | usual_gp_practitioner_id |

### flag

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the flag' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `person_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | patient_id |
| `effective_date` | datetime(3) |  | 'The date the flag was entered onto the patients record' |  | effective_date |
| `expired_date` | datetime(3) |  | The expiry date of the flag |  | <none> |
| `is_active` | bit |  | 'Whether the flag is active or not' |  | is_active |
| `flag_text` | varchar(8000) |  | This is a warning set by the publisher regarding the patient' |  | flag_text |

### location

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the location' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `name` | varchar(100) |  | 'The name of a location set by the publisher. E.g. ward, clinic, domiciliary' |  | name |
| `type_code` | uniqueidentifier |  | 'The type of location' |  | type_code |
| `type_desc` | varchar(50) |  | 'Textual description of the type of location eg GP Practice' |  | type_desc |
| `is_primary_location` | bit |  | true/false - is this the primary location of the parent organisation |  | <none> |
| `house_name` | nvarchar |  | location property name |  | <none> |
| `house_number` | nvarchar |  | location property number |  | <none> |
| `house_name_flat_number` | nvarchar |  | location property number |  | <none> |
| `street` | nvarchar |  | location street/road name |  | <none> |
| `address_line_1` | nvarchar |  | location address line 1 |  | <none> |
| `address_line_2` | nvarchar |  | location address line 2 |  | <none> |
| `address_line_3` | nvarchar |  | location address line 3 |  | <none> |
| `address_line_4` | nvarchar |  | location address line 4 |  | <none> |
| `postcode` | varchar(200) |  | location postcode |  | postcode |
| `managing_organisation_id` | uniqueidentifier |  | reference to the parent organisation of the location |  | managing_organization_id |
| `open_date` | date(0) |  | location opening date |  | <none> |
| `close_date` | date(0) |  | location closing date (if applicable) |  | <none> |
| `is_obsolete` | bit |  | true/false - is the location closed |  | <none> |

### location_contact

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | Unique identifier for this location contact |  | <none> |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `location_id` | uniqueidentifier |  | reference to the location |  | <none> |
| `is_primary_contact` | bit |  | true/false - is this the primary contact for the location |  | <none> |
| `contact_type` | varchar(50) |  | type of contact (Telephone, Fax, Email) |  | <none> |
| `contact_type_concept_id` | uniqueidentifier |  | type of contact (Telephone, Fax, Email) |  | <none> |
| `value` | nvarchar |  | 'The value of the contact information eg phone number, email address' |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### medication_order

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the medication order' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `medication_statement_id` | uniqueidentifier |  | 'Reference to the medication statement.  A medication statement can have many medication orders' |  | medication_statement_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter the medication order was issued in' |  | <none> |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `observation_id` | uniqueidentifier |  | Reference to the observation that required the medication order |  | <none> |
| `allergy_intolerance_id` | uniqueidentifier |  | Reference to allergy intolerance observations attached to this medication order |  | <none> |
| `diagnostic_order_id` | uniqueidentifier |  | Reference to diagnostic order observations attached to this medication order |  | <none> |
| `referral_request_id` | uniqueidentifier |  | Reference to referral requests attached to this medication order |  | <none> |
| `clinical_effective_date` | datetime(3) |  | 'The date the medication order was issued' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `dose` | varchar(1000) |  | 'Textual description of the dose' |  | dose |
| `quantity_value` | float |  | 'The value of the medication that was prescribed eg 50' |  | quantity_value |
| `quantity_unit` | varchar(255) |  | 'The unit of the medication that was prescribed eg tablets' |  | quantity_unit |
| `duration_days` | int |  | 'How many days the medication is prescribed for' |  | duration_days |
| `estimated_cost` | float |  | 'The estimated cost of the medication' |  | estimated_cost |
| `medication_name` | varchar(500) |  | The name of the medication in the order |  | <none> |
| `medication_order_core_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the medication' |  | non_core_concept_id |
| `bnf_reference` | varchar(10) |  | 'Reference to the clinical coding of the medication' |  | bnf_reference |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `issue_method` | varchar(8000) |  | 'The issue method of the medication eg hand written' |  | issue_method |
| `date_recorded` | datetime(3) |  | No comment yet added |  | date_recorded |
| `is_confidential` | bit |  | true/false - is the medication order flagged as confidential/closed |  | <none> |
| `is_deleted` | bit |  | true/false - is the record deleted |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `lds_end_date_time` | datetime(3) | MAY BE REMOVED | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### medication_statement

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the medication' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_is_deleted` | bit |  | supplier agnostic representaiton of whether the record is deleted |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter this medication was recorded in' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `observation_id` | uniqueidentifier |  | Reference to the observation that required the medication order |  | <none> |
| `allergy_intolerance_id` | uniqueidentifier |  | Reference to allergy intolerance observations attached to this medication order |  | <none> |
| `diagnostic_order_id` | uniqueidentifier |  | Reference to diagnostic order observations attached to this medication order |  | <none> |
| `referral_request_id` | uniqueidentifier |  | Reference to referral requests attached to this medication order |  | <none> |
| `authorisation_type_concept_id` | int |  | 'Reference to the authorisation type' |  | authorisation_type_concept_id |
| `date_precision_concept_id` | int |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `medication_statement_core_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the medication' |  | non_core_concept_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the medication was clinical relevant' |  | clinical_effective_date |
| `cancellation_date` | datetime(3) |  | 'The date the medication was cancelled' |  | cancellation_date |
| `dose` | varchar(1000) |  | 'Texual description of the dose of the medication' |  | dose |
| `quantity_value_description` | varchar(500) |  | 'The value of the medication that was prescribed eg 50' |  | <none> |
| `quantity_value` | float |  | 'The value of the medication that was prescribed eg 50' |  | quantity_value |
| `quantity_unit` | varchar(255) |  | 'The unit of the medication that was prescribed eg tablets' |  | quantity_unit |
| `medication_name` | varchar(500) |  | The name of the medication attached to the statement |  | <none> |
| `bnf_reference` | varchar(10) |  | 'A reference to the drug in the BNF dictionary' |  | bnf_reference |
| `age_at_event` | int |  | 'The age the patient was at the time of this event' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  |  |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `issue_method` | varchar(8000) |  | 'The issue method of the medication eg hand written' |  | issue_method |
| `date_recorded` | datetime(3) |  | date the medication statement was recorded |  | date_recorded |
| `is_active` | bit |  | is the record active |  | <none> |
| `is_confidential` | bit |  | true/false - is the statement marked as confidential/sensitive |  | <none> |
| `is_deleted` | bit | | true/false - is the record in a deleted state |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |

### observation

| Column Name | Data Type | Status | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the observation' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
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
| `observation_raw_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the observation' |  | non_core_concept_id |
| `observation_core_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the observation' |  | core_concept_id |
| `age_at_event` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_baby` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `age_at_event_neonate` | int |  | 'The age of the patient at the time of the observation' |  | age_at_event |
| `episodicity_concept_id` | bigint |  | 'Reference to the episodicity of the problem eg First, review, flare' |  | episodicity_concept_id |
| `is_primary` | bit |  | 'Whether the observation is a primary observation' |  | is_primary |
| `date_recorded` | datetime(3) |  | 'The date the observation was recorded in the system' |  | date_recorded |
| `is_problem_deleted` | bit |  | true/false - whether the problem relating to the observation is deleted |  | <none> |
| `is_confidential` | bit |  | true/false - is the observation marked as confidential/sensitive |  | <none> |

### organisation

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the organisation' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_initial_data_received_date` | datetime(3) |  | Date the business id was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_is_deleted` | bit |  | data source agnostic deletion indicator |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `organisation_code` | varchar(255) |  | Organisation Code |  | ods_code |
| `assigning_authority_code` | varchar(255) |  | The assigning authority of the organisation code |  | <none> |
| `name` | varchar(255) |  | 'Name of the organisation' |  | name |
| `type_code` | int |  | 'The type of organisation' |  | type_code |
| `type_desc` | varchar(255) |  | 'The type of organisation' |  | type_desc |
| `postcode` | varchar(200) |  | 'The postcode of the organisation' |  | postcode |
| `parent_organisation_id` | uniqueidentifier |  | 'The id of the parent organisation' |  | parent_organization_id |
| `open_date` | date(0) |  | Date the organisation opened (minimum of operational or legal dates) |  | <none> |
| `close_date` | date(0) |  | Date the organisation closed (maximum of operational or legal dates) |  | <none> |
| `is_obsolete` | bit |  | Is the organisation closed |  | <none> |

### patient (masked)

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the patient' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
| `nhs_number_hash` | binary(32) |  | internal irreversible hash of the patient NHS number |  | <none> |
| `sk_patient_id` | int |  | Consistent LDS pseudonym for secondary care planning purposes |  | <none> |
| `title` | varchar(50) |  | 'The title of the patient' |  | <none> |
| `gender_concept_id` | uniqueidentifier |  | 'Reference to the gender of the patient' |  | <none> |
| `registered_practice_id` | uniqueidentifier |  | LDS assigned identifier for patient's registered practice |  | <none> |
| `birth_year` | int |  | year of the date of birth |  | <none> |
| `birth_month` | int |  | month of the date of birth |  | <none> |
| `death_year` | int |  | year of the date of death |  | <none> |
| `death_month` | int |  | month of the date of death |  | <none> |
| `is_confidential` | bit |  | true/false - is the observation marked as confidential/sensitive |  | <none> |
| `is_dummy_patient` | bit |  | true/false - is the patient flagged or denoted as a test patient in the source system |  | <none> |
| `is_spine_sensitive` | bit |  | true/false - is the patient marked as spine sensitive |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### patient_address (masked)

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the address' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `address_type_concept_id` | uniqueidentifier |  | Type of address (i.e. Temporary, Correspondence only, Home) |  | use_concept_id |
| `post_code_hash` | binary(32) |  | The postcode of the address - hashed |  | postcode |
| `start_date` | datetime(3) |  | 'The start date of this address being relevant' |  | start_date |
| `end_date` | datetime(3) |  | 'The end date of this address being relevant' |  | end_date |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |
| `person_id` | uniqueidentifier |  | the unique identifier for the person |  | person_id |

### patient_contact (masked)

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the patient contact' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | varchar(255) |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `description` | varchar(255) |  | <to be confirmed> |  | <none> |
| `contact_type_concept_id` | varchar(255) |  | use of contact (e.g. mobile, home,work' (Combines type into single concept) |  | use_concept_id |
| `start_date` | varchar(255) |  | 'The start date of the contact being valid' |  | start_date |
| `end_date` | varchar(255) |  | 'The end date of the contact being valid' |  | end_date |

### patient_person

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | Unique identifier for the patient to practitioner relationship |  | <none> |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was superseded |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | <none> |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | <none> |

### patient_registered_practitioner_in_role

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | Unique identifier for the patient to practitioner relationship |  | <none> |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_is_deleted` | bit |  | LDS marker for the deleted state of the record (should be false/0 in all subscribed cases) |  | <none> |
| `lds_dataset_id` | uniqueidentifier | the identifier for the source of the data |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | <none> |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | <none> |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | <none> |
| `practitioner_id` | uniqueidentifier |  | The clinician the episode of care is registered under' |  | <none> |
| `episode_of_care_id` | uniqueidentifier |  | The episode of care (registration to service provider) that the patient is recorded under with this practitioner/clinician |  | <none> |
| `start_date` | datetime(3) |  | start date of the relationship between patient and practitioner |  | <none> |
| `end_date` | datetime(3) |  | end date of the relationship between patient and practitioner |  | <none> |

### patient_uprn (masked)

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `LakehouseDateProcessed` | date(0) |  |  |  |  |
| `LakehouseDateTimeUpdated` | datetime(3) |  |  |  |  |
| `LDSIsDeleted` | bit |  |  |  |  |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | Unique Id of the patient uprn match' |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `registrar_event_id` | uniqueidentifier |  | LDS processing event identifier for the processing of the uprn match |  | <none> |
| `masked_uprn` | varchar(255) |  | the matched unique property reference number, with hashing applied |  | <none> |
| `masked_upsn` | varchar(255) |  | the matched unique street reference number, with hashing applied |  | <none> |
| `masked_postcode` | varchar(255) |  | the masked input postcode |  | <none> |
| `address_format_quality` | varchar(255) |  | The quality of the input address (i.e. 'good') |  | <none> |
| `post_code_quality` | varchar(255) |  | The quality of the input postcode (i.e. 'good') |  | <none> |
| `matched_with_assign` | varchar(255) |  | True/false - was a match possible |  | <none> |
| `qualifier` | varchar(255) |  | type of matched address (residential, child) |  | <none> |
| `classification` | varchar(255) | <to be confirmed> | <to be confirmed> |  | <none> |
| `algorithm` | varchar(255) | <to be confirmed> | <to be confirmed> |  | <none> |
| `match_pattern` | varchar(255) | <to be confirmed> | <to be confirmed> |  | <none> |
| `unstructured_postal_address` | varchar(255) | MUST BE REMOVED | The full input address as a string |  | <none> |
| `lds_end_date_time` | datetime(3) |  | Also known as postal district, the outbound portion of the postcode (i.e. CM3) which denotes a postal distribution centre |  | <none> |

### person (masked)

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | reference to the patient identifier |  | <none> |
| `lds_dataset_id` | uniqueidentifier |  | reference to the source of the data for this item |  | <none> |
| `lds_business_key` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `primary_patient_id` | uniqueidentifier |  | reference to the patient identifier that conforms to the primary representation of the person |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was no longer correct |  | <none> |
| `requesting_patient_record_id` | uniqueidentifier |  | the record identifier for the patient information that was used to trace the patient |  | <none> |
| `unique_reference` | uniqueidentifier |  | the unique identifier for the tracing request | | <none> |
| `requesting_nhs_number_hash` |  binary(32) |  | the hash of the requesting NHS number for tracing | | <none> |
| `sensivitiy_flag` | char(1) |  | the returned value of the sensitivity of the patient |  | <none> |
| `matched_algorithm_indicator` | char(1) |  | reference to the algorithm used to match the patient |  | <none> |
| `requesting_patient_id` | uniqueidentifier |  | reference to the patient that holds the details used in the trace |  | <none> |

### practitioner

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the practitioner' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `gmc_code` | varchar(255) |  | 'The GMC code of the practitioner' |  | gmc_code |
| `title` | varchar(50) |  | The title of the practitioner |  | <none> |
| `first_name` | nvarchar |  | the first name of the practitioner |  | name |
| `last_name` | nvarchar |  | the last name of the practitioner |  | name |
| `name` | nvarchar |  | 'Name of the practitioner' |  | <none> |
| `is_obsolete` | bit |  | true/false - is the practitioner no longer active |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### practitioner_in_role

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the practitioner' |  | <none> |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
| `practitioner_id` | uniqueidentifier |  | 'Unique Id of the practitioner' |  | <none> |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | <none> |
| `role_code` | varchar(5) |  | the role code for the practitioners role |  | <none> |
| `role` | varchar(200) |  | the role description for the practitioners role |  | <none> |
| `date_employment_start` | datetime(3) |  | date from which this role was applicable to the practitioner |  | <none> |
| `date_employment_end` | datetime(3) |  | date from which this role was no longer applicable to the practitioner |  | <none> |

### procedure_request

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the procedure' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_is_deleted` | bit |  | dataset agnostic deletion indicator |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | patient_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | person_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter the procedure was administered at' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | 'Unique Id of the practitioner' |  | practitioner_id |
| `clinical_effective_date` | datetime(3) |  | 'The date the procedure was administered by a clinician' |  | clinical_effective_date |
| `date_precision_concept_id` | int |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `date_recorded` | datetime(3) |  | 'The date the procedure was recorded in the source system' |  | date_recorded |
| `description` | varchar(255) |  | procedure request description |  | <none> |
| `procedure_core_concept_id` | uniqueidentifier |  | 'Reference to the clinical coding of the procedure' |  | non_core_concept_id |
| `status_concept_id` | uniqueidentifier |  | 'Reference to the status of the procedure' |  | status_concept_id |
| `age_at_event` | int |  | 'The age of the patient at the time of the procedure' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `is_confidential` | bit |  | true/false - is the observation marked as confidential/sensitive |  | <none> |
| `is_deleted` | bit |  | source data deletion indicator |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |

### referral_request

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the referral' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_data_initial_received_date` | datetime(3) |  | Date the data was business key was first witnessed by, received by or supplied to LDS |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_is_deleted` | bit |  | LDS standardised and data source agnostic deletion indicator |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `lds_end_date_time` | datetime(3) |  | LDS datetime stamp from which the record version no longer correct/latest |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | organization_id |
| `organisation_id` | uniqueidentifier |  | 'Owning organisation (i.e. publisher)' |  | organization_id |
| `person_id` | uniqueidentifier |  | 'Unique individual across all organisations' |  | person_id |
| `patient_id` | uniqueidentifier |  | 'The organisations record for this person’s registration. Patients may have multiple records across clinical systems and may have registered at an organisation multiple times' |  | patient_id |
| `encounter_id` | uniqueidentifier |  | 'Reference to the encounter the referral was made in' |  | encounter_id |
| `practitioner_id` | uniqueidentifier |  | 'The clinician the activity is recorded against' |  | practitioner_id |
| `unique_booking_reference_number` | varchar(14) |  | unique booking reference number of the referral request |  | <none> |
| `clinical_effective_date` | datetime(3) |  | 'The date the referral was made' |  | clinical_effective_date |
| `date_precision_concept_id` | uniqueidentifier |  | 'Identifies the precision of the clinical effectiveness date to either year (1) month (2) day (5) minute (12) second (13) millisecond (14)' |  | date_precision_concept_id |
| `requester_organisation_id` | uniqueidentifier |  | 'Reference to the organisation that made the refereral request' |  | requester_organization_id |
| `recipient_organisation_id` | uniqueidentifier |  | Organisation identifier of the recipient of the referral request |  | recipient_organization_id |
| `referral_request_priority_concept_id` | int |  | 'Reference to the priority of the referral' |  | referral_request_priority_concept_id |
| `referal_request_type_concept_id` | int |  | 'Reference to the type of referral request' |  | referral_request_type_concept_id |
| `referral_request_specialty_concept_id` | int |  | Reference to the specialty of the referral' |  | referral_request_type_concept_id |
| `mode` | varchar(50) |  | 'The mode of the referral' |  | mode |
| `is_outgoing_referral` | bit |  | 'Whether this is an outgoing referral' |  | outgoing_referral |
| `is_review` | bit |  | 'Whether this referral is a review' |  | is_review |
| `referral_request_raw_concept_id` | bigint |  | The raw clinical coding of primary diagnosis |  | non_core_concept_id |
| `referral_request_core_concept_id` | bigint |  | The SNOMED clinical coding of primary diagnosis |  | core_concept_id |
| `age_at_event` | int |  | 'The age of the patient at the time of the referral' |  | age_at_event |
| `age_at_event_baby` | int |  | The age the patient was at the time of this event if less than one year old, else a calculated value representing an age category |  | <none> |
| `age_at_event_neonate` | int |  | The age the patient was at the time of this event if less than 28 days, else a calculated value representing an age category |  | <none> |
| `date_recorded` | datetime(3) |  | 'The date the referral request was added to the source system' |  | date_recorded |

### schedule

| Column Name | Data Type | STATUS | Comment | Foreign Key Reference | Compass Equivalent |
| --- | --- | ---- | ---- | ---- | ---- |
| `LakehouseDateProcessed` | date(0) |  |  |  |  |
| `LakehouseDateTimeUpdated` | datetime(3) |  |  |  |  |
| `LDSIsDeleted` | bit |  |  |  |  |
| `lds_id` | uniqueidentifier |  | LDS assigned unique identifier for this common modelled record version |  | <none> |
| `id` | uniqueidentifier |  | 'Unique Id of the schedule' |  | id |
| `lds_business_key` | varchar(8000) |  | Natural or source key for the unique event/entity of the table (unique allergy intolerance record) |  | <none> |
| `lds_dataset_id` | tinyint |  | LDS assigned identifier for the source dataset |  | <none> |
| `lds_datetime_data_acquired` | datetime(3) |  | Date the data was extracted by, received by or supplied to LDS |  | <none> |
| `lds_start_date_time` | datetime(3) |  | LDS datetime stamp from which the record version was correct |  | <none> |
| `record_owner_organisation_code` | varchar(50) |  | Organisation code for the organisation that owns the record |  | <none> |
| `location_id` | uniqueidentifier |  | Reference to the location of the schedule |  | <none> |
| `location` | varchar(100) |  | 'Textual description of the location the schedule was held at' |  | location |
| `practitioner_id` | uniqueidentifier |  | 'Reference to the practitioner who owns the schedule' |  | practitioner_id |
| `start_date` | datetime(3) |  | 'The start date of the schedule' |  | start_date |
| `end_date` | datetime(3) |  | The end date of the schedule' |  | <none> |
| `type` | varchar(255) |  | 'The type of schedule eg Timed Appointments' |  | type |
| `name` | varchar(150) |  | 'The name of the schedule' |  | name |
| `is_private` | bit |  | true/false - is the schedule marked as private |  | <none> |

### schedule_practitioner

## [OLIDS_PCD] Schema

This will be added in due course. (5 tables)

## [OLIDS_TERMINOLOGY] Schema

This will be added in due course. (2 tables)
