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


The below is a report of the currently known issues within the One London Integrated Data Set (OLIDS)

## Schema issues

### general

- There is general inconsistency of the inclusion or exclusion of the fields `lds_start_date_time` and `lds_end_date_time`. These fields are system fields to denote the lifespan of the version of the record with the stated business key. They are of no value for analytical purposes. As such we will likely remove these in future releases.

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
