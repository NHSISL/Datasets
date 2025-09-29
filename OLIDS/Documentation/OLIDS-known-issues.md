# OLIDS Known Issues

- [OLIDS Known Issues](#olids-known-issues)
  - [Open issues](#open-issues)
    - [batch processing gaps](#batch-processing-gaps)
    - [general](#general)
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
    - [patient](#patient)
    - [patient\_address](#patient_address)
    - [patient\_contact](#patient_contact)
    - [patient\_person](#patient_person)
    - [patient\_registered\_practitioner\_in\_role](#patient_registered_practitioner_in_role)
    - [patient\_uprn](#patient_uprn)
    - [person](#person)
    - [practitioner](#practitioner)
    - [procedure\_request](#procedure_request)
    - [referral\_request](#referral_request)
    - [person (pcd)](#person-(pcd))
  - [Fixed issues](#fixed-issues)
    - [Fixed: `appointment_practitioner` issues](#fixed%3A-%60appointment_practitioner%60-issues)
    - [Fixed: `encounter` issues](#fixed%3A-%60encounter%60-issues)
    - [Fixed: `medication_order` issues](#fixed%3A-%60medication_order%60-issues)
    - [Fixed: `medication_statement` issues](#fixed%3A-%60medication_statement%60-issues)
    - [Fixed: `observation` issues](#fixed%3A-%60observation%60-issues)
    - [Fixed: `patient_address` issues](#fixed%3A-%60patient_address%60-issues)
  - [Features reported as issues](#features-reported-as-issues)
    - [issues raised under `person` table](#issues-raised-under-%60person%60-table)
    - [issues raised under `patient_contact`](#issues-raised-under-%60patient_contact%60)
    - [issues raised under `flag`](#issues-raised-under-%60flag%60)
    - [issues raised under `practitioner`](#issues-raised-under-%60practitioner%60)
    - [issues raised under `procedure_request`](#issues-raised-under-%60procedure_request%60)

The below is a report of the currently known issues within the One London Integrated Data Set (OLIDS)

## Open issues

### batch processing gaps

- A number of batches of data have failed at various stages of the Data Engine. This will result in some practices having a lower than expected record count. These will be detailed in due course.

### general

- There is some residual inconsistency of the inclusion or exclusion of the fields `lds_start_date_time` and `lds_end_date_time`. These fields are system fields to denote the lifespan of the version of the record with the stated business key. They are of no value for analytical purposes. As such we will likely remove some remaining `lds_end_date_time` columns in future releases.

- [Bug ticket: #23422](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23422/) There is some residual inconsistency of the inclusion of exclusion of the fields `lds_is_deleted` and `is_deleted`. The former is the dataset agnostic deletion indicator, the latter is the dataset source systems own indicator. We will not be applying deletes within the OLIDS dataset, instead the `lds_is_deleted` value will be set to `1`.

### allergy_intolerance

- [Bug ticket: #23422](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23422/) `person_id` column is present, but not populated. This is due to a misalignment of dates used to filter out inactive person records. 

### appointment

- No known issues specific to this table

### appointment_practitioner

- No known issues specific to this table

### diagnostic_order

- [Bug ticket: #24949](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24949/): The field `is_primary` is not defined correctly and will display `FALSE/0` for all records.

### encounter

- [Bug ticket: #24964](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24964): The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.

### episode_of_care

- We are aware that this table may contain an inflated count of registration episodes. Further analysis and examples are required to investigate this.

### flag

- No known issues specific to this table

> [!Warning]
> **Mapping limitation:** This table is not populated for EMIS practices. There is currently no mapping possible from EMIS tables into this object. Please note that this is technically not an issue, but is mentioned here to avoid being raised as an issue.

### location

- No known issues specific to this table

### location_contact

- No known issues specific to this table

### medication_order

- [Bug ticket: #25009](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25009): The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.

### medication_statement

- [Bug ticket: #25010](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25010): The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.

### observation

- [Bug ticket: #25011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25011): the field `is_problem` is **not** defined correctly and will display `TRUE/1` for all records.
- [Bug ticket: #25012](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25012): the field `is_primary` is **not** defined correctly and will display `FALSE/0` for all records.

### organisation

- No known issues specific to this table

### patient

- No known issues specific to this table

### patient_address

- No known issues specific to this table

### patient_contact

- No known issues specific to this table

### patient_person

- No known issues specific to this table (see [person](#person) also)

### patient_registered_practitioner_in_role

- No known issues specific to this table

### patient_uprn

- No known issues specific to this table

### person

- [Story ticket: #24112](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24112) / [Story ticket: #24246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24246): The person table currently represents a unique response from a Person Demographics Services tracing request. As such patients who receive a response with a common NHS number are assigned different person_id values, despite having a common NHS number. A feature enhancement is currently underway to alter this such that patients with a response that shares the same NHS number will be assigned a shared `person_id`

### practitioner

- No known issues specific to this table

### procedure_request

- No known issues specific to this table
- Potential for column name change for consistency:
    > [!NOTE]
    > the field `status_concept_id` is a reflection of the source datasets representation of the concept, but does undergo transformation to standardise this representation (expressed as boolean columns in the source). It will be confirmed whether this should be relabelled as `status_source_concept_id` or left as is.

### referral_request

- the field `referral_request_priority_concept_id` is reflective of the source datasets coding system and is therefore a **source** concept. This should be relabelled as such. This field will be relabeled as `referral_request_priority_source_concept_id` at a later release.

- the field `referral_request_type_concept_id` is reflective of the source datasets coding system and is therefore a **source** concept. This should be relabelled as such. This field will be relabeled as `referral_request_type_source_concept_id` at a later release.

- the field `referral_request_specialty_concept_id` is reflective of the source datasets coding system and is therefore a **source** concept. This should be relabelled as such. This field will be relabeled as `referral_request_specialty_source_concept_id` at a later release.

- the field `encounter_id` is currently hardcoded to `null` for all EMIS data. We will investigate if it is possible to map this safely in a future release (using the `CareRecord_Observation` field `ConsultationGuid`, which is a foreign key to the table `CareRecord_Consultation` which is used to populate the `encounter` OLIDS table)

### person (pcd)

- The fields “telephone_number”, “mobile_number”, “email_address”, “sensitivity_flag” and “mps_id” are set to null to mitigate a formatting error in the source data which would otherwise risk the leaking of identifying data. Contact information in patient_contact is unaffected. Sensitive patient filtering is based on error_success_code so is unaffected.
  
- The birth date of the patient is presented as returned by PDS, however no determination of date precision not conversion to date (from varchar) is applied.
- the birth week (iso) is not currently derived.
- the death date of the patient is presented as returned by PDS, however no determination of date precision not conversion to date (from varchar) is applied.
- the death week (iso) is not currently derived.
- the following fields are labelled by PDS as to be ignored, but are still currently displayed in the person object, these will be removed in a subsequent release:
  - `as_at_date`
  - `local_patient_id`
  - `internal_id`
  - `mps_id`

<hr>

## Fixed issues

### Fixed: `appointment_practitioner` issues

- `appointment_practitioner` table: contains a significantly inflated volume of records due to the manner in which business id (`id` column) values are being generated by the common modelling transforms. Each batch will simply add to the table, rather than merge into the table. **This is now resolved.**

### Fixed: `encounter` issues

- `encounter` table: The field `encounter_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is the concept as presented in the source data and should be relabelled as such. This will be relabelled as `encounter_source_concept_id` as a result in future releases.

### Fixed: `medication_order` issues

- The field `medication_order_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is the concept as presented in the source data and should be relabelled as such. This will be relabelled as `medication_order_source_concept_id` as a result in future releases.

### Fixed: `medication_statement` issues

- The field `medication_statement_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is the concept as presented in the source data and should be relabelled as such. This will be relabelled as `medication_statement_source_concept_id` as a result in future releases.

### Fixed: `observation` issues

- the field `observation_raw_concept_id` is set to `null` for all items

- the field `observation_core_concept_id` is reflective of the source data's encoding (or surrogate key value) and is therefore a **raw** concept. This should be relabelled as such. This will be relabelled as `observation_source_concept_id` and will replace the existing field of the same name.

### Fixed: `patient_address` issues

- the field `organisation_id` is missing
    > [!TIP]
    > This is shown as `record_owner_organisation_code` in the OLIDS table.

## Features reported as issues

### issues raised under `person` table

- issue raised: "the field `organisation_id` is missing."
  > [!TIP]
  > The person table represents a unique NHS number reported back from a Person Demographics Services trace of the patient information (or where no NHS number is resolved, the unique business key of the patient). 
  >
  > The intention of this table is to resolve multiple reported 'patients' to a shared 'person' entity. As such this table will not contain records that can be designated to a single practice / organisation_id.

### issues raised under `patient_contact`

- This table contains duplicate `lds_record_id` values 
  > [!TIP]
  > please note that this is not a bug and is by design as some source records are pivoted-out in scenarios where each method of contact is presented in the source data as separate columns, to being presented as separate rows.

### issues raised under `flag`

- Table is empty in EMIS only regions
    > [!Warning]
    > **Mapping limitation:** This table is not populated for EMIS practices. There is currently no mapping possible from EMIS tables into this object. Please note that this is technically not an issue, but is mentioned here to avoid being raised as an issue.

### issues raised under `practitioner`

- the field `organisation_id` is missing.
    > [!TIP]
    > This has been added as `record_owner_organisation_code`

### issues raised under `procedure_request`

- the field `procedure_core_concept_id` is a reflection of the source data's encoding (or surrogate key), and should be labelled as such as a **source** concept. This field will be relabelled to `procedure_source_concept_id`
- the field `organisation_id` is missing.    
   > [!TIP]
   > This has been added as `record_owner_organisation_code`