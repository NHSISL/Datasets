# Release [Release-283] - Release Date: 2026-03-03

> [!NOTE]
> The below is a summary of the changes since the previous release [Release-282](Release-282.md).

- *Environment release date: 2026-02-24*
- *Release Date to consumers: 2026-03-11*
- *Release note published: 2026-03-03*

## Summary
This release delivers important enhancements to the One London Data Platform, including new monitoring views, improved data processing pipelines, and fixes for data quality and performance issues. Users will benefit from more reliable data flows, improved completeness, and easier troubleshooting, while internal teams gain new tools for monitoring and administration.

### New Features
- Added new monitoring views for tracking versioner events and silent failures, supporting better oversight of data processing and suppored data to be re-processed. *[SQL, [PR#3254](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3254), [WI#27568](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27568)]*  
  > ✨ ***Feature:*** Enables internal teams to monitor and troubleshoot data processing more effectively.

- Introduced a stored procedure to identify tables with Sflag and Valueset tags, providing additional reference data for Fabric. *[SQL, [PR#3272](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3272), [WI#26533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26533)]*  
  > ✨ ***Feature:*** Supports cross-checks and improves data transmission reliability for Fabric team.

### Improvements
- Standardized contact information logic across EMIS and TPP layers, ensuring consistent handling of patient and location contacts. *[SQL, [PR#3247](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3247), [WI#27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372), [WI#27620](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27620)]*  
  > 🎯 ***Impact:*** Reduces duplicate IDs and improves data consistency across systems. This fixes [Bug 27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372/)

- Updated system values for medication statements to align with terminology mappings, improving compatibility and mapping accuracy. *[SQL, [PR#3262](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3262), [WI#27110](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27110), [WI#27722](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27722)]*  
  > 🎯 ***Impact:*** Ensures correct mapping for medication authorisation types and supports polypharmacy analysis. Fixing bug [Bug 27110](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27110/)

- Added query performance helper views to the CommonModel database for identifying slow queries. *[SQL, [PR#3248](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3248), [WI#26816](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26816)]*  
  > 🎯 ***Impact:*** Helps optimize database performance and improves responsiveness.

- Updated the Deltalake Loader to dynamically calculate processing dates based on configuration, removing hardcoded values. *[SynapseWorkspace, [PR#3251](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3251), [WI#27618](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27618), [WI#27647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27647)]*  
  > 🎯 ***Impact:*** Prevents failures and improves flexibility in data loading processes.

- Added spark profile configurations to optimize transmitter performance when handling large data shuffles. *[SynapseWorkspace, [PR#3257](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3257), [WI#27704](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27704)]*  
  > 🎯 ***Impact:*** Reduces delivery times and enhances processing efficiency for large datasets.

- Updated the Transmitter Master pipeline so row count comparisons are only performed for OLIDS datasets, streamlining processing. *[SynapseWorkspace, [PR#3270](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3270), [WI#27770](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27770)]*  
  > 🎯 ***Impact:*** Improves pipeline efficiency and avoids unnecessary checks for monitoring and reference datasets.

### Bug Fixes
- Fixed issues where the versioner was not generating registrar records, ensuring data is correctly supplied to the registrar service. *[SQL, [PR#3259](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3259), [WI#27702](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27702)]*  
  > 🐞 ***Fix:*** Restores data flow to registrar service, preventing missing records.

- Made concept ID generation null-safe, preventing orphaned values and improving referential integrity. *[SQL, [PR#3263](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3263), [WI#27370](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27370)]*  
  > 🐞 ***Fix:*** Ensures concept IDs are only generated when valid, improving data quality. 

- Added a tie-breaker and improved partitioning for episode of care sequencing, resolving broken references and orphaned rows. *[SQL, [PR#3261](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3261), [WI#26370](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26370)]*  
  > 🐞 ***Fix:*** Guarantees deterministic output and correct episode grouping.

- Standardized LDSIsDeleted logic and fixed column order bugs to prevent NULL insertions in CDM process scripts. *[SQL, [PR#3242](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3242), [WI#27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372), [WI#27623](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27623)]*  
  > 🐞 ***Fix:*** Prevents data processing errors and improves reliability.

- Updated RecordOwnerOrganisationCode logic to avoid NULL values in practitioner records for TPP, ensuring all records have valid ownership codes. *[SQL, [PR#3249](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3249), [WI#27654](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27654)]*  
  > 🐞 ***Fix:*** Prevents failed inserts and maintains data completeness.

- Populated previously empty columns in referral requests, ensuring [LDSBusinessId_Encounter] and [IsOutgoingReferral] are correctly set. *[SQL, [PR#3244](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3244), [WI#27572](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27572)]*  
  > 🐞 ***Fix:*** Improves completeness and usability of referral request data.

- Corrected and reverted prescribing issue record to a clustered index to resolve errors in test environments. *[SQL, [PR#3240](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3240), [WI#27595](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27595)]*  
  > 🐞 ***Fix:*** Ensures compatibility and prevents failures in data processing.

- Fixed error logging in the Common Model Continuum pipeline so it does not fail if row counts are missing after an error. *[SynapseWorkspace, [PR#3218](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3218), [WI#27306](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27306), [WI#27307](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27307)]*  
  > 🐞 ***Fix:*** Improves troubleshooting and prevents pipeline failures.

### Refactoring
- Refactored pre-deployment scripts, reorganizing files and updating release pipeline artifacts for easier maintenance and deployment. *[SQL, [PR#3243](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3243), [WI#27621](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27621), [WI#27622](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27622)]*  
  > ♻️ ***Refactor:*** Streamlines deployment processes and improves maintainability.

- Removed concurrency limits from the versioner_process_batch pipeline, allowing parallel dataset processing controlled by parent pipelines. *[SynapseWorkspace, [PR#3245](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3245), [WI#27774](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27774)]*  
  > ♻️ ***Refactor:*** Increases throughput and efficiency in data processing workflows.

### Inputs

This change note was automatically produced from:

- 20 Pull Requests
- 27 Work Items
- 93 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:
- [PR 3272](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3272): Add_SPOC_For_Sflag_Valueset
  - User Story [WI 26533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26533): Additional reference data for Fabric
- [PR 3247](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3247): Standardize contact info logic across EMIS/TPP layers.
  - Bug [WI 27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372): Unique test failures - duplicate IDs
  - Task [WI 27620](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27620): Fixes for Contact tables
- [PR 3250](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3250): CDM transform fixes
  - Bug [WI 26393](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26393): Broken references - PATIENT_REGISTERED_PRACTITIONER_IN_ROLE.EPISODE_OF_CARE_ID → EPISODE_OF_CARE.ID
  - User Story [WI 27647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27647): Investigate why rebasing is running slowly
- [PR 3255](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3255): Versioner silent failures
  - User Story [WI 27568](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27568): Versioner silent failures
- [PR 3259](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3259): FIX: versioner no longer generates registrar records 
  - Bug [WI 27702](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27702): FIX: Versioner is not supplying registrar view data to the registrar service
- [PR 3263](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3263): Updated GetConceptBusinessId.sql to be null-safe
  - Bug [WI 27370](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27370): Orphaned values of concept_ids --> ConceptID determination is not NULL-SAFE (NULL input should equal NULL output)
- [PR 3261](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3261): MINOR FIX: episode of care: added tie-breaker to achieve deterministic output...
  - Bug [WI 26370](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26370): Broken references - ENCOUNTER.EPISODE_OF_CARE_ID → EPISODE_OF_CARE.ID
- [PR 3242](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3242): HOTFIX: Standardize LDSIsDeleted & PrimaryCareEMIS_Person Column Order Bug
  - Bug [WI 27372](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27372): Unique test failures - duplicate IDs
  - Task [WI 27623](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27623): Logic fixes in CDM
- [PR 3249](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3249): HOTFIX: Update RecordOwnerOrganisationCode to use IDOrganisationVisibleTo in multiple...
  - Bug [WI 27654](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27654): Fix NULL Org Record Owner on Practitioner (TPP)
- [PR 3262](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3262): Updated SytemValues to 'http://LDS.nhs/EMISandTPP/MedicationStatement/cs'
  - Bug [WI 27110](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27110): CONCEPT_MAP regression for MEDICATION_STATEMENT.authorisation_type_concept_id
  - Task [WI 27722](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27722): Create fix and PR
- [PR 3254](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3254): Versioner silent failures
  - User Story [WI 27568](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27568): Versioner silent failures
- [PR 3243](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3243): Refactor pre-deployment scripts
  - User Story [WI 27621](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27621): Updates to the Release Pipeline
  - Task [WI 27622](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27622): Updates to the Release Pipeline
- [PR 3248](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3248): SQL - CommonModel - Add query performance helper views
  - Bug [WI 26816](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26816): Fields where OLIDS completeness is >1% less populated than DDS completeness
- [PR 3244](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3244): SQL CommonModel - Populate Empty Referral Request Columns
  - Task [WI 27572](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27572): Investigate/Resolve REFERRAL_REQUEST table/column differences
- [PR 3240](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3240): hotfix - correct and revert prescribing issue record to clustered index
  - Bug [WI 27595](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27595): hotfix - revert emis prescribing issue temp table in raw continuum to a clustered index
- [PR 3245](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3245): Remove versioner_process_batch concurrency limit
  - User Story [WI 27774](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27774): remove versioner_process_batch concurrency limit
- [PR 3218](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3218): Updating pipeline: Common Model Continuum
  - Bug [WI 27306](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27306): 'Common Model Continuum' pipeline failed
  - Task [WI 27307](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27307): Troubleshoot
- [PR 3251](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3251): Deltalake Loader - calculation of Lakehouse Date Processed value to be dynamic from configuration
  - Bug [WI 27618](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27618): Release 279 Regression Issues - CETAS Group Orchestrator and Table Orchestrator Pipeline failures, also not calling transmitter pipelines
  - User Story [WI 27647](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27647): Investigate why rebasing is running slowly
- [PR 3257](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3257): Add spark profile configurations
  - User Story [WI 27704](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27704): Add spark profiles to code repo
- [PR 3270](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3270): Updating pipeline: Transmitter Master
  - User Story [WI 27770](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27770): Update transmitter : Compare row counts for OLIDS only - not MONITORING, REFERENCE



