# Practitioner

- [Practitioner](#practitioner)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity Relationships](#entity-relationships)
  - [Notes](#notes)
    - [Name Field Differences](#name-field-differences)
      - [EMIS Data](#emis-data)
      - [TPP Data](#tpp-data)
      - [Why Names Are Not Split for TPP](#why-names-are-not-split-for-tpp)
      - [Impact on Users](#impact-on-users)
        - [Querying Practitioner Names](#querying-practitioner-names)
      - [Data Quality Checks](#data-quality-checks)
        - [Important Context: Historical DQ Checks](#important-context-historical-dq-checks)
        - [Validation Query: Source-Aware NULL Check](#validation-query-source-aware-null-check)
      - [Best Practices for Developers](#best-practices-for-developers)
      - [Future Considerations](#future-considerations)
    - [Support](#support)
  
## Overview

Practitioner covers all individuals who are engaged in the healthcare process and healthcare-related services as part of their formal responsibilities and this Resource is used for attribution of activities and responsibilities to these individuals. Practitioners include (but are not limited to):

- physicians, dentists, pharmacists
- physician assistants, nurses, scribes
- midwives, dietitians, therapists, optometrists, paramedics
- medical technicians, laboratory scientists, prosthetic technicians, radiographers
- social workers, professional homecare providers, official volunteers
- receptionists handling patient registration
- IT personnel merging or unmerging patient records
- service animal (e.g., ward assigned dog capable of detecting cancer in patients)
- a bus driver for a community organisation
- a lawyer acting for a hospital or a patient
- a person working for a supplier of a healthcare organisation

The Practitioner resource is used for anyone involved in the provision of care or services to a Patient associated with an organisation. The RelatedPerson resource is used for anyone involved in the care for a patient, typically having a personal *relationship *or non-healthcare-specific professional relationship to the patient.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK |
| --- | --- | --- | --- |
| `ID` | `UUID` | id. | PK |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. | - |
| `PUBLISHER_ORGANISATION_ID` | `UUID` | organisation id of the record publisher^1^. | FK -> [Organisation](Organisation.md).ID |
| `AUTHOR_ORGANISATION_ID` | `UUID` | organisation id record author^1^. | FK -> [Organisation](Organisation.md).ID |
| `GMC_CODE` | `VARCHAR` | general medical council code | - |
| `TITLE` | `VARCHAR` | practitioners title. | - |
| `FIRST_NAME` | `VARCHAR` | practitioners first/given name. | - |
| `SURNAME` | `VARCHAR` | practitioners surname. | - |
| `NAME` | `VARCHAR` | practitioners full name. | - |
| `IS_OBSOLETE` | `BOOLEAN` | is practitioner record obsolete. | - |
| `LDS_IS_DELETED` | `BOOLEAN` | is the practitioner record deleted in the source system. | - |
| `PUBLISHER_ORGANISATION_CODE` | `VARCHAR` | The ODS<sup>1<\sup> code of the organisation (data controller) who publishes the data. | - |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. | - |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | the timestamp when the transform process that generated this record. | - |

## Entity Relationships

| Related Table | Relationship Type | Local Key | Related Key | Notes |
| --- | --- | --- | --- | --- |
| [Organisation](Organisation.md) | FK | PUBLISHER_ORGANISATION_ID | ID | - |
| [Organisation](Organisation.md) | FK | AUTHOR_ORGANISATION_ID | ID | - |

## Notes

### Name Field Differences

The `PRACTITIONER` table in OLIDS contains columns for storing practitioner name information: `TITLE`, `FIRST_NAME`, `LAST_NAME`, and `NAME`. However, users should be aware that these fields are populated differently depending on the source system supplier (TPP vs EMIS), which can result in `NULL` values in certain columns.

#### EMIS Data

EMIS provides practitioner names as **separate components**:

- `FIRST_NAME` and `LAST_NAME` are populated with discrete values
- `NAME` is constructed by concatenating `FIRST_NAME` and `LAST_NAME`
- All three fields typically contain values

An EMIS record will therefore show as below:

| FIRST_NAME | LAST_NAME | NAME |
| --- | --- | --- |
| `Frank` | `Drebin` | `Frank Drebin` |

#### TPP Data

TPP provides practitioner names as a **single concatenated field**:

- `NAME` contains the full practitioner name as provided by TPP
- `FIRST_NAME` and `LAST_NAME` are **NULL**
- The platform does **not** attempt to split the `NAME` field into components

A TPP sourced record will therefore show as below:

| FIRST_NAME | LAST_NAME | NAME |
| --- | --- | --- |
| `NULL` | `NULL` | `Frank Drebin` |

#### Why Names Are Not Split for TPP

The decision not to split TPP's `NAME` field into `FIRST_NAME` and `LAST_NAME` is intentional and based on several technical considerations:

1. **Name complexity:** Many practitioner names contain three or more parts (e.g., "Dr John Michael Smith-Jones"), making it impossible to reliably determine which parts represent the first name versus last name

1. **No consistent pattern:** Names do not follow a standard format that would allow safe algorithmic splitting

1. **Data integrity:** Attempting to split complex names could result in:
   - Incorrect attribution of name parts
   - Loss of titles, middle names, or suffixes
   - Misidentification in systems relying on accurate name components

1. **Schema parity:** The `FIRST_NAME` and `LAST_NAME` columns are not provided in the Discovery Data Service (DDS), so maintaining NULL values brings the OLIDS schema into alignment with DDS standards

#### Impact on Users

##### Querying Practitioner Names

When querying practitioner data, users should account for this difference:

**❌ Incorrect approach (assumes all sources populate FIRST_NAME/LAST_NAME):**

```sql
-- This will miss TPP practitioners
SELECT 
    ID,
    FIRST_NAME,
    LAST_NAME
FROM "Data_Store_OLIDS_UAT".OLIDS_COMMON.PRACTITIONER
WHERE FIRST_NAME IS NOT NULL;
```

**✅ Correct approach (uses NAME field as primary source):**

```sql

-- This captures both EMIS and TPP practitioners
SELECT 
    ID,
    NAME,
    COALESCE(FIRST_NAME, '') AS FIRST_NAME,
    COALESCE(LAST_NAME, '') AS LAST_NAME,
    CASE 
        WHEN FIRST_NAME IS NULL AND LAST_NAME IS NULL THEN 'TPP'
        ELSE 'EMIS'
    END AS DATA_SOURCE_TYPE
FROM "Data_Store_OLIDS_UAT".OLIDS_COMMON.PRACTITIONER;
```

#### Data Quality Checks

Thsi will be monitored as part of the **NULL Column Report by Data Supplier**.

##### Important Context: Historical DQ Checks

**December 2025 Data Quality Assessment:**

- Initial data quality checks undertaken in December 2025 primarily examined **EMIS-processed data**
- These checks **did not account for the volume of TPP data** that has subsequently been processed
- As TPP data volume has increased, the proportion of records with NULL `FIRST_NAME` and `LAST_NAME` fields has grown accordingly

**Current Monitoring:**

- The LDS team is producing a **NULL Column Report by Data Supplier**
- This report will formally document that `FIRST_NAME` and `LAST_NAME` are **expected to be NULL** for TPP practitioner records
- NULL values in these fields for TPP data are **not data quality issues** - they are the intended behavior until there is a change in approach

**Implications for testing and validation:**

1. Do not flag NULL `FIRST_NAME`/`LAST_NAME` as data quality failures for TPP records
1. Baseline DQ metrics from December 2025 should be updated to reflect current TPP data volumes
1. Any automated DQ checks should be source-aware (TPP vs EMIS) when validating name fields
1. Future DQ assessments should stratify results by data source

##### Validation Query: Source-Aware NULL Check

Use this query to validate that NULL name fields align with expected data sources:

```sql
-- Validate NULL patterns match expected data sources

SET DB_NAME = 'Data_Store_OLIDS_UAT';

SELECT 
    CASE 
        WHEN p.LDS_DATASET_ID = '07F337BD-E189-484A-9350-D9C6442AA829' THEN 'PrimaryCare_TPP'
        WHEN p.LDS_DATASET_ID = '6A62313A-7442-462E-B6E8-DEC541DDD0BA' THEN 'PrimaryCare_EMIS'
        ELSE 'Other'
    END AS DATASET_NAME,
    COUNT(*) AS TOTAL_RECORDS,
    SUM(CASE WHEN FIRST_NAME IS NULL THEN 1 ELSE 0 END) AS NULL_FIRST_NAME,
    SUM(CASE WHEN LAST_NAME IS NULL THEN 1 ELSE 0 END) AS NULL_LAST_NAME,
    SUM(CASE WHEN NAME IS NULL THEN 1 ELSE 0 END) AS NULL_NAME,
    ROUND(100.0 * SUM(CASE WHEN FIRST_NAME IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS PCT_NULL_FIRST_NAME,
    ROUND(100.0 * SUM(CASE WHEN LAST_NAME IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS PCT_NULL_LAST_NAME,
    ROUND(100.0 * SUM(CASE WHEN NAME IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS PCT_NULL_NAME
FROM IDENTIFIER($DB_NAME || '.OLIDS_COMMON.PRACTITIONER') p
WHERE p.LDS_DATASET_ID IN (
    '07F337BD-E189-484A-9350-D9C6442AA829',  -- TPP
    '6A62313A-7442-462E-B6E8-DEC541DDD0BA'   -- EMIS
)
GROUP BY DATASET_NAME
ORDER BY DATASET_NAME;
```

**Expected validation results:**

| DATASET_NAME     | PCT_NULL_FIRST_NAME | PCT_NULL_LAST_NAME | PCT_NULL_NAME |
| ---------------- | ------------------- | ------------------ | ------------- |
| PrimaryCare_TPP  | ~100%               | ~100%              | <1%           |
| PrimaryCare_EMIS | <5%                 | <5%                | <1%           |

Any significant deviation from these expected patterns should be investigated as a potential data processing issue.

#### Best Practices for Developers

1. **Always use the NAME field** as the primary source of practitioner name information in reports and applications
1. **Handle NULL gracefully** when using `FIRST_NAME` and `LAST_NAME` fields - use `COALESCE()` or `CASE` statements
1. **Do not filter on `FIRST_NAME` or `LAST_NAME`** unless you intentionally want to exclude TPP practitioners
1. **Document assumptions** in your queries and reports about name field usage
1. **Consider search functionality** - when implementing practitioner search, ensure the `NAME` field is included in search criteria:

  ```sql
   WHERE NAME ILIKE '%Smith%'
   ```

#### Future Considerations

The development team has considered three potential options for addressing this gap:

1. **Do nothing** (current approach) - Maintains data integrity and avoids incorrect name splitting
1. **Remove FIRST_NAME and LAST_NAME columns** - Would bring schema into full parity with DDS
1. **Attempt algorithmic splitting** - High risk of errors; would require complex logic or machine learning approaches

**Current decision:** The platform will continue with option 1 (do nothing) to maintain data quality and integrity. Users should design queries and applications with this understanding.

### Support

For questions or issues related to practitioner name data, please:

1. Check this documentation first
1. Review the schema dictionary for field definitions
1. Contact the data platform team via your standard support channels
