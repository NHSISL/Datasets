# [Release-222] - 2025-09-12

> [!NOTE]
> The below is a summary of the changes from [release 222](Release-222.md) (previous pre-production release)

### Summary

This release introduces several new features and improvements across the One London Data Platform, including enhanced data validation, expanded transmission capabilities, and improved configuration management. It also includes bug fixes for data handling and validation, as well as updates to tagging and comparison logic to ensure data consistency and accuracy. All changes are designed to improve data flow, reliability, and usability for end users.

### New Features

- Added support for a new transmission mode `inserts_upserts` in the stored procedure for retrieving high watermark dates, enabling more flexible data transmission with soft-deletes. [SQL, [PR 2572](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2572)]  
    > ✨ **Feature**: Enables transmission of data with upserts and soft-deletes, improving data integration options.

- Introduced automated count validation to compare row counts across Common Model views, Lakehouse CDM/OLIDS views, and Snowflake tables, producing consolidated comparison reports. [SynapseWorkspace, [PR 2566](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2566), [WI 24618](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24618)]  
    > ✨ **Feature**: Ensures data consistency and helps quickly identify discrepancies across different systems.

### Improvements

- FileCombiner pipelines now read configuration variables from the metadata database, allowing more dynamic and maintainable configuration management. [SynapseWorkspace, [PR 2512](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2512), [WI 24608](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24608)]  
    > 🎯 **Impact**: Simplifies configuration updates and improves pipeline reliability.

- Added 1,726 generated objects for TPP v155, enabling the latest TPP files to be loaded into the platform. [SQL, [PR 2565](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2565), [WI 24616](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24616)]  
    > 🎯 **Impact**: Supports the most recent TPP data format for improved data ingestion.

- Always return `DataSetId` and `DataSetSpecificationId` in the `GetLandingConfig` procedure, even for LDSManifest.txt, ensuring Registrar can pass through required identifiers. [SQL, [PR 2567](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2567), [WI 24527](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24527)]  
    > 🎯 **Impact**: Improves downstream data handling and integration reliability.

- Reverse mapping logic when generating valueset tags to correctly match source codes to target codes, ensuring tags are created and populated as expected. [SynapseWorkspace, [PR 2570](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2570)]  
    > 🎯 **Impact**: Ensures accurate tagging and classification of records.

### Bug Fixes

- Fixed FileWarden TPP issue by altering vDPAList to return `[PracticeODSCode]` values instead of `[OrganisationCodeSystemKey]`, preventing all records from being incorrectly jailed. Disabled unused OrganisationLoader table. [SQL, [PR 2575](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2575), [WI 24655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24655)]  
    > 🐞 **Fix**: Corrects data handling for TPP, allowing valid records to process as expected.

- Added further datetime formats to fileValidator, allowing dates in additional formats (including those found in TPP data) to be validated successfully. [SynapseWorkspace, [PR 2574](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2574), [WI 24655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24655), [WI 24691](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24691)]  
    > 🐞 **Fix**: Prevents validation failures for dates in new formats, improving data acceptance.

- Fixed transmitter bug for new transmission mode, ensuring schema detection works even when no files match the expected name pattern. [SynapseWorkspace, [PR 2571](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2571)]  
    > 🐞 **Fix**: Resolves issues with data transmission and schema detection for upsert mode.

### Refactoring

- Added a pull request template to the SynapseWorkspace repository to standardize future contributions. [SynapseWorkspace, [PR 2529](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2529)]

### Inputs

This change note was automatically produced from:

- 10 Pull Requests
- 7 Work Items
- 54 Commits