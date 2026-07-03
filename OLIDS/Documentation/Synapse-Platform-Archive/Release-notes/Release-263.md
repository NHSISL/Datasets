# Release 263

- [Release 263](#release-263)
  - [Summary](#summary)
  - [✨ New Features](#%E2%9C%A8-new-features)
  - [🎯 Improvements](#%F0%9F%8E%AF-improvements)
  - [🐞 Bug Fixes](#%F0%9F%90%9E-bug-fixes)
  - [♻️ Refactoring](#%E2%99%BB%EF%B8%8F-refactoring)
  - [Inputs](#inputs)
  - [Full Details](#full-details)

> The below is a summary of the changes since the previous release [Release-257](Release-257.md).

## Summary
This release delivers major enhancements to data processing pipelines, improved reporting and monitoring capabilities, and a range of bug fixes that increase reliability and accuracy. Highlights include optimised preprocessor and versioner workflows, new features for clinical coding and file transmission, and refined data integrity across multiple tables. The update also introduces improved configuration management and more efficient resource usage, ensuring smoother operations and better support for users and stakeholders.

## ✨ New Features
- Added new database views and procedures to support clinical code imports and Delta Lakehouse pipelines, ensuring all required fields are present for seamless integration. *[SQL, [PR#2973](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2973), [WI#26479](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26479), [WI#26517](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26517)]*  
  > ✨ ***Feature:*** Enables more consistent and reliable clinical code ingestion for future data processing.

- Introduced a utility pipeline and supporting views to transmit existing outbox files on demand. *[SQL, [PR#2972](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2972), [WI#24733](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24733)]*  
  > ✨ ***Feature:*** Allows users to send previously generated files, improving flexibility in data transmission.

- Developed new batch processing and transmission pipelines for NDOO files, including support for file masking and merging. *[SQL, [PR#2850](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2850), [WI#25973](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25973)]*  
  > ✨ ***Feature:*** Streamlines NDOO file handling, making data preparation and delivery more efficient.

- Created new monitoring views and reporting pipelines for ICBs, providing clearer progress summaries and release details. *[SQL, [PR#2952](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2952), [WI#25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930)]*  
  > ✨ ***Feature:*** Enhances transparency and oversight for stakeholders through improved reporting.

## 🎯 Improvements
- Optimised the preprocessor-to-versioner workflow by removing redundant steps and streamlining data handling. *[SQL, [PR#2821](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2821), [WI#25860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25860), [WI#26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089)]*  
  > 🎯 ***Impact:*** Reduces processing time and resource usage, resulting in faster and more reliable data updates.

- Updated Spark configuration to allow dynamic assignment for Delta Lakehouse pipelines, ensuring optimal resource allocation. *[SQL, [PR#2970](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2970), [WI#26279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26279)]*  
  > 🎯 ***Impact:*** Improves performance and cost efficiency by matching compute resources to workload needs.

- Changed resource table distribution from replicated to hash-based, reducing unnecessary overhead. *[SQL, [PR#2962](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2962), [WI#26599](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26599)]*  
  > 🎯 ***Impact:*** Saves storage and speeds up queries for resource tracking.

- Removed unnecessary DISTINCT clauses from RawStaged views, improving query performance. *[SQL, [PR#2928](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2928), [WI#26417](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26417), [WI#26418](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26418)]*  
  > 🎯 ***Impact:*** Makes data retrieval faster and more efficient.

- Enhanced monitoring pipelines to transmit summary files to Snowflake, supporting better external reporting. *[SynapseWorkspace, [PR#2981](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2981), [WI#26483](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26483)]*  
  > 🎯 ***Impact:*** Facilitates sharing of key monitoring data with external partners.

- Updated OLIDS_MASKED_PERSON view to use business key as the canonical ID and added a composite ID column. *[SynapseWorkspace, [PR#2945](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2945), [WI#25311](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25311), [WI#26367](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26367), [WI#26401](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26401), [WI#26402](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26402)]*  
  > 🎯 ***Impact:*** Strengthens data integrity and referential consistency across linked tables.

## 🐞 Bug Fixes
- Corrected function calls and table references in versioner and batch size procedures to ensure accurate processing. *[SQL, [PR#3001](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3001), [WI#26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089), [WI#26648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26648)]*  
  > 🐞 ***Fix:*** Prevents errors during file processing and batch size calculations.

- Fixed Spark configuration procedure to correctly cast values, preventing failures in Azure Data Factory. *[SQL, [PR#2979](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2979), [WI#26451](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26451), [WI#26452](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26452)]*  
  > 🐞 ***Fix:*** Ensures reliable Spark pool configuration and pipeline execution.

- Set sensitivity status on EMIS Person stub records when appropriate, improving privacy handling. *[SQL, [PR#2968](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2968), [WI#26544](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26544)]*  
  > 🐞 ***Fix:*** Accurately flags sensitive records to protect patient privacy.

- Fixed references to deprecated tables and removed obsolete views, correcting row counts and episode IDs. *[SQL, [PR#2959](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2959), [WI#25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246), [WI#25657](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25657), [WI#25766](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25766)]*  
  > 🐞 ***Fix:*** Improves data accuracy for patient and episode tracking.

- Fixed typos in CopyInto procedures to ensure priority process options are applied correctly. *[SQL, [PR#2966](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2966), [WI#26536](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26536)]*  
  > 🐞 ***Fix:*** Optimises data loading for priority tables.

- Corrected Spark pool references in unit tests and monitoring notebooks for compatibility across environments. *[SynapseWorkspace, [PR#3005](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3005), [WI#26654](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26654); [PR#2986](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2986), [WI#26600](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26600)]*  
  > 🐞 ***Fix:*** Ensures tests and monitoring run smoothly in all environments.

- Fixed date parsing errors in Patient_Contact tables by trimming and standardising date formats. *[SynapseWorkspace, [PR#2964](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2964), [WI#26598](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26598)]*  
  > 🐞 ***Fix:*** Prevents failures in data loading due to inconsistent date formats.

- Fixed count operations in Delta Lake importer to handle large record sets without errors. *[SynapseWorkspace, [PR#2961](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2961), [WI#26518](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26518)]*  
  > 🐞 ***Fix:*** Enables processing of large datasets without interruption.

- Fixed pipeline parameter passing and configuration in versioner workflows, resolving failures in scaling and resuming pools. *[SynapseWorkspace, [PR#3002](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3002), [WI#26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089), [WI#26648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26648)]*  
  > 🐞 ***Fix:*** Ensures correct resource scaling and pipeline execution.

- Undeleted NDOO pipelines and notebooks to restore processing capabilities. *[SynapseWorkspace, [PR#2998](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2998), [WI#26638](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26638)]*  
  > 🐞 ***Fix:*** Restores full NDOO functionality after accidental deletion.

- Detached redundant triggers from Registrar pipelines to prevent failures when no data is present. *[SynapseWorkspace, [PR#2950](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2950), [WI#26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232)]*  
  > 🐞 ***Fix:*** Reduces errors and improves internal pipeline reliability.

- Fixed upper-case handling for LDS_Record_ID in patient_person notebooks, ensuring consistent joins and data referencing. *[SynapseWorkspace, [PR#2983](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2983), [WI#26590](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26590)]*  
  > 🐞 ***Fix:*** Resolves data linkage issues for patient and person records.

## ♻️ Refactoring
- Refactored internal procedures and utility functions to improve maintainability and consistency, including updates to queue logic, logging, and configuration management. *[SQL, [PR#2821](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2821), [WI#25860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25860), [WI#26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089)]*  
  > ♻️ ***Refactor:*** Makes codebase easier to manage and reduces risk of future errors.

- Rebased feature branches and merged updates from master to ensure all enhancements and fixes are included in the latest release. *[SynapseWorkspace, [PR#2985](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2985)]*  
  > ♻️ ***Refactor:*** Keeps development branches up to date and avoids conflicts.

---

*Release Date: 2025-12-04*  
*Release Range: Release-257 to Release-262*

### Inputs

This change note was automatically produced from:

- 30 Pull Requests
- 57 Work Items
- 534 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:
- [PR 3001](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3001): versioner fixes from test run
  - User Story [WI 26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089): Versioner amend
  - Task [WI 26648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26648): add fixes from test run
- [PR 2821](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2821): Optimise Preprocessor-to-versioner process
  - User Story [WI 25860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25860): Versioner - Remove all queueing logic
  - User Story [WI 26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089): Versioner amend
- [PR 2952](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2952): Progress report for ICBs
  - User Story [WI 25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930): Progress report for ICBs
- [PR 2962](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2962): Change terminology Resource  table to use hash distribution based on resourcetype, rather than replication
  - Bug [WI 26599](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26599): Change TerminologyResource distribution
- [PR 2970](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2970): Adds DeltaLakehouseWriter to Spark Config in UpdateEnvironmentValues.sql
  - User Story [WI 26279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26279): Enable dynamic Spark configuration for Delta Lakehouse pipelines
- [PR 2928](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2928): Remove DISTINCT from SQL views in RawStaged schema
  - Bug [WI 26417](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26417): All Views in RawStaged use DISTINCT when they can't contain duplicates
  - Task [WI 26418](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26418): Remove DISTINCT from RawStaged Views
- [PR 2968](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2968): EMIS Person Stubs include the ERROR_SUCCESS_CODE for sensitivity if SpineSensitive is set to true
  - Bug [WI 26544](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26544): Stubs should include sensitivity status where available
- [PR 2850](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2850): SQL - NDOO Release
  - User Story [WI 25973](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25973): NDOO - File Generation Development
- [PR 2972](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2972): Views to support new transmitter outbox file transmission utility pipeline
  - Task [WI 24733](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24733): Create pipeline to transmit already generated outbox files
- [PR 2973](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2973): New Clinical Code Views for Delta Import
  - Task [WI 26479](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26479): Add Config to DeltaLakehouse_Table
  - Task [WI 26517](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26517): Create Views for Delta Import
- [PR 2979](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2979): fixed issue with '1' not being cast as BIT causing ADF to fail
  - Bug [WI 26451](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26451): Spark configuration procedure not casting int as bit
  - Task [WI 26452](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26452): Task placeholder
- [PR 2966](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2966): Fixing typos in CopyInto procedures.
  - Bug [WI 26536](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26536): Versioner Priority Process
- [PR 2959](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2959): Fixed references to deprecated EpisodeOfCareBase and removed PatientHistory-based EpisodeOfCare views
  - Bug [WI 25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246): OLIDS data content: Practice counts variance
  - Bug [WI 25657](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25657): "episode_of_care_id" null records in ENCOUNTER table
  - Bug [WI 25766](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25766): Missing episode_of_care end dates
- [PR 3005](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3005): correct spark pool reference in ndoo-unit-tests
  - Bug [WI 26654](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26654): release 261 unable to deploy to test
- [PR 3002](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3002): versioner fixes from test run (synapse)
  - User Story [WI 26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089): Versioner amend
  - Task [WI 26648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26648): add fixes from test run
- [PR 2998](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2998): Undeleting NDOO
  - Task [WI 26638](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26638): Undelete NDOO
- [PR 2820](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2820): Optimise Preprocessor-to-Versioner process
  - User Story [WI 25860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25860): Versioner - Remove all queueing logic
  - User Story [WI 26089](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26089): Versioner amend
- [PR 2986](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2986): Updating Spark pool for notebook: monitoring  : changed from SparkSmall to DeltaLakeS01
  - Bug [WI 26600](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26600): Updating Spark pool - SparkSmall  doesn't exits for notebook: monitoring
- [PR 2964](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2964): Fix for Start_Date_End_Date_Parse_Error for Patient_Contact Table (Masked and PCD)
  - Bug [WI 26598](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26598): Start_Date_End_Date_Parse_Error for Patient_Contact Table (Masked and PCD)
- [PR 2961](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2961): Fix count_big operation on record count within checkpoint
  - Bug [WI 26518](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26518): deltalake importer failed on count
- [PR 2985](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2985): rebase master into preprocessor-optimise branch
  - No Work Items linked to this PR.
- [PR 2949](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2949): Progress report for ICBs
  - User Story [WI 25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930): Progress report for ICBs
- [PR 2981](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2981): Transmit monitoring files to Snowflake
  - Task [WI 26483](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26483): Transmit new parquet files to Snowflake
- [PR 2983](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2983): Fix OLIDS Views Upper Case: LDS_Record_ID in patient_person notebook
  - Bug [WI 26590](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26590): ALLOCATION join to PERSON via PERSON_PATIENT fails due to missing NWL (QRV) records in PATIENT_PERSON.
- [PR 2915](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2915): Synapse - NDOO Release
  - User Story [WI 25973](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25973): NDOO - File Generation Development
  - User Story [WI 25974](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25974): NDOO - File Transmission Development
  - Task [WI 25996](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25996): Create NDOO Processing Pipeline - Notebook Pipeline
- [PR 2971](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2971): Transmitter utility pipeline to transmit existing outbox files
  - Task [WI 24733](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24733): Create pipeline to transmit already generated outbox files
- [PR 2977](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2977): NDOO to snowflake monitoring himani branch
  - No Work Items linked to this PR.
- [PR 2945](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2945): Update OLIDS_MASKED_PERSON view: Set ID = LDSBusinessId and add COMPOSITE_ID column
  - Bug [WI 25311](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25311): REFERENTIAL INTEGRITY: test to link between specific OLIDS tables so there are no orphaned records
  - Bug [WI 26367](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26367): Broken references - ENCOUNTER.PERSON_ID → PERSON.ID
  - Bug [WI 26401](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26401): Broken references - PATIENT_CONTACT.PERSON_ID → PERSON.ID
  - Bug [WI 26402](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26402): Broken references - PATIENT_CONTACT.PATIENT_ID → PATIENT.ID
- [PR 2950](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2950): Detached triggers from child Registrar pipelines
  - Bug [WI 26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232): Registrar pipelines fail with no data
- [PR 2898](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2898): Pull changes from master to branch
  - User Story [WI 25193](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25193): Patient, Person and Patient Person tables
  - Bug [WI 25326](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25326): Disappearance of "person_id" column from LDS_ENGINE_SERVICE_TEST.OLIDS_PCD.PATIENT_ADDRESS
  - User Story [WI 25787](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25787): Automate enrichment of new Extract Groups with data from Configuration database
  - Task [WI 25829](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25829): Work on new approach
  - Bug [WI 25830](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25830): Date values in non date type fields
  - Task [WI 25846](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25846): Create Synapse Solution to Enrich Extract Group fields
  - Task [WI 25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848): Allocator partitioning changes to improve joins/filtering
  - Task [WI 25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849): Parameterise transmitter outbox writer Spark pool config
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix
  - Bug [WI 26115](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26115): 'Common Model Continuum' pipeline failed
  - Bug [WI 26116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26116): FileCombiner has failed
  - Bug [WI 26200](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26200): Preprocessor associator staging table error
  - Task [WI 26201](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26201): Task placeholder
  - Bug [WI 26225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26225): preprocessor failed: 1ccfbf2e-c2fd-477b-a431-42819362dc8d
  - Bug [WI 26231](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26231): s-flag generation failed
  - Bug [WI 26233](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26233): Process ValueSet tags failed: "Cannot perform Merge - multiple matches"

