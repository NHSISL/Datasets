create or replace TABLE "Data_Store_OLIDS_Dummy".OLIDS_MASKED.OBSERVATION (
	"lds_id" VARCHAR(16777216),
	"id" VARCHAR(16777216),
	"lds_business_key" VARCHAR(16777216),
	"lds_dataset_id" VARCHAR(16777216),
	"lds_datetime_data_acquired" TIMESTAMP_NTZ(9),
	"lds_initial_data_received_date" TIMESTAMP_NTZ(9),
	"lds_start_date_time" TIMESTAMP_NTZ(9),
	"record_owner_organisation_code" VARCHAR(16777216),
	"patient_id" VARCHAR(16777216),
	"encounter_id" VARCHAR(16777216),
	"practioner_id" VARCHAR(16777216),
	"parent_obervation_id" VARCHAR(16777216),
	"clinical_effective_date" TIMESTAMP_NTZ(9),
	"date_precision_concept_id" VARCHAR(16777216),
	"result_value" FLOAT,
	"result_value_unit_concept_id" VARCHAR(16777216),
	"result_date" DATE,
	"result_text" VARCHAR(16777216),
	"is_problem" BOOLEAN,
	"is_review" BOOLEAN,
	"problem_end_date" TIMESTAMP_NTZ(9),
	"observation_raw_concept_id" VARCHAR(16777216),
	"observation_core_concept_id" VARCHAR(16777216),
	"age_at_event" NUMBER(38,0),
	"age_at_event_baby" NUMBER(38,0),
	"age_at_event_neonate" NUMBER(38,0),
	"episodicity_concept_id" VARCHAR(16777216),
	"is_primary" BOOLEAN,
	"date_recorded" TIMESTAMP_NTZ(9),
	"is_problem_deleted" BOOLEAN,
	"is_confidential" BOOLEAN
);