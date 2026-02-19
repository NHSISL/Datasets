# Release 282: Schema Changes

Release 282 introduces the following schema changes.

These changes have been updated in the [OLIDS schema dictionary](/OLIDS/Documentation/OLIDS-schema-dictionary.md)

## 🏗️ Structural schema changes: Table summary

The list below only provides guidance on changes to the structure of tables (data types, addition or removal of columns). It will **not** cover logic or transform based changes that affect the population of these columns.

### 📃 COMMON schema objects

- `ALLERGY_INTOLERANCE` - no schema changes
- `APPOINTMENT` - no schema changes
- `APPOINTMENT_PRACTITIONER` - no schema changes
- `DIAGNOSTIC_ORDER` - no schema changes
- `ENCOUNTER` - no schema changes
- `EPISODE_OF_CARE` - **see change details below**
- `FLAG` - no schema changes
- `LOCATION` - no schema changes
- `LOCATION_CONTACT` - no schema changes
- `MEDICATION_ORDER` - no schema changes
- `MEDICATION_STATEMENT` - no schema changes
- `OBSERVATION` - no schema changes
- `ORGANISATION` - no schema changes
- `PATIENT_PERSON` - no schema changes
- `PATIENT_REGISTERED_PRACTITIONER_IN_ROLE` - no schema changes
- `PRACTITIONER_IN_ROLE` - no schema changes
- `PRACTITIONER` - no schema changes
- `PROCEDURE_REQUEST` - no schema changes
- `REFERRAL_REQUEST` - no schema changes
- `SCHEDULE` - no schema changes
- `SCHEDULE_PRACTITIONER` - no schema changes

### 📃 MASKED schema objects

- `PATIENT_ADDRESS` - no schema changes
- `PATIENT_CONTACT` - no schema changes
- `PATIENT_UPRN` - no schema changes
- `PATIENT` - no schema changes
- `PERSON` - no schema changes

### 📃 PCD schema objects

- `PATIENT_ADDRESS` - no schema changes
- `PATIENT_CONTACT` - no schema changes
- `PATIENT_UPRN` - no schema changes
- `PATIENT` - no schema changes
- `PERSON` - no schema changes

## Structural change details

### ℹ️ Structural change notes

- `EPISODE_OF_CARE`: 
  - The addition of the `ORGANISATION_CODE_PUBLISHER` has been made as an addition, rather than as a rename, due to the current use of the column to perform data quality and assurance tests prior to issuance of the shares in snowflake. If users accept the proposed renaming, this will be applied to all tables and the existing `RECORD_OWNER_ORGANISATION_CODE` will be removed. The ordinal position of the owner column has been shifted to the end of the table to prepare for this change.
  - The evaluation of the casting of uniqueidentifier data type to binary data type is expected to prove desireable. Upon confirmation of this, it is likely that all such datatypes in OLIDS will be recasted to this data type. This includes most of the identifiers in the schema. We are likely to retain an audit column of `LDS_SOURCE_RECORD_GUID` and `LDS_PATIENT_GUID` for lineage tracking back into the MSSQL services only, at least within the `PATIENT` table.
  - Note that the "MANAGING" organisation and the "PUBLISHER" organisation can differ. This is particularly prevelant in SystmOne, but is also common within EMIS/Optum data. In the vast majority of use cases, end users will likely wish to focus on 'internal' episodes only; that is where the managing organisation and the publishing organisation are the same. We would appreciate feedback from end users on whether a derived `EXTERNALITY` column - either as text, boolean or as a concept - would be of use to users to quickly filter or group on the basis of whether the managing organisation is the publishing organisation or not.

### Episode of Care changes

#### ✏️ Renamed or Altered columns

- ✏️ Rename `ORGANISATION_ID` to `ORGANISATION_ID_PUBLISHER` - _this clarifies that the column relates to the data controller of the record, rather than to the manager of care. Joins to `ORGANISATION.ID`. Intended to tie in with proposed renaming of `RECORD_OWNER_ORGANSIATION_CODE` to `ORGANISATION_CODE_PUBLISHER`. See added columns below._

- ✏️ Rename `LDS_DATASET_ID` to `LDS_SOURCE_DATASET_ID` - _this clarifies that the column relates to the originating source dataset that informed the OLIDS record. Intended to tie in with proposed renaming of `LDS_RECORD_ID`, see `LDS_SOURCE_RECORD_ID` in added columns below._

- ✏️ Rename `LDS_DATETIME_DATA_ACQUIRED` to `LDS_DATETIME_SOURCE_RECORD_ACQUIRED` - _proposed change enacted for consideration to be applied to all tables. Clarifies that this is a datetime when the source base record (entity) was originally acquired by the service._

- ✏️ Rename `LDS_INITIAL_DATA_RECEIVED_DATE` to `LDS_DATETIME_SOURCE_RECORD_UPDATED` - _proposed change enacted for consideration to be applied to all tables. Clarifies that this is a datetime when the source base record (entity) was updated by the sender to the service._

#### ➕ Added columns

- ➕ `LDS_SOURCE_RECORD_ID` - _proposed renaming for `LDS_RECORD_ID`, this clarifies that the information relates to the originating supplied (i.e. EMIS or TPP) record, rather than to the generated OLIDS record. If accepted this would be applied to all tables_.

- ➕ `ORGANISATION_CODE_PUBLISHER` - _proposed renaming for `RECORD_OWNER_ORGANISATION_CODE`, this is the ODS code of the organisation leading / delivering the episode of care_

- ➕ `ORGANISATION_CODE_MANAGING` - _this is the ODS code of the organisation leading / delivering the episode of care_

- ➕ `ORGANISATION_ID_MANAGING` - _this is the OLIDS ID of the organisation leading / delivering the episode of care. Joins to `ORGANSIATION.ID`_

- ➕ `LDS_SOURCE_RECORD_BINARY_ID` - _this is a temporary ID added to evaluate the casting of unique-identifier data types from MSSQL to binary types preferred by snowflake. See notes further below._

- ➕ `LDS_SOURCE_RECORD_SHARD_ID` - _this is a temporary ID added to evaulate the effectiveness of using sharding and clustering to optimise data allocation joining and distribution in snowflake. It is a deterministic grouping of 50,000 possible values based on a modulus operation on the record ID._

#### ➖ Removed columns

- No columns removed (only renamed)
