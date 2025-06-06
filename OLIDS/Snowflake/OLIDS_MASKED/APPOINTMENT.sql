create or replace TABLE "Data_Store_OLIDS_Dummy".OLIDS_MASKED.APPOINTMENT (
	"lds_id" VARCHAR(16777216),
	"id" VARCHAR(16777216),
	"lds_business_key" VARCHAR(16777216),
	"lds_dataset_id" VARCHAR(16777216),
	"record_owner_organisation_code" VARCHAR(16777216),
	"lds_datetime_data_acquired" TIMESTAMP_NTZ(9),
	"lds_initial_data_received_date" TIMESTAMP_NTZ(9),
	"lds_start_date_time" TIMESTAMP_NTZ(9),
	"organisation_id" VARCHAR(16777216),
	"person_id" VARCHAR(16777216),
	"patient_id" VARCHAR(16777216),
	"practitioner_in_role_id" VARCHAR(16777216),
	"schedule_id" VARCHAR(16777216),
	"start_date" TIMESTAMP_NTZ(9),
	"planned_duration" NUMBER(38,0),
	"actual_duration" NUMBER(38,0),
	"appointment_status_concept_id" VARCHAR(16777216),
	"patient_wait" NUMBER(38,0),
	"patient_delay" NUMBER(38,0),
	"date_time_booked" TIMESTAMP_NTZ(9),
	"date_time_sent_in" TIMESTAMP_NTZ(9),
	"date_time_left" TIMESTAMP_NTZ(9),
	"cancelled_date" TIMESTAMP_NTZ(9),
	"type" VARCHAR(16777216),
	"age_at_event" NUMBER(38,0),
	"age_at_event_baby" NUMBER(38,0),
	"age_at_event_neonate" NUMBER(38,0),
	"booking_method_concept_id" VARCHAR(16777216),
	"contact_mode_concept_id" VARCHAR(16777216)
);