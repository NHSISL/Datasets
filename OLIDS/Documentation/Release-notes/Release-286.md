# Release [Release-286] - Release Date: 2026-03-12

> [!NOTE]
> The below is a summary of the changes since the previous release [Release-283](Release-283.md).

## Summary
This release delivers several important bug fixes and enhancements to the One London Data Platform, improving data quality, system reliability, and performance. Key highlights include improved performance for Versioner processing, resolution of data duplication and null value issues, and enhanced orchestration stability. New data objects and procedures have been added, and referential integrity checks have been refined for greater accuracy.

### New Features
- Added new data objects and procedures to support SRRecordStatus from PrimaryCareTPP in the Common Data Model. *[SQL, [PR#3299](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3299), [WI#27713](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27713)]*  
  > ✨ ***Feature:*** This enables more complete and accurate tracking of TPP episode of care record status.

- Introduced a new pipeline for person subscriber count metadata for testing purposes. *[SynapseWorkspace, [PR#3312](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3312)]*  
  > ✨ ***Feature:*** Supports improved data analysis and validation workflows.

### Improvements
- Enhanced Versioner performance by optimizing configuration management and SQL templates, including better handling of default values and indexes. *[SQL, [PR#3287](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3287), [WI#27309](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27309)]*  
  > 🎯 ***Impact:*** Significantly reduces processing times and improves overall data pipeline efficiency.

- Updated the Transmitter Master pipeline to run referential integrity checks only for OLIDS datasets, excluding monitoring and reference datasets. *[SynapseWorkspace, [PR#3305](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3305), [WI#27878](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27878)]*  
  > 🎯 ***Impact:*** Streamlines validation processes and reduces unnecessary checks.

### Bug Fixes
- Fixed an issue where the Registrar Patient Response Batch Process pipeline failed due to incorrect throttling logic, ensuring all eligible data is processed. *[SQL, [PR#3296](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3296), [WI#27855](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27855), [WI#27856](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27856)]*  
  > 🐞 ***Fix:*** Prevents data from being missed during batch processing, improving reliability.

- Corrected the default value for the IsActive field in the PrimaryCareTPP_SRPersonAtRisk_Flag view to avoid null values and ensure accurate status reporting. *[SQL, [PR#3302](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3302), [WI#27874](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27874)]*  
  > 🐞 ***Fix:*** Ensures data integrity by preventing null values in critical fields.

- Standardised the Status value in batch progress summaries to ensure consistency. *[SQL, [PR#3300](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3300), [WI#27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138)]*  
  > 🐞 ***Fix:*** Improves reporting accuracy for monitoring batch processes.

- Resolved a data duplication issue in Allergy Intolerance by excluding observations already included, preventing over-counting. *[SQL, [PR#3301](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3301), [WI#27031](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27031)]*  
  > 🐞 ***Fix:*** Delivers more accurate allergy and intolerance data.

- Fixed regression test errors in the episode of care notebook definition, including syntax corrections and improved column handling. *[SynapseWorkspace, [PR#3274](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3274), [WI#27779](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27779)]*  
  > 🐞 ***Fix:*** Ensures episode of care data loads correctly and passes validation tests.

- Addressed an error in the CETAS table orchestrator to set a default watermark value in non-incremental mode, allowing "always rebase" operations to succeed. *[SynapseWorkspace, [PR#3273](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3273), [WI#27779](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27779)]*  
  > 🐞 ***Fix:*** Prevents failures during Delta Lakehouse loading in certain pipeline modes.

- Limited pre-processor dispatching to a single run at a time to avoid overlapping pipeline executions. *[SynapseWorkspace, [PR#3282](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3282), [WI#27803](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27803)]*  
  > 🐞 ***Fix:*** Improves stability by preventing duplicate processing and resource contention.

### Refactoring
- Improved internal structure of configuration management, SQL templates, and pipeline definitions for better maintainability and clarity. *[SQL, [PR#3287](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3287)]*  
  > ♻️ ***Refactor:*** Makes future enhancements and troubleshooting easier by streamlining code and templates.

### Inputs

This change note was automatically produced from:

- 11 Pull Requests
- 11 Work Items
- 82 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:
- [PR 3287](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3287): Fix Versioner Performance Issues
  - User Story [WI 27309](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27309): Fix Versioner performance degradation
- [PR 3299](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3299): Add [PrimaryCareTPP].[SRRecordStatus] objects and procedures to CDM
  - Bug [WI 27713](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27713): TPP Registration Status concepts are 100% null
- [PR 3302](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3302): Hot Fix: Set IsActive = 1 by default in PrimaryCareTPP_SRPersonAtRisk_Flag view
  - Bug [WI 27874](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27874): PrimaryCareTPP_Flag_Process : Cannot insert the value NULL into column 'IsActive'
- [PR 3300](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3300): Standardise Status value
  - Bug [WI 27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138): Batch Progress Summary view not showing recent activity
- [PR 3301](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3301): OLIDS Code Multiple vs DDS single value in Allergy Intolerance
  - Bug [WI 27031](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27031): OLIDS Code Multiple vs DDS single value in Allergy Intolerance
- [PR 3296](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3296): Moved 'NOT EXIST' logic into BatchSizes CTE to fix throttling logic bug
  - Bug [WI 27855](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27855): Pipeline Failure - Registrar Patient Response Batch Process
  - Task [WI 27856](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27856): Fix Procedure - [Patient].[Get_Unprocessed_Response_Data]
- [PR 3312](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3312): Person_subscriber_count_metadata to dev branch for testing
  - No Work Items linked to this PR.
- [PR 3273](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3273): hotfix: CETAS default watermark for non-incremental mode
  - Bug [WI 27779](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27779): Regression test failure - deltalake load error
- [PR 3274](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3274): hotfix: patched - olids episode of care notebook definition
  - Bug [WI 27779](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27779): Regression test failure - deltalake load error
- [PR 3305](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3305): Updating pipeline: Transmitter Master : Enable RI only for Dataset = OLIDS
  - User Story [WI 27878](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27878): Run Referential Integrity test only for OLIDS - not for MONITORING, Reference dataset
- [PR 3282](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3282): set preprocessor dispatch concurrent of 1
  - Bug [WI 27803](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27803): two pre-processor polling pipelines ran simultaneously

