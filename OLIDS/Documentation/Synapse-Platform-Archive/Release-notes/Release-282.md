# Release [Release-282] - Release Date: 2026-02-19

> [!NOTE]
> The below is a summary of the changes since the previous release [Release-277](Release-277.md).

- *Environment release date: 2026-02-11*
- *Release Date to consumers: 2026-02-19*
- *Release note published: 2026-02-19*

## Summary

This release delivers a wide range of improvements and fixes across the One London Data Platform, focusing on data quality, processing reliability, and performance. Key highlights include major enhancements to the Episode of Care data pipeline, improved workload management, more consistent data handling, and several bug fixes that address data mismatches and operational issues. These updates strengthen data integrity, streamline processing, and improve the overall user experience for platform stakeholders.

### Schema changes

- please see [Release 282 schema changes](/OLIDS/Documentation/Release-notes/Release-282-schema-changes.md)

### New Features

- Added utility functions to support quick row count retrieval and table switching, making data management more efficient. *[SQL, [PR#3229](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3229), [WI#25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246)]*  
  > ✨ ***Feature:*** Enables faster processing and reduced processing waits to return process statistics.

- Introduced a new workload classifier for high-priority processes in PrimaryCareEMIS, ensuring important jobs are processed first. *[SQL, [PR#3191](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3191), [WI#27309](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27309)]*  
  > ✨ ***Feature:*** larger data processing tasks (i.e. observation related objects) are now prioritized, and premitted to consume more resources in parallel, reducing wait times for essential operations.

### Improvements

- Updated workload management for data transformations, allowing each process to use the most suitable resources for its size. *[SQL, [PR#3205](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3205), [WI#27100](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27100), [WI#27228](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27228)]*  
  > 🎯 ***Impact:*** Increases overall processing speed and system throughput, reducing delays for smaller tasks.

- Improved reliability of row count retrieval in versioning and data copying processes. *[SQL, [PR#3198](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3198), [WI#27040](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27040)]*  
  > 🎯 ***Impact:*** Reduces errors during data versioning and ensures more accurate reporting.

- Automated the granting of CONNECT permissions for SQL Server, streamlining developer access. *[SQL, [PR#3225](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3225), [WI#27561](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27561)]*  
  > 🎯 ***Impact:*** Simplifies and secures database access for development and troubleshooting.

- Improved the reliability and efficiency of CETAS and deltalake data export and import processes, reducing unnecessary system activity and errors. *[SynapseWorkspace, [PR#3201](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3201), [WI#27386](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27386)]*  
  > 🎯 ***Impact:*** Streamlines data movement and reduces processing overhead.

- Added a preflight preprocessor dispatch test to ensure data processing only runs when conditions are right, avoiding unnecessary or conflicting jobs. *[SynapseWorkspace, [PR#3209](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3209), [WI#27468](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27468)]*  
  > 🎯 ***Impact:*** Prevents resource conflicts and improves scheduling of data processing.

- Enabled transmitter activities and improved resource allocation for referential integrity tests. *[SynapseWorkspace, [PR#3197](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3197), [WI#27376](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27376)]*  
  > 🎯 ***Impact:*** Allows system tests to run more efficiently.

- Optimized the CETAS and deltalake loader for better performance and reduced chatter/concurrency issues. *[SynapseWorkspace, [PR#3189](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3189), [WI#27355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27355), [WI#27356](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27356), [WI#27357](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27357), [WI#27358](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27358), [WI#27359](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27359)]*  
  > 🎯 ***Impact:*** Reduces delays and failures during large data operations.

### Bug Fixes

- Refactored Episode of Care data transformation and export logic, aligning schema and field definitions for better consistency and accuracy. *[SQL, [PR#3229](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3229), [WI#25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246), [WI#25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971), [WI#26801](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26801), [WI#27109](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27109), [WI#27431](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27431)]*  
  > 🐞 ***Fix:*** Improves patient registration data quality and resolves discrepancies between different data sources.

- Fixed several issues in the Episode of Care data, including missing or incorrect registration types, null values, and date mismatches. *[SQL, [PR#3229](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3229), [SynapseWorkspace, [PR#3230](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3230)], [WI#25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246), [WI#25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971), [WI#26801](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26801), [WI#27109](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27109), [WI#27431](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27431)]*  
  > 🐞 ***Fix:*** Improves data accuracy for patient registrations and practice counts.

- Corrected numeric value handling in observation results to prevent rounding and truncation. *[SQL, [PR#3226](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3226), [WI#26647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26647)]*  
  > 🐞 ***Fix:*** Ensures that clinical data is precise and matches source systems.

- Corrected numeric value handling by standardizing data types for numeric columns. *[SQL, [PR#3226](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3226), [WI#26647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26647)]*  
  > 🐞 ***Fix:*** Ensures more precise and consistent numeric data, improving data quality for analysis.

- Improved the transformation view for patient address data, ensuring address types and dates are set correctly. *[SQL, [PR#3227](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3227), [WI#27501](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27501)]*  
  > 🐞 ***Fix:*** Enhances the accuracy of patient address information in the system.

- Fixed CETAS exporter to correctly handle date and time values, ensuring the latest data is always included. *[SQL, [PR#3217](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3217), [WI#27476](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27476)]*  
  > 🐞 ***Fix:*** Prevents missing recent data in exports due to rounding errors.

- Resolved issues in the external table creator that caused failures for certain configurations. *[SQL, [PR#3195](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3195), [WI#27368](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27368)]*  
  > 🐞 ***Fix:*** Ensures all data exports run smoothly, regardless of configuration.

- Addressed a bug where the deltalake loader failed when loading from multiple source paths. *[SynapseWorkspace, [PR#3203](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3203), [WI#27388](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27388)]*  
  > 🐞 ***Fix:*** Allows successful import of data from multiple locations.

- Fixed issues where the deltalake optimizer would fail when trying to optimize archive tables. *[SynapseWorkspace, [PR#3224](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3224), [WI#27533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27533)]*  
  > 🐞 ***Fix:*** Prevents unnecessary failures and improves system reliability.

- Fixed an issue where the CodeSystem table was not being populated correctly. *[SQL, [PR#3211](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3211), [WI#27414](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27414)]*  
  > 🐞 ***Fix:*** Ensures all relevant code systems are captured for terminology processing.

- Fixed incorrect table references in the LDOO events process. *[SQL, [PR#3204](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3204), [WI#26719](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26719)]*  
  > 🐞 ***Fix:*** Restores correct event handling for LDOO notebooks.

- Improved handling of practitioner data for TPP, ensuring organization details are included and naming is consistent. *[SQL, [PR#3231](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3231), [WI#27573](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27573)]*  
  > 🐞 ***Fix:*** Provides more complete and accurate practitioner records.

### Refactoring

- Standardized column naming, casing, and spelling across multiple tables and views for greater consistency. *[SQL, [PR#3223](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3223), [WI#27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372)]*  
  > ♻️ ***Refactor:*** Makes the codebase easier to maintain and reduces the risk of errors from inconsistent naming.

- Updated internal logic for handling SQL table operations to use Unicode strings. *[SQL, [PR#3234](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3234)]*  
  > ♻️ ***Refactor:*** Improves compatibility and prepares the system for broader data support.

### Inputs

This change note was automatically produced from:

- 23 Pull Requests
- 34 Work Items
- 136 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:

- [PR 3234](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3234): Update sp_executesql DROP TABLE calls to use Unicode strings.
  - No Work Items linked to this PR.
- [PR 3223](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3223): Bug Fixes Working Towards Missing CDM Identifiers
  - Bug [WI 27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372): Unique test failures - duplicate IDs
- [PR 3229](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3229): FIX: Episode of Care Transforms
  - Bug [WI 25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246): (episode_of_care) OLIDS data content: Practice counts variance
  - Bug [WI 25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971): Registration Count Mismatches (episode_of_care)
  - Bug [WI 26801](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26801): EPISODE_OF_CARE table issue
  - Bug [WI 27109](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27109): TPP Registration Type concepts are 100% null
  - Bug [WI 27431](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27431): NULL EPISODE_TYPE_SOURCE_CONCEPT_ID - TPP specific
- [PR 3217](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3217): FIX: CETAS exporter watermark date rounding error
  - Bug [WI 27476](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27476): BUG: CETAS exporter rounds datetimes before exporting - this stops it including latest data
- [PR 3232](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3232): update feature branch "bugfix/27109..." to address conflicts
  - No Work Items linked to this PR.
- [PR 3198](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3198): REFINE: Improve reliability of vesioner staged row count retrieval
  - Bug [WI 27040](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27040): versioner failure: runid: `7637ef37-6e5a-4d25-8ef6-18a444eeaa65`
- [PR 3231](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3231): Fix TPP Practitioner data.
  - Task [WI 27573](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27573): Update Practitioner to include Organisation Code where it can be derived
- [PR 3205](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3205): The [Transform_masked].[Materialise] should have a '@WLM_Context' parameter s...
  - Bug [WI 27100](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27100): TPP Group 16 Pre-Processor Failures - SRAppointment.csv
  - User Story [WI 27228](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27228): Parameterise [Transform_masked].[Materialise] with WLM_Context
- [PR 3225](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3225): Setup a predeployment script to run against master db
  - Task [WI 27561](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27561): Fix Connect Perms to SqlServer
- [PR 3226](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3226): Fix numeric values and aligns data types
  - Bug [WI 26647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26647): Observation Result values truncated/rounded
- [PR 3228](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3228): TempDB Full on SRCode
  - Bug [WI 27306](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27306): 'Common Model Continuum' pipeline failed
  - Task [WI 27307](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27307): Troubleshoot
- [PR 3227](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3227): SQL - Updated Admin_Patient transformation view udpates
  - Task [WI 27501](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27501): Check PATIENT_ADDRESS diffs
- [PR 3211](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3211): Updating procedure: Terminology.ProcessCodeSystem
  - Bug [WI 27414](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27414): CommonModel Terminology.CodeSystem has only one entry
- [PR 3204](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3204): SQL - LDOO Minor Bug - Fix Correct table name from [NDOO_Events] to [LDOO_Events]
  - Task [WI 26719](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26719): Test in dev
- [PR 3195](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3195): FIX: external table creator - error in computed destination_full_path
  - Bug [WI 27368](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27368): external table creator fails for configurations running in non-incremental mode
- [PR 3191](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3191): PrimaryCareEMIS - new WLC wcLabel_high_priority_process that use 'high' importance...
  - User Story [WI 27309](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27309): Fix Versioner performance degradation
- [PR 3230](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3230): FIX: Episode of Care transform
  - Bug [WI 25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246): (episode_of_care) OLIDS data content: Practice counts variance
  - Bug [WI 25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971): Registration Count Mismatches (episode_of_care)
  - Bug [WI 26801](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26801): EPISODE_OF_CARE table issue
  - Bug [WI 27109](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27109): TPP Registration Type concepts are 100% null
- [PR 3209](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3209): Add Preprocessor Master dispatch test (Synapse)
  - User Story [WI 27468](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27468): Pre-processor dispatch should test for existence of items in queue
- [PR 3201](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3201): Updating pipeline: CETAS_table_orchestrator to reduce chatter
  - User Story [WI 27386](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27386): High chatter in CETAS service
- [PR 3203](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3203): Fix: deltalake loader failure: conflicting directory structures detected (unable to load from multiple source paths)
  - Bug [WI 27388](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27388): deltalake importer failure: Conflicting directory structures detected. Suspicious paths
- [PR 3224](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3224): FIX: Ensure deltalake optimiser skips auto-archived deltalakes
  - Bug [WI 27533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27533): Deltalake optimiser is failing when trying to optimise archives
- [PR 3189](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3189): CETAS and deltalake optimisations
  - Bug [WI 27355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27355): pyspark shared function error: `execute_azure_sql_procedure_struct_type` fails when value passed is bigint/long type
  - Bug [WI 27356](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27356): deltalake bug: early exit results in 'failed pipeline
  - Bug [WI 27357](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27357): deltalake CDM integration bug: no queue updated
  - User Story [WI 27358](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27358): CETAS exporter struggles with concurrency (chatty IR issues)
  - User Story [WI 27359](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27359): Deltalake loader: Optimise spark read operation for merger or write to deltalake
- [PR 3197](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3197): Enable Transmitter
  - Task [WI 27376](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27376): Enable Transmitter Activities
