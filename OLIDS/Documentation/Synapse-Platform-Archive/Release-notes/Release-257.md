# Release 257

- [Release 257](#release-257)
  - [Summary](#summary)
  - [✨ New Features](#%E2%9C%A8-new-features)
  - [🎯 Improvements](#%F0%9F%8E%AF-improvements)
  - [🐞 Bug Fixes](#%F0%9F%90%9E-bug-fixes)
  - [♻️ Refactoring](#%E2%99%BB%EF%B8%8F-refactoring)
  - [Inputs](#inputs)
  - [Full Details](#full-details)

> [!NOTE]
> The below is a summary of the changes since the previous release [Release-237](Release-237.md).

## Summary

### Release 238

This release delivers enhanced data observability, improved resilience, and greater consistency across the One London Data Platform. Key highlights include new monitoring views for batch failures, updates to data publication processes, improved logging and retry logic for pipelines and notebooks, and multiple bug fixes addressing data accuracy and schema consistency.

### Release 241

This release delivers significant improvements to the One London Data Platform, including enhanced Common Model pipelines, more robust batch processing, and critical schema updates for improved data quality and consistency. Several bug fixes address performance, schema mismatches, and transmission reliability, while refactoring work improves maintainability and clarity of OLIDS view definitions.

### Release 244

This release introduces targeted improvements to data processing pipelines, enhances the accuracy and performance of data transformations, and resolves several bugs affecting data quality and system reliability. Users will benefit from more efficient data handling, improved scheduling of key pipelines, and greater clarity in data outputs.

### Release 245/246

This release focuses on improving the reliability and clarity of scheduled data pipelines. Key highlights include preventing multiple instances of scheduled pipelines from running simultaneously and removing outdated comments for cleaner documentation.

### Release 249

This release focuses on improving system reliability and efficiency within the One London Data Platform. Key highlights include a fix for a blocking error in the transmitter outbox writer and enhancements to scheduled pipeline management, ensuring smoother operations and reducing unnecessary workload.

### Release 252

This release focuses on improving data processing reliability and accuracy within the One London Data Platform. Key highlights include updates to person-related procedures to prevent errors with large datasets, enhancements to pipeline file handling for better uniqueness, and corrections to how test NHS numbers are managed to avoid comparison issues.

### Release 253

This release delivers a targeted fix to the data processing pipeline, resolving concurrency errors and ensuring reliable creation of staging tables. These changes improve the stability and dependability of preprocessor operations for all users.

### Release 254

This release delivers a critical hotfix to the preprocessor service, resolving errors that previously caused failures during data processing. The update ensures smoother operation and improved reliability for users working with the platform.

### Release 255

This release focuses on resolving key data processing issues within the One London Data Platform. It delivers important bug fixes to improve the accuracy and reliability of record tagging and s-flag generation, ensuring smoother data operations and reducing errors in future workflows.

### Release 257

This release delivers enhanced monitoring and reporting features, improved data processing reliability, and several targeted bug fixes to ensure greater data quality and consistency across the One London Data Platform. Notable highlights include new progress reports for ICBs, dynamic Spark configuration for Lakehouse pipelines, and multiple corrections to data joins and field handling.

## ✨ New Features

### Release 238

- Added new monitoring views in the Metadata database to help identify failed batches and improve data observability. *[SQL, [PR#2707](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2707), [WI#25251](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25251)]*  
  > ✨ ***Feature:*** Enables more effective tracking and reporting of data processing failures for better operational oversight.

- Built and automated the Publisher.DataSetPublication table using GP register mappings, replacing manual data entry. *[SQL, [PR#2732](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2732), [WI#25420](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25420)]*  
  > ✨ ***Feature:*** Ensures data publications are up-to-date and accurate, reducing manual errors and improving reliability.

- Introduced a new Synapse data flow that automatically enriches the ExtractGroups table with missing details from SubscriberAgreements, reducing manual updates and keeping configuration data up to date. *[SynapseWorkspace, [PR#2794](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2794), [WI#25787](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25787), [WI#25846](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25846)]*  
  > ✨ ***Feature:*** Ensures new extract groups are automatically populated with correct metadata, streamlining onboarding and reducing errors.

- Added tables and views to track all table dependencies from supplier source tables through to LDS dataset tables, providing better visibility for engineers and supporting future process improvements. *[SQL, [PR#2817](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2817), [WI#25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848)]*  
  > ✨ ***Feature:*** Enables easier analysis of data lineage and supports more efficient troubleshooting and optimization.

- Added a managed private endpoint to securely connect Synapse Workspace to the Snowflake LDS Airlock PID resource, enhancing data security. *[SynapseWorkspace, [PR#2813](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2813), [WI#25934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25934)]*  
  > ✨ ***Feature:*** Strengthens platform security by ensuring private, encrypted data transfers between key systems.

### Release 241

- Created a managed private endpoint for secure Synapse connections to Snowflake accounts over private link. *[SynapseWorkspace, [PR#2742](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2742)]*  
  > ✨ ***Feature:*** Enables secure, private connectivity between Synapse and Snowflake, supporting compliance and data protection requirements.

### Release 244

- Added a new column, LakehouseDateProcessed, to the postcode hash reference view, providing clearer tracking of when data is processed. *[SynapseWorkspace, [PR#2789](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2789), [WI#25847](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25847), [WI#25855](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25855)]*  
  > ✨ ***Feature:*** Enables users and systems to see when postcode hash data was last processed, improving transparency.

### Release 249

- Introduced a new Synapse data flow that automatically enriches the ExtractGroups table with missing details from SubscriberAgreements, reducing manual updates and keeping configuration data up to date. *[SynapseWorkspace, [PR#2794](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2794), [WI#25787](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25787), [WI#25846](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25846)]*  
  > ✨ ***Feature:*** Ensures new extract groups are automatically populated with correct metadata, streamlining onboarding and reducing errors.

- Added tables and views to track all table dependencies from supplier source tables through to LDS dataset tables, providing better visibility for engineers and supporting future process improvements. *[SQL, [PR#2817](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2817), [WI#25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848)]*  
  > ✨ ***Feature:*** Enables easier analysis of data lineage and supports more efficient troubleshooting and optimization.

- Added a managed private endpoint to securely connect Synapse Workspace to the Snowflake LDS Airlock PID resource, enhancing data security. *[SynapseWorkspace, [PR#2813](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2813), [WI#25934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25934)]*  
  > ✨ ***Feature:*** Strengthens platform security by ensuring private, encrypted data transfers between key systems.

### Release 250

- Added procedures, tables, and views to make SRAttendee available in the Common Model, enabling future practitioner counts for TPP appointments. *[SQL, [PR#2846](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2846), [WI#26130](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26130)]*  
  > ✨ ***Feature:*** Supports richer practitioner data and reporting for appointments.

### Release 252

- Added a new table to store Spark pool configurations, along with a stored procedure to retrieve configurations by process name. *[SQL, [PR#2838](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2838), [WI#25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849)]*  
  > ✨ ***Feature:*** Enables easier management and retrieval of Spark pool settings for different processes, paving the way for more flexible resource allocation.

### Release 257

- Introduced a new monitoring view and progress report for Integrated Care Boards (ICBs), enabling more detailed tracking of data processing and reporting. *[SQL, [PR#2930](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2930), [WI#25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930)]*  
  > ✨ ***Feature:*** Users can now access progress reports for ICBs, supporting improved oversight of data flows.

- Added a new pipeline to import EMIS and TPP files for monitoring, supporting comprehensive observability of incoming data. *[SynapseWorkspace, [PR#2933](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2933), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934), [WI#25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930)]*  
  > ✨ ***Feature:*** Enables more complete monitoring of file imports for EMIS and TPP, improving data traceability.

## 🎯 Improvements

### Release 238

- Updated procedure and batch tables to better identify Preprocessor and Allocator runs, supporting more detailed monitoring of pipeline failures. *[SQL, [PR#2736](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2736), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*  
  > 🎯 ***Impact:*** Enhances the ability to monitor and respond to pipeline issues, improving operational resilience.

- Added Preprocessor and Allocator run tracking to the Batch table for improved monitoring of pipeline processes. *[SynapseWorkspace, [PR#2733](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2733), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*  
  > 🎯 ***Impact:*** Provides clearer visibility into pipeline executions and failures.

- Enhanced the CommonModel pipeline logging to ensure failures during post-processing are correctly recorded in the Metadata database. *[SynapseWorkspace, [PR#2716](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2716), [WI#25317](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25317)]*  
  > 🎯 ***Impact:*** Improves the accuracy of failure logging, helping teams quickly identify and resolve issues.

- Added retry logic to all SQL functions in the shared notebook, increasing resilience against transient errors. *[SynapseWorkspace, [PR#2725](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2725), [WI#24673](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24673)]*  
  > 🎯 ***Impact:*** Reduces the risk of process interruptions due to temporary failures, making data processing more robust.

### Release 241

- Enhanced Common Model pipelines to separate pre and post continuum stages, allowing for better management of batch failures and metadata-driven deactivation. *[SQL, [PR#2749](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2749), [WI#25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655)]*  
  > 🎯 ***Impact:*** Improves reliability and flexibility in data processing, reducing unnecessary reruns and enabling better control.
- Improved Common Model pipelines to allow parallel running of PCD and Masked CDM, and removed redundant triggers and code. *[SynapseWorkspace, [PR#2753](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2753), [WI#25305](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25305), [WI#25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655)]*  
  > 🎯 ***Impact:*** Speeds up data processing and ensures better coordination between related pipelines.
- Updated FileCombiner batch processing logic to improve support for retries and ensure files are correctly marked as part of the processing batch. *[SQL, [PR#2760](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2760), [WI#24841](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24841)]*  
  > 🎯 ***Impact:*** Reduces risk of duplicate processing and improves handling of failed batches.
- Enhanced FileCombiner pipeline to immediately mark queued files as part of the current batch and ensure all files are requeued on failure. *[SynapseWorkspace, [PR#2763](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2763), [WI#24841](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24841)]*  
  > 🎯 ***Impact:*** Improves data integrity and reliability in file processing workflows.
- Added `LDS_INITIAL_DATA_RECEIVED_DATE` to OLIDS views for patient, address, and contact tables, improving schema completeness. *[SynapseWorkspace, [PR#2752](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2752), [WI#24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743)]*  
  > 🎯 ***Impact:*** Enhances data tracking and supports more accurate reporting.

### Release 244

- Enhanced the Common Model pipelines by adding system versioning to the configuration table, supporting better metadata management and flexible pipeline operation. *[SQL, [PR#2782](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2782), [WI#25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655)]*  
  > 🎯 ***Impact:*** Improves pipeline reliability and makes it easier to manage and deactivate pipeline components as needed.

- Improved transmitter valueset and sflags tag filtering to use table names, reducing unnecessary data scanning and speeding up processing for large views. *[SynapseWorkspace, [PR#2791](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2791), [WI#25643](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25643)]*  
  > 🎯 ***Impact:*** Increases performance for large data transmissions, making the platform faster and more efficient.

- Updated all snowflake activities in transmitter pipelines to have a 12-hour timeout, ensuring long-running transmissions complete successfully. *[SynapseWorkspace, [PR#2788](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2788), [WI#24721](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24721)]*  
  > 🎯 ***Impact:*** Prevents premature timeouts and supports uninterrupted data flows for lengthy processes

### Release 245

- Prevented scheduled pipelines from running multiple instances at the same time, ensuring smoother and more reliable data processing. *[SynapseWorkspace, [PR#2795](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2795), [WI#23783](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23783)]*  
  > 🎯 ***Impact:*** This change helps avoid unnecessary queueing and resource conflicts, leading to more stable pipeline operations.

### Release 249

- Enhanced allocation table filtering in the transmitter by using a list of table dependencies from metadata, improving performance for allocation-based transmissions. *[SynapseWorkspace, [PR#2824](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2824), [WI#25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848)]*  
  > 🎯 ***Impact:*** Reduces processing time and resource usage for data transmissions, especially for large datasets.

- Updated Person and Patient Person views in OLIDS to match CDM views and corrected person_id definitions, ensuring consistent and accurate record linking. *[SynapseWorkspace, [PR#2781](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2781), [WI#25829](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25829)]*  
  > 🎯 ***Impact:*** Improves data consistency and reliability for downstream analytics and reporting.

- Added a view to help users identify which tables and views are used by each transform view, aiding engineers and data analysts. *[SQL, [PR#2814](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2814), [WI#25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848)]*  
  > 🎯 ***Impact:*** Makes it easier to understand data flows and dependencies, supporting better system maintenance.

- Set Airlock and NCL Snowflake endpoints to use XL warehouses in pre-production and production environments, ensuring optimal performance. *[SQL, [PR#2802](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2802), [WI#24719](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24719)]*  
  > 🎯 ***Impact:*** Guarantees high-capacity processing for critical data exports, reducing risk of bottlenecks.

### Release 250

- Updated the FileCombiner pipeline to ensure each processed file has a unique name, reducing the risk of overwriting and improving traceability during data processing. *[SynapseWorkspace, [PR#2837](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2837), [WI#26116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26116)]*  
  > 🎯 ***Impact:*** This change increases the reliability of file processing and helps prevent failures in the data pipeline.

### Release 251

- Updated person and patient-person transformation procedures to use CTAS operations, optimizing how new records are materialized before merging into the Common Data Model. *[SQL, [PR#2844](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2844), [WI#26153](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26153)]*  
  > 🎯 ***Impact:*** Improves performance and reliability of data loading for person-related tables.

- Made LDSBusinessId deterministic for Terminology Resource and ConceptMap tables, ensuring consistent and traceable identifiers. *[SQL, [PR#2836](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2836), [WI#25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962)]*  
  > 🎯 ***Impact:*** Enhances data integrity and simplifies linking between resources.

- Updated Synapse Workspace notebook for column masking functions. *[SynapseWorkspace, [PR#2855](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2855)]*  
  > 🎯 ***Impact:*** Improves data privacy and consistency in notebook processing.

- Added and updated Synapse Workspace pipeline and notebook for column masking and Spark notebook calls. *[SynapseWorkspace, [PR#2848](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2848)]*  
  > 🎯 ***Impact:*** Streamlines data masking operations and integration with Spark.

- Released updates to Synapse Workspace for NDOO pipelines and related notebooks. *[SynapseWorkspace, [PR#2852](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2852), [PR#2853](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2853)]*  
  > 🎯 ***Impact:*** Improves automation and management of NDOO data processing workflows.

### Release 252

- Parameterised Spark pool settings for the transmitter outbox writer notebook, allowing configurations to be managed centrally via metadata. *[SynapseWorkspace, [PR#2842](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2842), [WI#25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849)]*  
  > 🎯 ***Impact:*** Makes it simpler to adjust Spark pool resources for different tables and processes, improving operational control and efficiency.

### Release 257

- Extended dynamic Spark configuration logic to Delta Lakehouse pipelines, allowing Spark settings to be managed centrally for greater flexibility and consistency. *[SynapseWorkspace, [PR#2903](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2903), [WI#25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849), [WI#26279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26279), [WI#26280](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26280)]*  
  > 🎯 ***Impact:*** Pipeline performance and resource usage can be tuned without code changes, making operations more efficient.

- Enhanced monitoring capabilities by adding new views and consolidating event tracking, supporting better visibility into batch progress and file status. *[SQL, [PR#2916](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2916), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*  
  > 🎯 ***Impact:*** Administrators can more easily identify and resolve pipeline issues.

- Updated the monitoring summary view to include additional file details, such as event ID, file size, and last modified date. *[SQL, [PR#2884](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2884), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*  
  > 🎯 ***Impact:*** Provides richer information for tracking data files and troubleshooting.

- Added procedures and logging to Registrar pipelines to check for unprocessed files before running, preventing unnecessary failures. *[SQL, [PR#2907](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2907), [WI#26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232)]*  
  > 🎯 ***Impact:*** Ensures Registrar pipelines only run when data is available, improving reliability.

- Implemented a master pipeline that checks for the presence of response files before running the Registrar Response process. *[SynapseWorkspace, [PR#2904](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2904), [WI#26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232)]*  
  > 🎯 ***Impact:*** Reduces pipeline errors by verifying file availability before processing.

## 🐞 Bug Fixes

### Release 238

- Populated Type and Status concept ID fields for EMIS episodes of care, resolving issues with missing identifiers. *[SQL, [PR#2735](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2735), [WI#25245](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25245)]*  
  > 🐞 ***Fix:*** Ensures episodes of care have complete and accurate identifiers, improving data quality for users.

- Corrected SQL overflow error in the data sharing agreement view, allowing accurate calculation of expiry dates with grace periods. *[SQL, [PR#2714](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2714), [WI#25294](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25294)]*  
  > 🐞 ***Fix:*** Prevents system errors and ensures reliable allocation processing.

- Changed data types in the SRRepeatTemplate to match TPP data, addressing specification inconsistencies. *[SQL, [PR#2715](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2715), [WI#25278](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25278)]*  
  > 🐞 ***Fix:*** Aligns data structures for better compatibility and accuracy.

- Updated OLIDS schema to use 'OLIDS COMMON' instead of 'OLIDS MASKED' for table naming and structures, based on user group feedback. *[SynapseWorkspace, [PR#2723](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2723), [WI#25158](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25158)]*  
  > 🐞 ***Fix:*** Improves schema consistency and supports urgent business requirements.

- Changed aliases for Procedure Request and Diagnostic Order views to standardize concept ID field names and resolve inconsistencies. *[SynapseWorkspace, [PR#2729](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2729), [WI#24323](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24323), [WI#24345](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24345)]*  
  > 🐞 ***Fix:*** Ensures consistent naming across views, aiding data interpretation and reducing confusion.

- Updated OLIDS dictionary aliases to reflect feedback and maintain consistency. *[SynapseWorkspace, [PR#2739](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2739), [WI#24643](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24643)]*  
  > 🐞 ***Fix:*** Addresses user feedback to improve usability and clarity of the OLIDS dictionary.

### Release 241

- Fixed allocator timeout failures by optimizing partitioning of the associations delta lake table for more efficient reading. *[SynapseWorkspace, [PR#2779](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2779), [WI#25659](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25659), [WI#25667](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25667)]*  
  > 🐞 ***Fix:*** Improves performance and reduces delays in data allocation processes.
- Fixed monitoring views in Common Model and Transmitter to correctly identify batch failures and child event counts. *[SQL, [PR#2741](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2741), [WI#25638](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25638)]*  
  > 🐞 ***Fix:*** Ensures more accurate monitoring and troubleshooting of data loads.
- Corrected schema issues in CDM tables by adding missing columns such as `InitialExtractStartTime`, aligning with OLIDS definitions. *[SQL, [PR#2750](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2750), [WI#24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743), [WI#24748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24748), [WI#24749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24749), [WI#24751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24751), [WI#25355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25355), [WI#25356](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25356), [WI#25562](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25562), [WI#25685](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25685), [WI#25686](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25686), [WI#25695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25695)]*  
  > 🐞 ***Fix:*** Resolves inconsistencies between documentation and database schema, improving data quality.
- Fixed issue where parquet file dates and datetimes were misinterpreted by Snowflake by updating file writing settings. *[SynapseWorkspace, [PR#2748](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2748), [WI#25264](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25264), [WI#25660](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25660)]*  
  > 🐞 ***Fix:*** Ensures correct date and time representation in transmitted data, preventing errors and confusion.
- Set Livy timeout in transmitter notebook to prevent session timeouts during large data transmissions. *[SynapseWorkspace, [PR#2756](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2756), [WI#25401](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25401), [WI#25648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25648)]*  
  > 🐞 ***Fix:*** Reduces risk of transmission failures due to timeout, improving reliability.
- Removed managed private endpoint for SnowflakeAirlockPID-pep to resolve deployment pipeline failures. *[SynapseWorkspace, [PR#2758](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2758), [WI#25749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25749)]*  
  > 🐞 ***Fix:*** Restores successful deployment and infrastructure stability.

### Release 244

- Corrected the logic for setting the IsProblem flag in EMIS Observation and Diagnostic Order views, so it only marks records as problems when appropriate. *[SQL, [PR#2784](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2784), [WI#25011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25011)]*  
  > 🐞 ***Fix:*** Ensures that only relevant records are flagged, improving data accuracy for users and downstream systems.

- Fixed transmission issues for the postcode hash table by including the necessary LakehouseDateProcessed column. *[SynapseWorkspace, [PR#2789](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2789), [WI#25847](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25847)]*  
  > 🐞 ***Fix:*** Resolves missing data in transmissions, ensuring complete and correct datasets are available.

- Stopped scheduled pipelines, such as Preprocessor Master, from queueing multiple runs when a previous instance is still running. *[SynapseWorkspace, [PR#2792](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2792), [WI#23783](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23783)]*  
  > 🐞 ***Fix:*** Prevents pipeline congestion and improves overall system stability by avoiding duplicate runs.

### Release 245

- Fixed an error in the transmitter outbox writer function caused by an incorrect variable name. *[SynapseWorkspace, [PR#2798](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2798), [WI#25904](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25904)]*  
  > 🐞 ***Fix:*** Resolving this issue allows the transmitter to run smoothly, eliminating interruptions and maintaining reliable data processing.

### Release 249

- Fixed mapping errors in ReferralRequest, ensuring organisation IDs are correctly assigned and improving data accuracy for referrals. *[SQL, [PR#2809](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2809), [WI#25748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25748), [WI#25958](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25958)]*  
  > 🐞 ***Fix:*** Resolves inconsistencies in referral data, supporting better patient tracking and reporting.

- Corrected column ordering for concept IDs in ProcedureRequest tables, ensuring status and procedure concepts are stored in the correct fields. *[SQL, [PR#2808](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2808), [WI#25729](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25729), [WI#25778](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25778), [WI#25955](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25955)]*  
  > 🐞 ***Fix:*** Prevents confusion and errors when joining procedure data, improving data quality.

- Updated mapping for TPP SRPersonAtRisk flags to include the full flag text, ensuring more complete and useful data in risk assessments. *[SQL, [PR#2807](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2807), [WI#25771](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25771)]*  
  > 🐞 ***Fix:*** Ensures risk flags are fully descriptive, supporting better clinical decision-making.

- Restricted monitoring view to valid ODS codes, resolving issues with duplicate or incorrect practice codes in Power BI reports. *[SQL, [PR#2806](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2806), [WI#25299](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25299)]*  
  > 🐞 ***Fix:*** Improves accuracy of practice reporting and monitoring dashboards.

- Fixed data type mismatch in row count calculations by using COUNT_BIG(), preventing errors in large data exports. *[SQL, [PR#2805](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2805), [WI#26014](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26014)]*  
  > 🐞 ***Fix:*** Ensures reliable export of large datasets without overflow errors.

- Addressed overlapping Supplier GUIDs to ensure LDSBusinessKey values are unique, preventing record update errors and missing data. *[SQL, [PR#2825](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2825), [WI#25924](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25924)]*  
  > 🐞 ***Fix:*** Restores data integrity for EMIS and TPP records, reducing risk of data loss.

- Fixed arithmetic overflow error in CDM pipeline by updating row count logic, allowing successful completion of data processes. *[SQL, [PR#2816](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2816), [WI#25911](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25911)]*  
  > 🐞 ***Fix:*** Prevents pipeline failures and ensures all records are processed.

- Corrected date casting in OLIDS views, standardizing date fields and improving consistency across tables. *[SynapseWorkspace, [PR#2810](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2810), [WI#25193](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25193), [WI#25830](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25830)]*  
  > 🐞 ***Fix:*** Reduces confusion and errors when working with date fields, supporting better data analysis.

- Added missing PERSON_ID column to OLIDS_PCD.PATIENT_ADDRESS, ensuring complete linkage between address and person records. *[SynapseWorkspace, [PR#2811](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2811), [WI#25326](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25326)]*  
  > 🐞 ***Fix:*** Restores full address-to-person mapping for downstream systems.

- Changed EMIS Observation logic to correctly set records as primary if they do not have a parent, fixing incorrect is_primary flags. *[SQL, [PR#2803](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2803), [WI#24949](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24949), [WI#25012](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25012)]*  
  > 🐞 ***Fix:*** Ensures primary observations and diagnostic orders are correctly identified.

- Removed obsolete TODO comment from RunOutputTableCheck procedure, improving code clarity. *[SQL, [PR#2799](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2799), [WI#24913](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24913)]*  
  > 🐞 ***Fix:*** Keeps codebase clean and easier to maintain.

### Release 250

- Changed the count function to count_big in EMIS and TPP Person procedures to prevent errors when processing large numbers of records. *[SQL, [PR#2841](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2841), [WI#26137](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26137)]*  
  > 🐞 ***Fix:*** This update removes limitations on the maximum number of persons that can be counted, ensuring smooth operation with large datasets.
- Updated test NHS numbers in the Person procedure to use the VARCHAR type instead of integers, resolving errors caused by misformatted or alphanumeric NHS numbers. *[SQL, [PR#2835](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2835), [WI#26122](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26122)]*  
  > 🐞 ***Fix:*** This correction allows for accurate comparisons and processing of all NHS numbers, improving data quality and reducing errors.

### Release 251

- Added primary key to Preprocessor_Events table to address failures in the FileCombiner process. *[SQL, [PR#2854](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2854), [WI#26116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26116)]*  
  > 🐞 ***Fix:*** Resolves critical data processing errors, ensuring stable event handling.

- Included practitioner ID for TPP-derived appointments, ensuring correct identification of the primary clinician and clarifying which ID fields are always populated. *[SQL, [PR#2839](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2839), [WI#24914](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24914)]*  
  > 🐞 ***Fix:*** Improves data accuracy for appointment records and supports better linkage to clinicians

### Release 252

- Changed comparison logic in concept mapping to use URL, Version, SourceCode, and TargetCode instead of ConceptMapId, preventing duplicate entries. *[SQL, [PR#2871](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2871), [WI#25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962)]*  
  > 🐞 ***Fix:*** Resolves duplication issues in concept mapping, ensuring cleaner and more accurate data outputs.

- Added missing parameters to ensure consistent configuration and prevent deployment issues. *[SQL, [PR#2859](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2859), [WI#25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962)]*  
  > 🐞 ***Fix:*** Ensures all necessary parameters are present, reducing the risk of errors during data processing.

- Updated the record tagging notebook to reflect changes in patient_person data structure. *[SynapseWorkspace, [PR#2867](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2867), [WI#25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962)]*  
  > 🐞 ***Fix:*** Maintains accurate tagging and data integrity following updates to patient data.

- Updated the concept_map notebook to add new fields and improve joins, enhancing the output for users and requiring post-deployment actions. *[SynapseWorkspace, [PR#2849](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2849), [WI#25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962)]*  
  > 🐞 ***Fix:*** Provides richer concept mapping information and simplifies data queries for end users.

- Fixed a concurrency issue with Delta Lake table creation in the preprocessor, ensuring tables are created before parallel notebook runs. *[SynapseWorkspace, [PR#2864](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2864), [WI#26201](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26201)]*  
  > 🐞 ***Fix:*** Prevents occasional errors when multiple notebooks attempt to create the same table simultaneously, improving reliability of data processing.

### Release 253

- Fixed an issue where preprocessor notebooks could attempt to create the association staging table at the same time, causing concurrency errors. The process now ensures proper dependency handling to avoid failures. *[SynapseWorkspace, [PR#2875](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2875), [WI#26200](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26200), [WI#26225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26225)]*  
  > 🐞 ***Fix:*** Users will experience fewer pipeline failures and improved data processing reliability.

### Release 254

- Corrected an indentation error in the file-warden functions to fix failures in the preprocessor service. This resolves issues with staging table creation and missing dependencies, ensuring data processing runs smoothly without interruption. *[SynapseWorkspace, [PR#2877](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2877), [WI#26200](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26200), [WI#26225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26225)]*  
  > 🐞 ***Fix:*** Users will experience more reliable data processing and fewer errors when running preprocessor notebooks.

### Release 255

- Fixed an issue where record tagging could fail due to duplicate value set tags, ensuring each tag is now processed uniquely without merge conflicts. *[SynapseWorkspace, [PR#2881](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2881), [WI#26233](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26233)]*  
  > 🐞 ***Fix:*** This update prevents data merge errors, improving reliability when processing value set tags.

- Corrected the SQL logic for s-flag generation to reference the latest business ID version for each person, eliminating ambiguous column references and ensuring accurate flagging. *[SynapseWorkspace, [PR#2879](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2879), [WI#26231](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26231)]*  
  > 🐞 ***Fix:*** This resolves errors in s-flag record creation, ensuring the most recent data is used for sensitive flagging.

### Release 257

- Corrected EMIS Transform joins to also match OrganisationGuid, resolving discrepancies in practice counts and improving data accuracy. *[SQL, [PR#2925](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2925), [WI#25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246)]*  
  > 🐞 ***Fix:*** Ensures patient counts and episode care data are correctly matched across practices.

- Improved handling of episode of care end dates in EMIS transforms, addressing mismatches in registration counts and patient history. *[SQL, [PR#2927](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2927), [WI#25766](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25766), [WI#25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971)]*  
  > 🐞 ***Fix:*** Provides more accurate episode of care data, reducing registration count mismatches.

- Set default values for LDSIsDeleted in EMIS and TPP patient tables to prevent null errors and ensure correct deletion flags. *[SQL, [PR#2873](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2873), [WI#25835](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25835)]*  
  > 🐞 ***Fix:*** Prevents failures in patient data processing and ensures deletion status is always set.

- Fixed the concept join for MedicationStatement to ensure medication codes are correctly populated, improving data completeness. *[SQL, [PR#2908](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2908), [WI#25737](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25737)]*  
  > 🐞 ***Fix:*** Medication statements now include both names and codes, supporting better analysis.

- Changed concept ID joins to cast bigint codes as varchar, resolving missing medication codes for TPP MedicationStatement records. *[SQL, [PR#2901](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2901), [WI#25737](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25737)]*  
  > 🐞 ***Fix:*** Medication codes are now consistently available, improving data quality.

- Added missing fields to PCD tables so that masked and PCD outputs contain equivalent information, preventing data loss. *[SQL, [PR#2890](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2890), [WI#25325](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25325)]*  
  > 🐞 ***Fix:*** Ensures all necessary patient fields are present in PCD outputs.

- Made select statements for conceptmap and valueset resources distinct to prevent duplicates caused by concept casing issues. *[SQL, [PR#2885](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2885), [WI#26230](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26230)]*  
  > 🐞 ***Fix:*** Reduces duplicate entries and improves terminology processing reliability.

- Fixed version comparison logic to support correct terminology processing and reduce pipeline failures. *[SQL, [PR#2880](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2880), [WI#26230](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26230)]*  
  > 🐞 ***Fix:*** Prevents errors in terminology master pipeline runs.

- Trimmed spaces in StartDate and EndDate fields for patient contact views, resolving formatting errors in outbox activities. *[SynapseWorkspace, [PR#2919](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2919), [WI#26404](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26404)]*  
  > 🐞 ***Fix:*** Ensures dates are consistently formatted, preventing write errors.

- Corrected errors in OLIDS notebook definitions, including table aliases and business ID references. *[SynapseWorkspace, [PR#2891](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2891), [WI#26257](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26257)]*  
  > 🐞 ***Fix:*** Improves reliability of OLIDS view generation and data joins.


## ♻️ Refactoring

### Release 238

- Created new monitoring views and refactored existing ones for batch failure reporting, improving maintainability and consistency in the Metadata database. *[SQL, [PR#2727](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2727), [WI#24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*  
  > ♻️ ***Refactor:*** Streamlines monitoring logic and prepares the platform for future enhancements.

### Release 241

- Split up OLIDS view definitions so each table/view is in its own notebook file, and added missing columns for better schema alignment. *[SynapseWorkspace, [PR#2745](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2745), [WI#24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743), [WI#24744](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24744), [WI#24748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24748), [WI#24749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24749), [WI#24750](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24750), [WI#24751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24751), [WI#24784](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24784), [WI#24964](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24964), [WI#25355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25355), [WI#25562](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25562), [WI#25678](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25678), [WI#25685](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25685), [WI#25686](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25686), [WI#25695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25695)]*  
  > ♻️ ***Refactor:*** Makes future updates easier and reduces risk of conflicts between changes.
- Removed `is_deleted` and `IsDeleted` fields from all OLIDS views to avoid confusion and maintain consistency with dataset agnostic deletion indicators. *[SynapseWorkspace, [PR#2755](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2755), [WI#24964](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24964), [WI#25010](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25010)]*  
  > ♻️ ***Refactor:*** Simplifies schema and ensures users rely on the correct deletion indicator.
- Removed `is_deleted` field from OLIDS Observation view for clarity and alignment with schema dictionary. *[SynapseWorkspace, [PR#2754](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2754), [WI#24337](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24337)]*  
  > ♻️ ***Refactor:*** Prevents confusion and ensures schema matches documentation.

### Release 244

- Removed the redundant ApplyAllocation field from the LDS.DataSetObject table and cleaned up old references in procedures, following its migration to a more appropriate location. *[SQL, [PR#2786](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2786), [WI#24435](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24435)]*  
  > ♻️ ***Refactor:*** Streamlines database structure and procedures, reducing confusion and improving maintainability.

- Deleted the unused transform view PrimaryCareEMIS_CareRecord_Observation_Referral to reduce clutter and potential confusion in the data model. *[SQL, [PR#2785](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2785), [WI#24220](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24220)]*  
  > ♻️ ***Refactor:*** Keeps the platform clean and focused by removing obsolete components.

### Release 245

- Removed outdated 'TEMPORARY' comments from transmitter activity descriptions to keep documentation up to date. *[SynapseWorkspace, [PR#2780](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2780), [WI#25573](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25573)]*  
  > ♻️ ***Refactor:*** Improves clarity and maintainability by eliminating obsolete notes from pipeline activities.

### Release 249

- Improved how Columns_GetNamesWithVarchar identifies overrides for VARCHAR fields, switching from GUID to object name and dataset name for better maintainability. *[SQL, [PR#2797](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2797), [WI#24869](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24869)]*  
  > ♻️ ***Refactor:*** Simplifies future updates and reduces risk of errors in column specifications.

- Split PDS response processing into separate Person and PatientPerson logic, aligning with design principles and supporting more robust data handling. *[SQL, [PR#2685](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2685), [WI#24112](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24112), [WI#24926](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24926), [WI#25835](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25835)]*  
  > ♻️ ***Refactor:*** Improves data model clarity and supports future enhancements for patient records.

### Release 257

- Refactored the CSV reader function to separate custom and native parsers, adding a try/catch mechanism to fallback to the native reader if the custom one fails. *[SynapseWorkspace, [PR#2896](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2896), [WI#25670](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25670)]*  
  > ♻️ ***Refactor:*** Improves error handling and maintainability of CSV file processing logic.

- Internal updates and branch management for notebook and pipeline changes. *[SynapseWorkspace, [PR#2926](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2926)]*  
  > ♻️ ***Refactor:*** Supports ongoing development and testing without affecting production data.

## Inputs

This change note was automatically produced from:

- Release 238
  - 13 Pull Requests
  - 14 Work Items
  - 137 Commits
- Release 241
  - 15 Pull Requests
  - 41 Work Items
  - 198 Commits
- Release 244
  - 8 Pull Requests
  - 9 Work Items
  - 84 Commits
- Release 245
  - 2 Pull Requests
  - 2 Work Items
  - 5 Commits
- Release 246
  - 2 Pull Requests
  - 2 Work Items
  - 4 Commits
- Release 249
  - 21 Pull Requests
  - 29 Work Items
  - 267 Commits
- Release 250
  - 3 Pull Requests
  - 3 Work Items
  - 11 Commits
- Release 251
  - 9 Pull Requests
  - 5 Work Items
  - 104 Commits
- Release 252
  - 7 Pull Requests
  - 7 Work Items
  - 33 Commits
- Release 253
  - 1 Pull Requests
  - 2 Work Items
  - 2 Commits
- Release 254
  - 1 Pull Requests
  - 2 Work Items
  - 3 Commits
- Release 255
  - 2 Pull Requests
  - 2 Work Items
  - 7 Commits
- Release 257
  - 19 Pull Requests
  - 22 Work Items
  - 127 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:

### Release 238

- [PR 2732](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2732): Build Publisher.DataSetPublication table from GP register mappings
  - Task [WI 25420](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25420): Populate or update Publisher.DataSetPublication from GP register
- [PR 2707](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2707): Metadata Database - Batch Failure Views
  - Task [WI 25251](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25251): Create Failed Batch Reports for each module
- [PR 2735](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2735): Populate Type and Status concept ID fields for EMIS episodes of care
  - Bug [WI 25245](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25245): Episode_of_care_table
- [PR 2736](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2736): Updating procedure: Batch_CreateBatch
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
- [PR 2727](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2727): Metadata Database - Batch Failure Views
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
- [PR 2714](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2714): Hotfix: Updated vDataSharingAgreementForSubscriber.sql
  - Bug [WI 25294](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25294): Allocator failure: SQL overflow in DSA grace period calculation
- [PR 2715](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2715): Changed data types in SRRepeatTemplate.
  - Bug [WI 25278](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25278): TPP versioner config review
- [PR 2739](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2739): Updating notebook: olids_common
  - Bug [WI 24643](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24643): Update OLIDS Dictionary - can use prompts from NWL feedback on User Testing board to assist with this
- [PR 2723](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2723): Transmitter_Update_OLIDS_Columns_UpperCase
  - Bug [WI 25158](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25158): OLIDS schema: Use 'OLIDS COMMON' instead of OLIDS MASKED in table naming and structures
- [PR 2725](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2725): Added retry logic to all SQL functions
  - Task [WI 24673](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24673): Placeholder task / amend as necessary
- [PR 2733](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2733): Add Preprocessor and Allocator to Batch table
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
- [PR 2729](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2729): Changed alias for Procedure Request and Diagnostic Order olids_masked views
  - Bug [WI 24323](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24323): Investigate concept ID inconsistently named between diagnostic_order and observation table
  - Bug [WI 24345](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24345): Update column name in db consistently - ##procedure_request
- [PR 2716](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2716): CommonModel Pipeline - Logging Fix
  - Task [WI 25317](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25317): Fix/Enhance CommonModel Pipeline

### Release 241

- [PR 2749](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2749): Enhance Common Model Pipelines
  - User Story [WI 25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655): separate 'Common Model Master' into pre and post continuum
- [PR 2750](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2750): Add missing columns to CDM tables: `InitialExtractStartTime` (=LDS_Initial_Data_Received_Date)
  - User Story [WI 24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743): Correct schema issues identified in updating OLIDS dictionary
  - Task [WI 24748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24748): patient(masked) - missing `initial_data_received_date`
  - Task [WI 24749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24749): patient_address(masked) is missing `initial_data_received_date`
  - Task [WI 24751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24751): patient_contact(masked) is missing `initial_data_received_date`
  - Bug [WI 25355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25355): lds_initial_date_received_date (in PATIENT table) vs lds_initial_data_received_date (in OLIDS online dictionary)
  - Bug [WI 25356](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25356): lds_initial_date_received_date (in PATIENT_ADDRESS table) vs lds_initial_data_received_date (in OLIDS online dictionary)
  - Bug [WI 25562](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25562): OLIDS documentation: Variation between documented schema and database
  - Task [WI 25685](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25685): patient(pcd) - missing `initial_data_received_date`
  - Task [WI 25686](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25686): patient_address(pcd) - missing initial_data_received_date
  - Task [WI 25695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25695): patient_contact(pcd) - missing initial_data_received_date
- [PR 2741](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2741): Monitoring Views - Common Model & Transmitter view fix
  - Task [WI 25638](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25638): Re-Run Failed Batches
- [PR 2760](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2760): Metatadata Database - FileCombine Batch Processing Update
  - User Story [WI 24841](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24841): FileCombiner pipeline should set destination batch ID upon receipt of queue
- [PR 2779](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2779): Fix for allocator timeout failures
  - Bug [WI 25659](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25659): Allocator slower than before - needs investigation
  - Task [WI 25667](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25667): Task placeholder
- [PR 2753](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2753): Enhance Common Model Pipelines
  - User Story [WI 25305](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25305): Re-review the parallel running of PCD and MASKED CDM
  - User Story [WI 25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655): Seperate 'Common Model Master' into pre and post continuum
- [PR 2745](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2745): split up OLIDS views and add lds_is_deleted to observation
  - User Story [WI 24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743): Correct schema issues identified in updating OLIDS dictionary
  - Task [WI 24744](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24744): Add `lds_is_deleted` to observation
  - Task [WI 24748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24748): patient(masked) - missing `initial_data_received_date`
  - Task [WI 24749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24749): patient_address(masked) is missing `initial_data_received_date`
  - Task [WI 24750](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24750): patient_address(masked) is missing `lds_is_deleted` from OLIDS view defn
  - Task [WI 24751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24751): patient_contact(masked) is missing `initial_data_recieved_date`
  - Task [WI 24784](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24784): practitioner table `lds_end_date_time` to be removed
  - Bug [WI 24964](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24964): Encounter: "is_deleted" column is not required
  - Bug [WI 25355](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25355): lds_initial_date_received_date (in PATIENT table) vs lds_initial_data_received_date (in OLIDS online dictionary)
  - Bug [WI 25562](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25562): OLIDS documentation: Variation between documented schema and database
  - User Story [WI 25678](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25678): Split up OLIDS notebook definitions into separate files
  - Task [WI 25685](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25685): patient(pcd) - missing `initial_data_received_date`
  - Task [WI 25686](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25686): patient_address(pcd) - missing initial_data_received_date
  - Task [WI 25695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25695): patient_contact(pcd) - missing initial_data_received_date
- [PR 2748](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2748): Fix for parquet file dates and datetimes misinterpreted by Snowflake
  - Bug [WI 25264](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25264): Abnormal clinical effective dates recorded into future in Medication_Order
  - Task [WI 25660](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25660): Task placeholder
- [PR 2763](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2763): FileCombiner Batch Processing Update
  - User Story [WI 24841](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24841): FileCombiner pipeline should set destination batch ID upon receipt of queue
- [PR 2754](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2754): Remove is_deleted field from OLIDS  Observation view
  - Bug [WI 24337](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24337): OLIDS schema: is_problem_deleted - Check and remove field if required / cross-check with OLIDS dictionary
- [PR 2756](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2756): Set Livy Timeout in transmitter_write_to_outbox notebook
  - Bug [WI 25401](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25401): Transmitter : Observation table is failing for transmitting to PID AIRLOCK Snowflake.
  - Task [WI 25648](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25648): Create a PR for the changes
- [PR 2755](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2755): Removed IS_DELETED and IsDeleted from ALL Olids views
  - Bug [WI 24964](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24964): Encounter: "is_deleted" column is not required
  - Bug [WI 25010](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25010): OLIDS schema: Is_deleted field is redundant - remove from ALL Olids views
- [PR 2758](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2758): Deleting managedPrivateEndpoint: SnowflakeAirlockPID-pep
  - Bug [WI 25749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25749): 'LDS Dev Deploy' deployment pipeline failed
- [PR 2752](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2752): Add `LDS_INITIAL_DATA_RECEIVED_DATE`
  - User Story [WI 24743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24743): Correct schema issues identified in updating OLIDS dictionary
- [PR 2742](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2742): Create managed endpoint for Synapse to connect to Snowflake accounts over private link
  - No Work Items linked to this PR.

### Release 244

- [PR 2784](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2784): Added condition for setting IsProblem flag
  - Bug [WI 25011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25011): observation: `is_problem` displays TRUE/1 for all records.
- [PR 2786](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2786): Removed redundant ApplyAllocation field
  - Task [WI 24435](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24435): drop old ApplyAllocation field from LDS.DataSetObject table
- [PR 2785](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2785): Removed Transform_masked.PrimaryCareEMIS_CareRecord_Observation_Referral
  - User Story [WI 24220](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24220): Transform view that is not used anywhere - [Transform_masked].[PrimaryCareEMIS_CareRecord_Observation_Referral]
- [PR 2782](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2782): Enhance Common Model Pipelines
  - User Story [WI 25655](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25655): Seperate 'Common Model Master' into pre and post continuum
- [PR 2788](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2788): Updated all snowflake activities to have 12 hour timeout
  - Task [WI 24721](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24721): Update all snowflake script activities to 12hour timeout
- [PR 2791](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2791): Improved transmitters valueset tags and sflags tags table name filtering
  - Task [WI 25643](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25643): Add object name filter to valueset tags and sflags tags filtering to benefit from partition pruning
- [PR 2792](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2792): Stop scheduled pipelines from queueing
  - Bug [WI 23783](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23783): Multiple 'Preprocessor Master' pipelines queued up
- [PR 2789](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2789): Added column LakehouseDateProcessed in the view reference_postcode_hash
  - Bug [WI 25847](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25847): Bug in transmitting postcodehash table
  - Task [WI 25855](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25855): Create a Pull Request for the changes

### Release 245

- [PR 2795](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2795): Stop scheduled pipelines from queueing
  - Bug [WI 23783](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23783): Multiple 'Preprocessor Master' pipelines queued up
- [PR 2780](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2780): Removed 'TEMPORARY' comments from transmitter activity
  - Task [WI 25573](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25573): Investigate/resolve

### Release 246

- [PR 2798](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2798): Fix for unknown variable name 'table_names' in transmitter outbox writer function
  - Task [WI 25904](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25904): Task placeholder
- [PR 2796](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2796): Stop scheduled pipelines from queueing
  - Bug [WI 23783](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23783): Multiple 'Preprocessor Master' pipelines queued up
  
### Release 249

- [PR 2783](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2783): Added transmitter 'proxy' table to fix previous workaround for Airlock authorisation/transmission
  - Task [WI 25831](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25831): Missing publications cause airlock subscriber to be ignored
- [PR 2817](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2817): Added tables to store list of all table dependencies back from OLIDS to source supplier tables
  - Task [WI 25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848): Allocator partitioning changes to improve joins/filtering
- [PR 2809](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2809): Fix ReferralRequest mappings
  - Bug [WI 25748](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25748): Organisation ID inconsistencies
  - Task [WI 25958](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25958): fix identified mapping errors
- [PR 2808](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2808): corrected SELECT column ordinal position of LDSConceptId_Source and LDSConcep...
  - Bug [WI 25729](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25729): Procedure request table fields appear to have been mixed up
  - Bug [WI 25778](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25778): Procedure Request source concept id and status concept id the wrong way round
  - Task [WI 25955](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25955): fix
- [PR 2807](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2807): Updated PrimaryCareTPP_SRPersonAtRisk_Flag.sql
  - Bug [WI 25771](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25771): FLAG table has not got the whole flag text
- [PR 2806](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2806): Updated PublisherStatus_PrimaryCareEMIS_DistinctOrganisations.sql
  - Bug [WI 25299](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25299): Receiving data from a practice code "F86644a" in the lake house - Reporting
- [PR 2685](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2685): Split PDS response into Person and PatientPerson
  - User Story [WI 24112](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24112): CDM must be able to create a stub person record when no PDS record exists (at least one patient-person and person record should always exists for each patient_id value)
  - Task [WI 24926](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24926): Continue to iterate development of branch
  - Bug [WI 25835](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25835): LDSIsDeleted is nullable in CDM_masked.Patient
- [PR 2805](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2805): Fix data type mismatch by using COUNT_BIG() instead of COUNT() for variable SourceViewRowCount
  - Bug [WI 26014](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26014): Mismatch by using COUNT_BIG() instead of COUNT() for variable SourceViewRowCount in SPOC
- [PR 2825](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2825): Overlapping Supplier GUID fix
  - User Story [WI 25924](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25924): Overlapping Supplier GUID fix
- [PR 2816](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2816): Updating procedure: CDM_masked.PrimaryCareEMIS_Observation_Process
  - Bug [WI 25911](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25911): Common Model CDM' pipeline failed in 'Execute CDM Process
- [PR 2814](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2814): Added a useful view for finding which tables/views are used by each transform view
  - Task [WI 25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848): Allocator partitioning changes to improve joins/filtering
- [PR 2799](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2799): Removed TODO comment
  - Bug [WI 24913](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24913): RunOutputTableCheck
- [PR 2802](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2802): Sets the Airlock and NCL snowflake endpoints to use XL warehouses in pre-prod
  - Task [WI 24719](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24719): Update environment proc
- [PR 2803](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2803): Changed EMIS Observation to make records primary if they don't have a parent
  - Bug [WI 24949](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24949): diagnostic_order.is_primary is always 0 - incorrect transform for EMIS
  - Bug [WI 25012](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25012): observation.is_primary is always 0 - incorrect transform for EMIS
- [PR 2797](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2797): Fix: Altered Columns_GetNamesWithVarchar - to use object name instead of GUID
  - Bug [WI 24869](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24869): Columns_GetNamesWithVarchar
- [PR 2810](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2810): Correct date casting in OLIDS views
  - User Story [WI 25193](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25193): Patient, Person and Patient Person tables
  - Bug [WI 25830](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25830): Date values in non date type fields
- [PR 2811](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2811): Add PERSON_ID to OLIDS_PCD.PATIENT_ADDRESS
  - Bug [WI 25326](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25326): Disappearance of "person_id" column from LDS_ENGINE_SERVICE_TEST.OLIDS_PCD.PATIENT_ADDRESS
- [PR 2824](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2824): Improved allocation table filtering in transmitter, using table dependencies list from metadata
  - Task [WI 25848](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25848): Allocator partitioning changes to improve joins/filtering
- [PR 2794](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2794): Enrich ExtractGroups Table via Synapse Data Flow Integration
  - User Story [WI 25787](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25787): Automate enrichment of new Extract Groups with data from Configuration database
  - Task [WI 25846](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25846): Create Synapse Solution to Enrich Extract Group fields
- [PR 2781](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2781): Updated Person OLIDS views and changed person_id definition in other OLIDS views
  - Task [WI 25829](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25829): Work on new approach
- [PR 2813](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2813): Adding managedPrivateEndpoint: SnowflakeAirlockPID-pep
  - Task [WI 25934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25934): Attempt Semi-Automated Deployment using Synapse CI/CD and Synapse Workspace Control Plane
- [PR 2841](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2841): Changed count to count_big in EMIS and TPP Person procs.
  - Bug [WI 26137](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26137): Person timeout
- [PR 2835](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2835): Changed test NHS numbers in the Person procedure to varchars.
  - Bug [WI 26122](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26122): Define test patient NHS numbers as VARCHARs
- [PR 2837](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2837): Updating pipeline: FileCombiner ForEach File
  - Bug [WI 26116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26116): FileCombiner has failed

### Release 251

- [PR 2854](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2854): Add PK to Preprocessor_Events table
  - Bug [WI 26116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26116): FileCombiner has failed
- [PR 2844](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2844): use CTAS for person and patient-person CDM procedures
  - User Story [WI 26153](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26153): use CTAS to optimise CDM person transforms
- [PR 2836](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2836): Make LDSBusinessId deterministic
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix
- [PR 2846](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2846): Added objects and procedures to include SRAttendee in the Common Model.
  - User Story [WI 26130](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26130): Set up SRConfiguredListOption and SRAttendee CDM objects and procedures
- [PR 2839](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2839): Added practitioner ID for TPP appointments
  - Bug [WI 24914](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24914): temp fix: PrimaryCareTPP_SRAppointment_Appointment
- [PR 2855](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2855): Updating notebook: column_masker_functions to dev branch
  - No Work Items linked to this PR.
- [PR 2853](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2853): Synapse - NDOO Release
  - No Work Items linked to this PR.
- [PR 2852](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2852): Synapse - NDOO Release
  - No Work Items linked to this PR.
- [PR 2848](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2848): ColumnMasker_Pipeline-to-call-spark-Notebook_Himani to Dev Branch
  - No Work Items linked to this PR.

### Release 252

- [PR 2838](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2838): added table to store spark pool configurations
  - Task [WI 25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849): Parameterise transmitter outbox writer Spark pool config
- [PR 2871](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2871): Change compare
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix
- [PR 2859](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2859): Add missing parameters
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix
- [PR 2864](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2864): Fix for concurrency issue with delta lake table creation in preprocessor
  - Task [WI 26201](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26201): Task placeholder
- [PR 2842](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2842): Parameterised Spark pool settings for transmitter outbox writer notebook
  - Task [WI 25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849): Parameterise transmitter outbox writer Spark pool config
- [PR 2867](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2867): Updating notebook: record_tagging_sflags
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix
- [PR 2849](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2849): Updating notebook: concept_map
  - Task [WI 25962](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25962): fix

### Release 253

- [PR 2875](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2875): Hotfix preprocessor - create staging dependencies fix
  - Bug [WI 26200](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26200): Preprocessor associator staging table error
  - Bug [WI 26225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26225): preprocessor failed: 1ccfbf2e-c2fd-477b-a431-42819362dc8d

### Release 254

- [PR 2877](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2877): hotfix preprocessor - file-warden functions indentation
  - Bug [WI 26200](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26200): Preprocessor associator staging table error
  - Bug [WI 26225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26225): preprocessor failed: 1ccfbf2e-c2fd-477b-a431-42819362dc8d

### Release 255

- [PR 2881](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2881): fix: Record tagging uniqueness fix
  - Bug [WI 26233](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26233): Process ValueSet tags failed: "Cannot perform Merge - multiple matches"
- [PR 2879](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2879): hotfix: sFlag business ID reference fix
  - Bug [WI 26231](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26231): s-flag generation failed

### Release 257

- [PR 2930](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2930): Progress report for ICBs
  - User Story [WI 25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930): Progress report for ICBs
- [PR 2925](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2925): Altered EMIS Transform joins to also match OrganisationGuid
  - Bug [WI 25246](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25246): OLIDS data content: Practice counts variance
- [PR 2927](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2927): Alter PrimaryCareEMIS transforms for EpisodeOfCare
  - Bug [WI 25766](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25766): Missing episode_of_care end dates
  - Bug [WI 25971](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25971): Registration Count Mismatches
- [PR 2873](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2873): Set defaults for LDSIsDeleted for EMIS and TPP
  - Bug [WI 25835](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25835): LDSIsDeleted is nullable in CDM_masked.Patient
- [PR 2916](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2916): Improve monitoring capability
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
- [PR 2907](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2907): Added file counting procedures and logging table for Registrar
  - Bug [WI 26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232): Registrar pipelines fail with no data
- [PR 2908](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2908): Fixed SRRepeatTemplate concept join for MedicationStatement
  - Bug [WI 25737](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25737): Medication statement table has medication names but not codes
- [PR 2890](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2890): Added missing fields to PCD tables
  - Bug [WI 25325](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25325): Disappearance of "registered_practice_id" column from LDS_ENGINE_SERVICE_TEST.OLIDS_PCD.PATIENT
- [PR 2885](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2885): make the select statements for conceptmap and valueset resources distinct, to prevent duplicates caused by concept casing
  - Bug [WI 26230](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26230): Process terminology failed
- [PR 2884](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2884): Updating view: [Monitoring].[vFile_Progress_Summary]
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
- [PR 2901](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2901): Changed concept ID join to cast bigint code as varchar.
  - Bug [WI 25737](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25737): Medication statement table has medication names but not codes
- [PR 2880](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2880): fix version comparison
  - Bug [WI 26230](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26230): Process terminology failed
- [PR 2933](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2933): Progress report for ICBs
  - User Story [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934): LDS data observability
  - User Story [WI 25930](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25930): Progress report for ICBs
- [PR 2903](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2903): Extend dynamic Spark settings logic to Delta Lakehouse pipelines (uses SparkPoolConfiguration)
  - Task [WI 25849](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25849): Parameterise transmitter outbox writer Spark pool config
  - User Story [WI 26279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26279): Enable dynamic Spark configuration for Delta Lakehouse pipelines
  - Task [WI 26280](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26280): Update and validate Delta Lakehouse pipelines
- [PR 2919](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2919): Trim any spaces for columns : StartDate & EndDate in masked_patient_contact & pcd_patient_contact views
  - Bug [WI 26404](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26404): Failed to write to Outbox activity for tables : masked_patient_contact & pcd_patient_contact
- [PR 2896](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2896): Added try/catch for csv reader function to fallback to native CSV reader on failure of custom reader
  - Task [WI 25670](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25670): Troubleshoot
- [PR 2904](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2904): Check that files are present before running Registrar Response pipeline
  - Bug [WI 26232](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26232): Registrar pipelines fail with no data
- [PR 2891](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2891): hotfix - correct errors in OLIDS notebook definitions
  - Bug [WI 26257](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26257): Transmitter failed on OLIDS view generation (runID: 5590e407-c367-4326-8c34-42c93faf8435)
- [PR 2926](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2926): Add this to my branch - Himani 
  - No Work Items linked to this PR.