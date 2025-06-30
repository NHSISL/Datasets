# OLIDS Known Issues

- [OLIDS Known Issues](#olids-known-issues)
  - [Schema issues](#schema-issues)
    - [general](#general)
    - [allergy\_intolerance](#allergy_intolerance)
    - [diagnostic\_order](#diagnostic_order)
    - [encounter](#encounter)
    - [medication\_order](#medication_order)
    - [medication\_statement](#medication_statement)
    - [observation](#observation)
    - [person](#person)
    - [person\_address (masked)](#person_address-(masked))
    - [person (masked)](#person-(masked))
    - [practitioner](#practitioner)
    - [procedure\_request](#procedure_request)
    - [referral\_request](#referral_request)

The below is a report of the currently known issues within the One London Integrated Data Set (OLIDS)

## Schema issues

### general

- There is general inconsistency of the inclusion or exclusion of the fields `lds_start_date_time` and `lds_end_date_time`. These fields are system fields to denote the lifespan of the version of the record with the stated business key. They are of no value for analytical purposes. As such we will likely remove these in future releases.
- There is a general inconsistency of the inclusion of exclusion of the fields `lds_is_deleted` and `is_deleted`. The former is the dataset agnostic deletion indicator, the latter is the dataset source systems own indicator. In relational stores the service will be applying deletions and hence all records will be in an active state only. This therefore means that these fields may not be required and may simply cause confusion by their inclusion in the tables. As such we will likely remove these in future releases.

### allergy_intolerance

- The field `allergy_intolerance_core_concept_id` is reflective of the unmapped concept and is labelled incorrectly. This should be relabeled as a **raw_concept_id** i.e. `allergy_intolerance_raw_concept_id`
- The field `allergy_intolerance_raw_concept_id` is currently unmapped and is empty (all `null`)

### diagnostic_order

- The field `diagnostic_order_core_concept_id` is reflective of the snomed code contained in the dimension table supplied by EMIS. This is prone to errors and as a result should not be shown. Instead users should apply mapping using the terminology tables supplied, via a join to the `diagnostic_order_raw_concept_id`. This field will be removed.
- **TO BE CONFIRMED:** The field `is_primary` is not defined correctly and will display `FALSE/0` for all records.

### encounter

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `encounter_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `encounter_raw_concept_id` as a result in future releases.

### medication_order

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `medication_order_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `medication_order_raw_concept_id` as a result in future releases.

### medication_statement

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `medication_statement_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `medication_statement_raw_concept_id` as a result in future releases.

### observation

- the field `observation_raw_concept_id` is set to `null` for all items.
- the field `observation_core_concept_id` is reflective of the source datas encoding (or surrogate key value) and is therefore a **raw** concept. This should be relabelled as such. This will be relabelled as `observation_raw_concept_id` and will replace the existing field of the same name.
- the field `is_problem` is **not** defined correctly and will display `TRUE/1` for all records.
- the field `is_primary` is **not** defined correctly and will display `FALSE/0` for all records.

### person

- the field `organisation_id` is missing.

### person_address (masked)

- the field `organisation_id` is missing.

### person (masked)

- `primary_patient_id` is incorrectly labelled as `LDSBusinessId_PrimaryPatient`.
- `matched_nhs_number_hash` is missing an underscore, and is incorrectly shown as `matched_nhs_numberhash`

### practitioner

- the field `organisation_id` is missing.

### procedure_request

- the field `procedure_core_concept_id` is a reflection of the source datas encoding (or surrogate key), and should be labelled as such as a **raw** concept. This field will be relabelled to `procedure_raw_concept_id`
- the field `organisation_id` is missing.
- the field `status_concept_id` is a reflection of the source datasets representation of the concept, but does undergo transformation to standardise this representation (expressed as boolean columns in the source). It will be confirmed whether this should be relabelled as **raw** or left as is.

### referral_request

- the field `referral_request_priority_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabbeld as `referral_request_priority_raw_concept_id` at a later release.
- the field `referal_request_type_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabbeld as `referral_request_type_raw_concept_id` at a later release.
- the field `referral_request_specialty_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabbeld as `referral_request_specialty_raw_concept_id` at a later release.
- the field `encounter_id` is currently hardcoded to `null` for all EMIS data. We will investigate if it is possible to map this safely in a future release (using the `CareRecord_Observation` field `ConsultationGuid`, which is a foreign key to the table `CareRecord_Consultation` which is used to populate the `encounter` OLIDS table)
