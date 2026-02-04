# PRACTITIONER Table

## Understanding Name Field Differences

### Overview

The `PRACTITIONER` table in OLIDS contains columns for storing practitioner name information: `TITLE`, `FIRST_NAME`, `LAST_NAME`, and `NAME`. However, users should be aware that these fields are populated differently depending on the data source (TPP vs EMIS), which can result in NULL values in certain columns.

### Schema Reference

**Table:** `OLIDS_COMMON.PRACTITIONER`

**Name-related columns:**
- `TITLE` - Practitioner's title (e.g., Dr, Mr, Mrs)
- `FIRST_NAME` - Given/first name
- `LAST_NAME` - Family/surname  
- `NAME` - Full name field
- `GMCCODE` - General Medical Council code
- `ID` - Unique practitioner identifier

### Known Data Source Differences

#### EMIS Data

EMIS provides practitioner names as **separate components**:
- `FIRST_NAME` and `LAST_NAME` are populated with discrete values
- `NAME` is constructed by concatenating `FIRST_NAME` and `LAST_NAME`
- All three fields typically contain values

**Example:**
```
FIRST_NAME: John
LAST_NAME: Smith
NAME: John Smith
```

#### TPP Data

TPP provides practitioner names as a **single concatenated field**:
- `NAME` contains the full practitioner name as provided by TPP
- `FIRST_NAME` and `LAST_NAME` are **NULL**
- The platform does **not** attempt to split the `NAME` field into components

**Example:**
```
FIRST_NAME: NULL
LAST_NAME: NULL
NAME: Dr John Smith
```

### Why Names Are Not Split for TPP

The decision not to split TPP's `NAME` field into `FIRST_NAME` and `LAST_NAME` is intentional and based on several technical considerations:

1. **Name complexity:** Many practitioner names contain three or more parts (e.g., "Dr John Michael Smith-Jones"), making it impossible to reliably determine which parts represent the first name versus last name

2. **No consistent pattern:** Names do not follow a standard format that would allow safe algorithmic splitting

3. **Data integrity:** Attempting to split complex names could result in:
   - Incorrect attribution of name parts
   - Loss of titles, middle names, or suffixes
   - Misidentification in systems relying on accurate name components

4. **Schema parity:** The `FIRST_NAME` and `LAST_NAME` columns are not provided in the Discovery Data Service (DDS), so maintaining NULL values brings the OLIDS schema into alignment with DDS standards

### Impact on Users

#### Querying Practitioner Names

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

### Data Quality Checks

Thsi will be monitored as part of the **NULL Column Report by Data Supplier**.

#### Important Context: Historical DQ Checks

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
2. Baseline DQ metrics from December 2025 should be updated to reflect current TPP data volumes
3. Any automated DQ checks should be source-aware (TPP vs EMIS) when validating name fields
4. Future DQ assessments should stratify results by data source

#### Validation Query: Source-Aware NULL Check

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

| DATASET_NAME | PCT_NULL_FIRST_NAME | PCT_NULL_LAST_NAME | PCT_NULL_NAME |
|--------------|---------------------|--------------------|---------------|
| PrimaryCare_TPP | ~100% | ~100% | <1% |
| PrimaryCare_EMIS | <5% | <5% | <1% |

Any significant deviation from these expected patterns should be investigated as a potential data processing issue.

### Best Practices for Developers

1. **Always use the NAME field** as the primary source of practitioner name information in reports and applications

2. **Handle NULL gracefully** when using `FIRST_NAME` and `LAST_NAME` fields - use `COALESCE()` or `CASE` statements

3. **Do not filter on `FIRST_NAME` or `LAST_NAME`** unless you intentionally want to exclude TPP practitioners

4. **Document assumptions** in your queries and reports about name field usage

5. **Consider search functionality** - when implementing practitioner search, ensure the `NAME` field is included in search criteria:
   ```sql
   WHERE NAME ILIKE '%Smith%'
   ```

### Future Considerations

The development team has considered three potential options for addressing this gap:

1. **Do nothing** (current approach) - Maintains data integrity and avoids incorrect name splitting
2. **Remove FIRST_NAME and LAST_NAME columns** - Would bring schema into full parity with DDS
3. **Attempt algorithmic splitting** - High risk of errors; would require complex logic or machine learning approaches

**Current decision:** The platform will continue with option 1 (do nothing) to maintain data quality and integrity. Users should design queries and applications with this understanding.

### Related Documentation

- [OLIDS Schema Dictionary](https://github.com/NHSISL/Datasets/blob/main/OLIDS/Documentation/OLIDS-schema-dictionary.md)
- [OLIDS Entity Relationship Documentation](https://github.com/NHSISL/Datasets/blob/main/OLIDS/Documentation/OLIDS-entity-relationship.md)
- Dataset ID Mapping Reference

### Support

For questions or issues related to practitioner name data, please:
1. Check this documentation first
2. Review the schema dictionary for field definitions
3. Contact the data platform team via your standard support channels

---

**Last Updated:** February 2026  
**Note:** This documentation reflects the current state as of February 2026 and will be updated if the approach to handling TPP name fields changes.
