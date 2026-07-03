# Release 277

- [Release 277](#release-277)
  - [Summary](#summary)
  - [✨ New Features](#%E2%9C%A8-new-features)
  - [🎯 Improvements](#%F0%9F%8E%AF-improvements)
  - [🐞 Bug Fixes](#%F0%9F%90%9E-bug-fixes)
  - [♻️ Refactoring](#%E2%99%BB%EF%B8%8F-refactoring)
  - [ℹ️ Inputs](#%E2%84%B9%EF%B8%8F-inputs)
  - [ℹ️ Full Details](#%E2%84%B9%EF%B8%8F-full-details)

> The below is a summary of the changes since the previous release [Release-263](Release-263.md).

- *Release Date to consumers: 2026-01-27*  
- *Release Range: Release-263 to Release-277*

## Summary

This release introduces new capabilities for:

- metadata comparison
- optimises file registration
- enhances datapoint generation for testing
- data monitoring reporting
- performance, and operational stability
- Local Data Opt-Out (LDOO) ingestion
- introduction of CETAS Exporter and Deltalake Loader services for exporting and loading data between the dedicated pool and Delta Lake

Several performance improvements and bug fixes have been delivered, particularly for:

- data transformation
- data versioning processes
- data transmission
- resilience in data allocation workflows
- issues related to the Quality and Outcomes Framework (QoF) datapoints
- data accuracy by addressing duplication and mergers
- TPP Common Model transform optimisations and bug fixes to correct duplications

Numerous bug fixes and refinements ensure greater data accuracy, consistency, and maintainability.

## ✨ New Features

- Added a new view and pipeline to compare metadata configuration files, enabling users to easily identify changes between exported data files. *[SQL, [PR#3017](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3017), [WI#22727](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22727), [WI#25229](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25229)]*  
  > ✨ **Feature:** Users can now compare metadata files directly, making it easier to track and audit changes.

- Introduced a new pipeline for comparing metadata config files within the Synapse workspace, providing a visual and automated way to review file changes. *[SynapseWorkspace, [PR#2957](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2957), [WI#22727](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22727), [WI#25229](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25229)]*  
  > ✨ **Feature:** Automated metadata file comparison improves transparency and supports data governance.

- Added functionality for generating datapoints, including QOF datapoints for testing, and expanded tagging tables to include patient identifiers. *[SynapseWorkspace, [PR#3018](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3018), [WI#26710](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26710)]*  
  > ✨ **Feature:** Enables richer data analysis and supports new testing scenarios for clinical metrics.

- Introduced File Forager, a tool that periodically gathers files from other datalakes and copies them to the LDS Datalake. *[SQL, [PR#3045](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3045), [WI#26879](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26879)]*  
  > ✨ ***Feature:*** Enables seamless integration of external data sources for broader analytics.

- Added metadata tables and logging procedures to support operational tracking for Local Data Opt-Out (LDOO) ingestion. *[SQL, [PR#3089](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3089), [WI#26691](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26691)]*  
  > ✨ ***Feature:*** Improves event logging and management for opt-out processing.

- Implemented a complete ingestion pipeline for LDOO, including new views and a generalised opt-out framework. *[SynapseWorkspace, [PR#3088](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3088), [WI#25223](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25223), [WI#25225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25225), [WI#25228](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25228)]*  
  > ✨ ***Feature:*** Provides consistent, configuration-driven opt-out processing for multiple datasets.

- Added a utility pipeline for exporting data using CETAS and loading it into Delta Lake for several key tables. *[SynapseWorkspace, [PR#3166](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3166), [WI#27244](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27244)]*  
  > ✨ ***Feature:*** Enables flexible, on-demand data exports and seamless integration with data lakes for broader data accessibility

- Added CETAS Exporter and Deltalake Loader services to support efficient data export from SQL pools and loading into Deltalake, with orchestration pipelines and notebooks for managing these processes. *[SQL, [PR#3179](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3179), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552), [WI#26567](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26567), [WI#26692](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26692), [WI#26693](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26693), [WI#26695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26695), [WI#26696](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26696)]*  
  > ✨ ***Feature:*** Enables automated, scalable export and import of large datasets, improving data movement and integration.

- Introduced orchestration pipelines and notebooks for CETAS Exporter and Deltalake Loader, including dispatch and group/table level orchestration. *[SynapseWorkspace, [PR#3178](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3178), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552), [WI#26567](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26567), [WI#26694](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26694), [WI#26697](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26697), [WI#26698](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26698)]*  
  > ✨ ***Feature:*** Provides flexible orchestration for complex data export and loading workflows.

- Added a referential integrity test to the transmitter pipeline to verify data consistency after transmission. *[SynapseWorkspace, [PR#3165](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3165), [WI#26689](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26689), [WI#27231](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27231)]*  
  > ✨ ***Feature:*** Helps ensure data relationships remain intact during transfers, improving trust in data outputs.

- Added options to the common-model pipeline for exporting data via CETAS and loading it into Delta Lake, with new configuration switches for greater control. *[SQL, [PR#3183](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3183), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552)]*  
  > ✨ ***Feature:*** Users can now choose to export data and import it into Delta Lake, enabling more flexible and efficient data workflows.

- Integrated CETAS exporter and Delta Lake loader into the common-model pipeline, updating orchestration and configuration for streamlined data movement. *[SynapseWorkspace, [PR#3184](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3184), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552)]*  
  > ✨ ***Feature:*** The platform can now automate data exports and imports, reducing manual steps and supporting larger-scale data operations

## 🎯 Improvements

- Optimised the file register process by allowing bulk insertion of file metadata using JSON arrays, reducing the number of operations and improving efficiency. *[SQL, [PR#2988](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2988), [WI#26611](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26611), [WI#26612](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26612)]*  
  > 🎯 **Impact:** Faster and more scalable file registration for large data sets.

- Added a new pipeline mode for registering files in bulk via JSON, streamlining file metadata handling in Synapse. *[SynapseWorkspace, [PR#2989](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2989), [WI#26611](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26611)]*  
  > 🎯 **Impact:** Reduces manual steps and enhances throughput for file registration.

- Refactored Common Model transforms to use CTAS tables, improving merge performance and reliability when loading data into the Common Data Model. *[SQL, [PR#3024](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3024), [WI#26703](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26703)]*  
  > 🎯 **Impact:** Accelerates data processing and reduces resource usage.

- Expanded monitoring reports with new views, columns, and file size information for more detailed progress tracking. *[SQL, [PR#3075](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3075), [WI#26805](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26805), [WI#27008](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27008)]*  
  > 🎯 ***Impact:*** Enables users to better track batch types and file integrity.

- Improved monitoring reports by synchronising extract groups before refreshing, ensuring more accurate reporting. *[SQL, [PR#3107](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3107), [WI#27032](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27032)]*  
  > 🎯 ***Impact:*** Reduces missing or incomplete customer information in reports.

- Added allocator maintenance tracking and gated Delta OPTIMIZE operations to support periodic performance improvements. *[SQL, [PR#3113](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3113), [WI#27047](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27047), [WI#27056](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27056)]*  
  > 🎯 ***Impact:*** Reduces file fragmentation and improves pipeline execution times.

- Updated Allocator pipeline to dynamically determine Spark configuration from metadata, allowing centralised and flexible resource management. *[SynapseWorkspace, [PR#3110](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3110), [WI#27047](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27047), [WI#27054](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27054)]*  
  > 🎯 ***Impact:*** Makes scaling and tuning easier without redeployment.

- Enabled parallel transmission of datasets to multiple endpoints, speeding up delivery to subscribers. *[SQL, [PR#3077](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3077), [WI#26921](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26921)]; SynapseWorkspace, [PR#2980](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2980), [WI#26921](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26921)]*  
  > 🎯 ***Impact:*** Significantly reduces time to deliver data to multiple partners.

- Automatically populates CreatedBy and UpdatedBy columns in key tables, ensuring audit trails are complete and consistent. *[SQL, [PR#3031](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3031), [WI#26792](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26792)]*  
  > 🎯 ***Impact:*** Improves data governance and traceability.

- Added new batch progress metrics and renamed monitoring columns for clearer insights into data loads. *[SynapseWorkspace, [PR#3094](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3094), [WI#27021](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27021), [WI#27022](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27022)]*  
  > 🎯 ***Impact:*** Offers more granular visibility into batch processing.

- Updated monitoring pipelines and views to support new columns and improved progress tracking. *[SynapseWorkspace, [PR#3079](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3079), [WI#26805](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26805), [WI#27008](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27008)]*  
  > 🎯 ***Impact:*** Enhances monitoring for operational teams.

- Enhanced processing speed and reduced duplication for TPP Observation data, resulting in faster and more accurate data handling. *[SQL, [PR#3141](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3141), [WI#27113](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27113)]*  
  > 🎯 ***Impact:*** Improves efficiency and reliability of observation data processing.

- Optimised performance for TPP MedicationStatement processing, including materialising underlying tables and updating views. *[SQL, [PR#3140](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3140), [WI#27126](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27126)]*  
  > 🎯 ***Impact:*** Accelerates medication statement workflows and reduces processing time.

- Improved performance and structure for TPP MedicationOrder processing, with materialised tables and priority context settings. *[SQL, [PR#3138](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3138), [WI#27103](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27103)]*  
  > 🎯 ***Impact:*** Ensures faster and more reliable medication order data processing.

- Increased resilience in allocator CDF processing by removing dependency on enablement version and handling metadata more robustly. *[SynapseWorkspace, [PR#3132](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3132), [WI#27092](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27092)]*  
  > 🎯 ***Impact:*** Allocator runs reliably even during table rebuilds or history changes, reducing risk of missed allocations.

- Storage account selection for Opt-Out processes is now parameter-driven, streamlining pipeline configuration and removing redundant folders. *[SynapseWorkspace, [PR#3145](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3145), [WI#26717](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26717)]*  
  > 🎯 ***Impact:*** Simplifies opt-out data management and improves maintainability.

- Minor fixes to EMIS ReferralRequest process, including corrected table naming and column settings. *[SQL, [PR#3134](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3134), [WI#27123](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27123)]*  
  > 🎯 ***Impact:*** Enhances data accuracy and consistency in referral requests.

- Updates for SRCcg, SRTrust, SROrgansation and related objects to improve common model performance and reliability. *[SQL, [PR#3143](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3143), [WI#27134](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27134)]*  
  > 🎯 ***Impact:*** Ensures more accurate and efficient organisation and trust data handling.

- Practitioner data processing in TPP models optimised for speed and reliability. *[SQL, [PR#3142](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3142), [WI#27129](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27129)]*  
  > 🎯 ***Impact:*** Improves practitioner data workflows and reduces errors.

- Enhanced TPP Common Model by adding missing organisation joins and updating join clauses for greater consistency. *[SQL, [PR#3157](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3157), [WI#27217](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27217)]*  
  > 🎯 ***Impact:*** Improves data linkage and ensures more accurate organisational relationships in transformation views.

- Implemented quick optimisation fixes for TPP transformation views by removing duplicate records and preventing cross joins. *[SQL, [PR#3152](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3152), [WI#27112](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27112)]*  
  > 🎯 ***Impact:*** Enhances query performance and data quality, leading to faster and more reliable processing.

- Updated the Transmitter monitoring view logic by renaming and removing columns to better reflect current data processing steps. *[SynapseWorkspace, [PR#3153](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3153), [WI#27141](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27141), [WI#27142](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27142)]*  
  > 🎯 ***Impact:*** Provides clearer and more relevant monitoring information, helping users track data processing more effectively.

- Enhanced batch progress summary view to accurately show versioner activity and include batches missing SRPatient files, improving monitoring coverage. *[SQL, [PR#3170](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3170), [WI#27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138), [WI#27245](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27245)]*  
  > 🎯 ***Impact:*** Delivers more complete and accurate operational insights for data processing teams.

- Orchestrated datapoint execution with hierarchical structure and parallel processing, making datapoint management more efficient. *[SynapseWorkspace, [PR#3163](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3163), [WI#26712](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26712)]*  
  > 🎯 ***Impact:*** Improves the speed and flexibility of data point execution, supporting faster data delivery.

- Added vectorized scanner to the copy inserts to snowflake activity, optimizing data loading performance to Snowflake. *[SynapseWorkspace, [PR#3180](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3180), [WI#27314](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27314)]*  
  > 🎯 ***Impact:*** Significantly boosts data transfer speeds, reducing wait times for large data loads.

- Merged master branch into the CETAS export/import feature branch to leverage updated dispatch utilities for pipeline management. *[SynapseWorkspace, [PR#3038](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3038)]*  
  > 🎯 ***Impact:*** Ensures feature branches benefit from latest improvements and utilities, supporting smoother development and deployment.

- Updated the column definition for 'NationalSlotCategoryDescription' in Appointment_Slot tables, increasing the size to support longer descriptions. *[SQL, [PR#3182](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3182), [WI#27304](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27304), [WI#27305](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27305), [WI#27322](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27322)]*  
  > 🎯 ***Impact:*** Prevents data truncation errors and allows for more detailed slot category information.

## 🐞 Bug Fixes

- Fixed failures in Common Model stored procedures and improved performance of Observation and Referral Request transforms to prevent tempdb errors. *[SQL, [PR#3027](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3027), [WI#26769](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26769), [WI#26771](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26771)]*  
  > 🐞 **Fix:** Resolves errors and ensures more stable data transformations.

- Corrected versioner logic to properly prioritise CDM tables during batch processing, ensuring accurate data handling. *[SQL, [PR#3020](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3020), [WI#26704](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26704)]*  
  > 🐞 **Fix:** Improves reliability of table processing order for versioning.

- Fixed an issue where versioner failed to stage due to a character limit in string aggregation, allowing larger lists of folders to be processed. *[SQL, [PR#3021](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3021), [WI#26706](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26706)]*  
  > 🐞 **Fix:** Prevents staging errors for large data batches.

- Resolved recursion limit errors in the procedure for retrieving maximum batch size in versioner, switching to a more robust calculation method. *[SQL, [PR#3023](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3023), [WI#26751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26751), [WI#26752](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26752)]*  
  > 🐞 **Fix:** Ensures versioner can handle large queues without failing.

- Fixed bug where only one dataset type was dispatched by the versioner dispatcher, ensuring all queued datasets are processed. *[SynapseWorkspace, [PR#3025](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3025), [WI#26770](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26770)]*  
  > 🐞 **Fix:** Guarantees all data types are dispatched as intended.

- Updated logic to prevent NULL values in the 'IsDummyPatient' field, fixing data load errors in patient processing. *[SQL, [PR#3022](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3022), [WI#26743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26743), [WI#26744](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26744)]*  
  > 🐞 **Fix:** Improves data integrity and prevents load failures

- Resolved performance issues in stored procedures by optimising JSON handling, preventing timeouts and speeding up valueset loading. *[SQL, [PR#3127](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3127), [WI#27083](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27083)]*  
  > 🐞 ***Fix:*** Improves reliability and efficiency during data processing.

- Fixed timeout and performance problems in TPP patient registration processes, ensuring successful data loads. *[SQL, [PR#3118](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3118), [WI#27055](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27055), [WI#27058](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27058)]*  
  > 🐞 ***Fix:*** Prevents missing data due to process failures.

- Corrected data type inconsistencies between NVARCHAR and VARCHAR, stopping duplicate concept IDs and ensuring consistent hashing. *[SQL, [PR#3108](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3108), [PR#3122](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3122), [PR#3039](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3039), [WI#27023](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27023), [WI#26804](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26804)]*  
  > 🐞 ***Fix:*** Ensures unique and accurate concept identifiers.

- Fixed issue where extra slashes in code system URLs caused duplicate concept IDs in TPP transforms. *[SQL, [PR#3104](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3104), [WI#27024](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27024)]*  
  > 🐞 ***Fix:*** Prevents data duplication and improves code mapping accuracy.

- Addressed failures in preprocessor pipelines by ensuring default constraints are named and null values are handled correctly. *[SQL, [PR#3102](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3102), [WI#27037](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27037)]*  
  > 🐞 ***Fix:*** Reduces pipeline errors and improves stability.

- Nullified large JSON columns in preprocessor events to prevent metadata size quota issues. *[SQL, [PR#3076](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3076), [PR#3042](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3042), [WI#26867](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26867)]*  
  > 🐞 ***Fix:*** Prevents system failures due to oversized metadata.

- Ensured non-nullable patient fields always have default values, preventing CDM failures. *[SQL, [PR#3084](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3084), [WI#27060](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27060)]*  
  > 🐞 ***Fix:*** Guarantees data completeness in patient records.

- Fixed TransmitFlag column values and related monitoring pipeline issues for accurate batch status reporting. *[SQL, [PR#3098](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3098), [SynapseWorkspace, [PR#3099](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3099), [PR#3103](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3103), [WI#26808](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26808)]*  
  > 🐞 ***Fix:*** Ensures users see correct transmission statuses.

- Corrected spelling errors and removed unused columns in PERSON table notebooks for schema accuracy. *[SynapseWorkspace, [PR#3091](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3091), [WI#26749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26749); [PR#3101](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3101), [WI#26252](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26252), [WI#26572](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26572)]*  
  > 🐞 ***Fix:*** Improves data quality and reduces errors in downstream processes.

- Fixed log_datetime datatype mismatch in CompareTableCounts pipeline, resolving failures during table count comparisons. *[SynapseWorkspace, [PR#3092](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3092), [WI#27014](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27014), [WI#27016](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27016)]*  
  > 🐞 ***Fix:*** Ensures smooth pipeline execution and accurate logging.

- Addressed row count comparison logic and pipeline dependency errors in Transmitter, improving reliability of success marking and error handling. *[SynapseWorkspace, [PR#3068](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3068), [WI#26923](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26923); [PR#3040](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3040), [WI#26768](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26768), [WI#26871](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26871)]*  
  > 🐞 ***Fix:*** Prevents pipeline failures and improves operational monitoring.

- Fixed dependency errors in preprocessor master pipeline for correct association notebook merging. *[SynapseWorkspace, [PR#3037](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3037), [WI#27061](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27061)]*  
  > 🐞 ***Fix:*** Improves pipeline stability and data merging accuracy.

- Stabilised Transmitter outbox writes by capping Spark partitions and isolating temporary output, reducing small file generation and write failures. *[SynapseWorkspace, [PR#3119](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3119), [WI#27010](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27010), [WI#27069](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27069)]*  
  > 🐞 ***Fix:*** Prevents intermittent failures and improves data export reliability.

- Fixed duplicate content registration in FileRegister, ensuring files are correctly registered and processed. *[SQL, [PR#3135](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3135), [WI#27098](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27098)]*  
  > 🐞 ***Fix:*** Prevents duplicate file entries and improves data integrity.

- Allowed null values in DateExtractTo column to resolve pipeline failures in batch progress monitoring. *[SQL, [PR#3131](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3131), [WI#27090](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27090)]*  
  > 🐞 ***Fix:*** Ensures pipelines run smoothly even when some date fields are missing.

- Fixed indentation errors in transmitter functions notebook, resolving outbox write failures. *[SynapseWorkspace, [PR#3133](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3133), [WI#27094](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27094), [WI#27095](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27095)]*  
  > 🐞 ***Fix:*** Prevents errors during transmitter operations and ensures data is sent correctly.

- Removed an accidental debugging cell from the Allocator notebook to prevent pipeline failures. *[SynapseWorkspace, [PR#3144](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3144), [WI#26740](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26740)]*  
  > 🐞 ***Fix:*** Restores normal allocator pipeline operation.

- Added resume and pause steps for the CommonModel database in row count comparison pipelines to prevent failures during scheduled runs. *[SynapseWorkspace, [PR#3136](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3136), [WI#27030](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27030), [WI#27097](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27097), [WI#27107](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27107)]*  
  > 🐞 ***Fix:*** Prevents pipeline failures due to database pausing during critical operations

- Fixed multiple issues affecting QoF datapoints, including resolving duplication and merge errors, ensuring all relevant notebooks are included, and centralizing storage account configuration for easier management. *[SynapseWorkspace, [PR#3154](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3154), [WI#26712](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26712)]*  
  > 🐞 ***Fix:*** These corrections improve data processing reliability and help maintain consistent and accurate QoF metrics across the platform.

- Applied targeted fixes to the TPP Appointment model to resolve data inconsistencies and improve reliability. *[SQL, [PR#3156](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3156), [WI#27140](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27140)]*  
  > 🐞 ***Fix:*** Ensures appointment data is correctly processed and linked, reducing errors in downstream usage.

- Fixed the Batch Progress Summary view to correctly show batches that are currently in progress and resolved issues in the common model failures view. *[SQL, [PR#3167](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3167), [WI#27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138)]*  
  > 🐞 ***Fix:*** Ensures monitoring dashboards accurately reflect real-time activity, improving operational oversight.

- Updated the Batch Progress Summary view to return results after the removal of the FileCombiner component and split the CommonModel monitoring into Load and Transform versions. *[SQL, [PR#3151](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3151), [WI#27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138)]*  
  > 🐞 ***Fix:*** Restores accurate monitoring for recent batches and aligns views with current data processing workflows.

- Fixed rare issue in the Versioner process to allow data passthrough when needed, preventing unnecessary data suppression. *[SQL, [PR#3172](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3172), [WI#27279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27279)]*  
  > 🐞 ***Fix:*** Ensures all required data is available for reruns, improving data completeness.

- Corrected logic in batch progress monitoring to show in-progress batches and include missing directories. *[SQL, [PR#3170](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3170), [WI#27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138), [WI#27245](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27245)]*  
  > 🐞 ***Fix:*** Users now see a full and accurate picture of batch status, reducing confusion and manual checks.

- Fixed issue where vectorized scanning was not applied during Snowflake data loads, improving performance and reliability. *[SynapseWorkspace, [PR#3180](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3180), [WI#27314](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27314)]*  
  > 🐞 ***Fix:*** Data loads to Snowflake now use optimal settings, resulting in faster and more reliable transfers

- Applied a minor fix to the default constraint on the CDM configuration table to resolve deployment errors and ensure smooth table updates. *[SQL, [PR#3186](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3186), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552)]*  
  > 🐞 ***Fix:*** Fixes issues that could block table changes, improving reliability for configuration management.

- Corrected a trigger connection in the common-model pipeline to point to the correct pipeline after a previous one was deleted. *[SynapseWorkspace, [PR#3187](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3187), [WI#26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552)]*  
  > 🐞 ***Fix:*** Ensures automated tasks run as expected, preventing missed or failed data updates.

## ♻️ Refactoring

- Refactored Common Model transforms and views to improve performance and maintainability, including updates to CDM transform logic and handling for Observation and Referral Request tables. *[SQL, [PR#3027](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3027), [WI#26769](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26769), [WI#26771](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26771)]*  
  > ♻️ **Refactor:** Streamlines code and reduces risk of errors in large data loads.

- Continued refactoring of Common Model transform processes, updating views and procedures to use more efficient table creation and distribution methods. *[SQL, [PR#3024](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3024), [WI#26703](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26703)]*  
  > ♻️ **Refactor:** Enhances maintainability and consistency of data transformation logic.

- Refactored EMIS ReferralRequest process to use a multi-stage approach for improved performance and maintainability. *[SQL, [PR#3117](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3117), [WI#27011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27011)]*  
  > ♻️ ***Refactor:*** Makes large data transformations more efficient and easier to update.

- Updated CDM transformation views and concept lookup logic for standardised age calculations and better performance. *[SQL, [PR#3060](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3060), [PR#3126](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3126), [PR#3032](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3032), [WI#25742](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25742), [WI#26534](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26534)]*  
  > ♻️ ***Refactor:*** Ensures consistent logic and faster data processing.

- Generalised opt-out ingestion framework to support both National and Local Data Opt-Out datasets, improving reusability. *[SynapseWorkspace, [PR#3088](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3088), [WI#25223](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25223)]*  
  > ♻️ ***Refactor:*** Simplifies future expansion and maintenance of opt-out processing.

- Made versioner event inserts idempotent and raw staged event IDs deterministic, ensuring consistent logging and easier reruns. *[SQL, [PR#3051](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3051), [WI#26887](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26887), [WI#26888](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26888), [WI#26889](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26889)]*  
  > ♻️ ***Refactor:*** Improves operational reliability and traceability for versioned data runs.

- Updated pipelines and notebooks for improved configuration management, parallelism, and error handling. *[SynapseWorkspace, [PR#3030](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3030), [WI#26710](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26710)]*  
  > ♻️ ***Refactor:*** Enhances maintainability and future scalability.

- Synced feature branch with latest changes from master to maintain code consistency and up-to-date functionality. *[SynapseWorkspace, [PR#3159](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3159)]*  
  > ♻️ ***Refactor:*** Keeps development branches aligned for easier collaboration and future updates.

- Refactored CETAS exporter and Deltalake Loader backend objects, interactions, and orchestration for improved maintainability and clarity. *[SQL, [PR#3179](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3179), [WI#26692](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26692), [WI#26693](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26693), [WI#26695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26695), [WI#26696](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26696)]*  
  > ♻️ ***Refactor:*** Streamlines internal structures, making future updates and troubleshooting easier.

- Updated orchestration pipelines and notebooks for CETAS and Deltalake Loader, consolidating configuration and logic for consistency. *[SynapseWorkspace, [PR#3178](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3178), [WI#26694](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26694), [WI#26697](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26697), [WI#26698](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26698)]*  
  > ♻️ ***Refactor:*** Enhances codebase consistency and reduces duplication, supporting easier maintenance and scalability.
---

## ℹ️ Inputs

This change note was automatically produced from:

- 96 Pull Requests
- 132 Work Items
- 1,411 Commits

## ℹ️ Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:

- [PR 3027](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3027): Common Model Refactor - Wave 2 updates plus Observation  & Observation RR Patch
  - Bug [WI 26769](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26769): CDM Transform Failure - [CDM_pcd].[PrimaryCareEMIS_Patient_Process]
  - Task [WI 26771](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26771): CDM Observation Patch
- [PR 2988](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2988): Added FileRegister_InsertEventsBulk.sql
  - User Story [WI 26611](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26611): optimise file-register insert event using json array
  - Task [WI 26612](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26612): create stored procedure
- [PR 3024](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3024): refactor_commonmodel_transforms - Part 2
  - Task [WI 26703](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26703): CommonModel Refactor Transforms to use CTAS - Wave 2
- [PR 3017](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3017): Metadata - Compare metadata config files
  - User Story [WI 22727](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22727): New metadata view
  - Task [WI 25229](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25229): Quick review of the implementation and test
- [PR 3020](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3020): hotfix - versioner cdm prioritisation - get_tables_to_process_for_batch.sql
  - Bug [WI 26704](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26704): minor bug: versioner not correctly prioritising CDM tables
- [PR 3021](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3021): hotfix - versioner cast string_agg to varchar max
  - Bug [WI 26706](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26706): versioner failed to stage due to 8000 character limit in string_agg
- [PR 3023](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3023): hotfix - versioner get max batch size
  - Bug [WI 26751](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26751): versioner_process_dataset failure: 53f6c8f6-2797-4a87-b5b6-e1d3899925f6 - get max batch size recursion limit reached
  - Task [WI 26752](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26752): raise patch fix altered windowed function fix
- [PR 3022](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3022): Updated `IsDummyPatient` to use `ISNULL` for defaulting `NULL` values to `0`.
  - Bug [WI 26743](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26743): Cannot insert the value NULL into column 'IsDummyPatient' in "[CDM_pcd].[PrimaryCareTPP_Patient_Process]"
  - Task [WI 26744](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26744): Cannot insert the value NULL into column 'IsDummyPatient' in "[CDM_pcd].[PrimaryCareTPP_Patient_Process]"
- [PR 2957](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2957): compare metadata config files
  - User Story [WI 22727](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22727): New metadata view
  - Task [WI 25229](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25229): Quick review of the implementation and test
- [PR 2989](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2989): add file_register_folder_json pipeline
  - User Story [WI 26611](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26611): optimise file-register insert event using json array
- [PR 3025](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3025): fix versioner_dispatcher - remove set variable
  - Bug [WI 26770](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26770): versioner dispatcher only dispatched one dataset - even though two were queued
- [PR 3018](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3018): Add Datapoint code (qof, efi), change tagging tables to include patient id/sk patient id
  - User Story [WI 26710](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26710): Get QOF out for testing
- [PR 3124](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3124): Improve Monitoring Report
  - User Story [WI 27077](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27077): Convert ExtractDateTime from string to date
- [PR 3126](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3126): CDM - Update TPP Transform_Masked views to use [Utility].[GetAgeAtEventColumns] TVF
  - User Story [WI 25742](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25742): age_at_event_baby - Null Adult Ages
- [PR 3127](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3127): fix performance issue, caused by reading the full JSON object for every row
  - Task [WI 27083](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27083): Look at performance issues with Valuesets
- [PR 3118](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3118): SQL - PrimaryCareTPP_PatientRegisteredPractitionerInRole_Process Performance Fix
  - Bug [WI 27055](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27055): PrimaryCareTPP_PatientRegisteredPractitionerInRole_Process Time Out
  - Task [WI 27058](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27058): Create Updated Objects and test performance
- [PR 3122](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3122): Change system from NVARCHAR to VARCHAR
  - Bug [WI 27023](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27023): Deterministic ConceptID generation is still using a mix of NVARCHAR and VARCHAR
- [PR 3089](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3089): Add LDOO Metadata Tables and Logging Stored Procedures
  - Task [WI 26691](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26691): Create LDOO Metadata Config
- [PR 3117](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3117): Draft: feature/Optimise_EMIS_ReferralRequest_Process
  - Bug [WI 27011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27011): Transform Timeout: EMIS to ReferralRequest
- [PR 3107](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3107): Improve Monitoring report
  - User Story [WI 27032](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27032): Sync [Configuration].[ExtractGroups] before refreshing monitoring report
- [PR 3104](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3104): Remove extra slash from Code System used by TPP transforms
  - Bug [WI 27024](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27024): Code System used by TPP transforms includes extras slash >> Results in two conceptIDs for the same Code value
- [PR 3108](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3108): Change system from NVARCHAR to VARCHAR
  - Bug [WI 27023](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27023): Deterministic ConceptID generation is still using a mix of NVARCHAR and VARCHAR
- [PR 3113](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3113): Add allocator maintenance tracking to support periodic Delta OPTIMIZE
  - User Story [WI 27047](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27047): Allocator needs more executors
  - Task [WI 27056](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27056): Add interval-based optimization for Allocator
- [PR 3051](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3051): Fix Versioner Event Inserts and Make raw_staged_event_id Deterministic
  - Bug [WI 26887](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26887): Versioner process fails with PK violations and generates non-repeatable staged event IDs
  - Task [WI 26888](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26888): Add idempotent insert logic for [LDS].[Versioner_Events] writes
  - Task [WI 26889](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26889): Make raw_staged_event_id deterministic per table + batch
- [PR 3077](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3077): Transmitter:  Updated SPOC to add 'endpointID={EndPointId}' to the write to outbox activity
  - User Story [WI 26921](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26921): Transmitter feature: Transmit Parallelly to Endpoints
- [PR 3084](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3084): fix CDM transforms for patient - non-nullable fields IsConfidential IsDummyPatient
  - Bug [WI 27060](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27060): CDM Failures due to non-nullable fields (isconfidential isdummypatient)
- [PR 3098](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3098): Fix TransmitFlag column
  - User Story [WI 26808](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26808): Fix TransmitFlag column
- [PR 3102](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3102): Updating table: Preprocessor_Events
  - Bug [WI 27037](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27037): Preprocessor pipeline failed
- [PR 3075](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3075): Expand Monitoring report
  - User Story [WI 26805](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26805): Expand Monitoring report
  - User Story [WI 27008](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27008): Add contentMD5 to FileRegister
- [PR 3076](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3076): Nullify ValidationDataSetSpecificationJSON column
  - Bug [WI 26867](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26867): P1 BUG: Metadata has reached size quota
- [PR 3060](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3060): SQL - Common Model - Transformation Updates for AgeAtEvent and Performance Update for Concept Lookups
  - User Story [WI 25742](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25742): age_at_event_baby - Null Adult Ages
- [PR 3062](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3062): New pipeline to correct status
  - User Story [WI 26409](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26409): New pipeline to correct status
- [PR 3045](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3045): FileForager SQL
  - Task [WI 26879](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26879): Create FileForager to gather files from other datalakes
- [PR 3031](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3031): Automatically populate CreatedBy and UpdatedBy columns
  - User Story [WI 26792](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26792): Automatically populate CreatedBy and UpdatedBy columns
- [PR 3039](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3039): Duplicate Concepts in Terminology.Concepts
  - Bug [WI 26804](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26804): Duplicate Concepts in Terminology.Concepts
- [PR 3032](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3032): CDM Observation Optimisations Part 2 
  - User Story [WI 26534](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26534): CDM Performance Optimisation
- [PR 3042](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3042): Nullify triggerJSON column
  - Bug [WI 26867](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26867): P1 BUG: Metadata has reached size quota
- [PR 3119](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3119): Stabilise Transmitter outbox writes by capping partitions and isolating temp output
  - Bug [WI 27010](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27010): Transmitter write to outbox intermittent failure
  - Task [WI 27069](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27069): Stabilise Transmitter outbox parquet writes for large exports
- [PR 3106](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3106): Improve Monitoring report
  - User Story [WI 27032](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27032): Sync [Configuration].[ExtractGroups] before refreshing monitoring report
- [PR 3114](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3114): Add gated Delta OPTIMIZE to Allocator notebook
  - User Story [WI 27047](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27047): Allocator needs more executors
  - Task [WI 27056](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27056): Add interval-based optimization for Allocator
- [PR 3110](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3110): Updates Allocator Pipeline to dynamically determine Spark Config
  - User Story [WI 27047](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27047): Allocator needs more executors
  - Task [WI 27054](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27054): Alter Allocator Pipeline to use config table for spark config
- [PR 3105](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3105): Enable Snowflake Vectorized Parquet Scanner for COPY Performance Optimization
  - User Story [WI 27046](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27046): Add use_vectorized_scan to the copy activity
  - Task [WI 27048](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27048): Review and identify the ADF Pipeline to make changes.
  - Task [WI 27049](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27049): Apply changes to the ADF Pipeline
- [PR 3103](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3103): Updating trigger: schedule_monitoring
  - User Story [WI 26808](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26808): Fix TransmitFlag column
- [PR 3100](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3100): Renamed CommonModel_LastTransmit to LastTransmit in MONITORING_LDS_RELEASE_DETAILS Transmitter View
  - User Story [WI 27021](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27021): Update Transmitter Monitoring Views for new columns
  - Task [WI 27029](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27029): Update monitoring view: Monitoring_LDS_Release_Details
- [PR 3037](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3037): fix preprocessor master - correcting dependency to merge association notebook
  - Bug [WI 27061](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27061): fix preprocessor master - correcting dependency to merge association notebook
- [PR 3092](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3092): Fix log_datetime datatype mismatch causing CompareTableCounts pipeline failures
  - Bug [WI 27014](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27014): log_datetime Type failure in [vTransmitter_Table_Counts] transmittor pipeline
  - Task [WI 27016](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27016): Fix Data Type Mismatch
- [PR 3088](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3088): Add Local Data Opt-Out (LDOO) Ingestion & Generalise Opt-Out Framework
  - Task [WI 25223](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25223): Create notebook: LDOO preprocess
  - Task [WI 25225](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25225): Create notebook: LDOO versioning / datapoint generation
  - Task [WI 25228](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25228): Create LDOO executor pipeline
- [PR 3068](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3068): hotfix_bug26923_for_compare_row_count_transmitter
  - Bug [WI 26923](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26923): Transmitter row count fail: Could not use view or function 'OLIDS_masked.v_patient_uprn' because of binding errors.,},],'",
- [PR 3040](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3040): hotfix: BUG-26768 – Align row count comparison logic in Transmitter pipeline
  - Bug [WI 26768](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26768): Transmitter Count failed in Pre-prod
  - Task [WI 26871](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26871): Add new step -Import Monitoring_vTransmitter_Table_Counts to Metadata DB
- [PR 3091](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3091): Updated pcd_person.json - corrected column alias typo
  - Bug [WI 26749](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26749): Spelling error in PERSON table
- [PR 3101](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3101): Bug26252: Remove LDS_REGISTRAR_EVENT_ID column from masked_person and pcd_person notebooks
  - Bug [WI 26252](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26252): Registrar_event_ID is missing from Person CDM table
  - Task [WI 26572](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26572): Investigate/Resolve
- [PR 2980](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2980): Transmitter:  Transmit Dataset To Subscribers parallelly for multiple endpoints
  - User Story [WI 26921](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26921): Transmitter feature: Transmit Parallelly to Endpoints
- [PR 3030](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3030): Updating pipeline: DeltaLakehouse SFlag Tag Generator
  - User Story [WI 26710](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26710): Get QOF out for testing
- [PR 3099](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3099): Fix TransmitFlag column
  - User Story [WI 26808](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26808): Fix TransmitFlag column
- [PR 3094](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3094): Add 5 NEW Columns and rename FirstLoadFlag to FirstSeenFlag in Monitoring Batch Progress Summary Transmitter View
  - User Story [WI 27021](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27021): Update Transmitter Monitoring Views for new columns
  - Task [WI 27022](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27022): Update monitoring view: Monitoring_Batch_Progress_Summary
- [PR 3079](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3079): Expand Monitoring report
  - User Story [WI 26805](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26805): Expand Monitoring report
  - User Story [WI 27008](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27008): Add contentMD5 to FileRegister
- [PR 3064](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3064): New pipeline to correct status
  - User Story [WI 26409](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26409): New pipeline to correct status
- [PR 3061](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3061): hotfix_bug26768_for_compare_row_count_transmitter to hotfix_bug26923_for_compare_row_count_transmitter
  - No Work Items linked to this PR.
- [PR 3046](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3046): FileForager SynapseWorkspace
  - Task [WI 26879](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26879): Create FileForager to gather files from other datalakes
- [PR 3034](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3034): merge master into my branch -himani
  - No Work Items linked to this PR.
- [PR 3143](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3143): TPP Common Model Ccg/Trust/Organisation Fixes and Optimise
  - Task [WI 27134](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27134): TPP Common Model Ccg Trust Organisation Fixes / Optimisations
- [PR 3142](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3142): TPP Common Model Practitioner Fixes / Optimisations
  - Task [WI 27129](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27129): TPP Common Model Practitioner Fixes / Optimisations
- [PR 3141](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3141): SQL - CDM Transform TPP Observation Optimisation & de-dupe
  - Task [WI 27113](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27113): Optimise TPP Observations
- [PR 3140](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3140): SQL - CDM Transform TPP MedicationStatement Optimisation & de-dupe
  - User Story [WI 27126](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27126): SQL - PrimaryCareTPP_MedicationStatement_Process Performance Fix
- [PR 3134](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3134): Minor fixes to EMIS ReferralRequest Process & Materialise proc
  - Task [WI 27123](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27123): Fix EMIS Proc CTAS Table Naming
- [PR 3138](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3138): SQL - PrimaryCareTPP_MedicationOrder_Process Performance Fix
  - User Story [WI 27103](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27103): Refactor [CDM_masked].[PrimaryCareTPP_MedicationOrder_Process]
- [PR 3135](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3135): Updating procedure:  FileRegister_InsertEvent
  - Bug [WI 27098](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27098): 'Preprocessor' pipeline failed
- [PR 3131](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3131): Allow nulls
  - Bug [WI 27090](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27090): 'Monitoring Batch Progress Summary' pipeline failed
- [PR 3144](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3144): Removes accidental cell from Allocator Notebook
  - Bug [WI 26740](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26740): Associator table change feed deactivated - allocator failed
- [PR 3145](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3145): Storage Account fix for Opt-Out process
  - User Story [WI 26717](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26717): NDOO and LDOO tables transmitted
- [PR 3136](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3136): Bug 27030: Resume and Pause CommonModel DB for Row Count Comparison
  - Bug [WI 27030](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27030): R264 Regression Transmitter Master pipeline failures on Delta Import
  - Bug [WI 27097](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27097): Release 267  possible regressive issue SQL pools pausing whilst scheduled pipelines still running
  - Task [WI 27107](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27107): Fix the issue by adding CommonModel DB Resume and Pause step
- [PR 3132](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3132): Make allocator CDF processing resilient; remove dependency on CDF enablement version
  - Task [WI 27092](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27092): Make allocator CDF processing resilient and remove enablement-version dependency
- [PR 3133](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3133): Bugfix_27094_Fix_Indentation_In_transmitter_functions_notebook
  - Bug [WI 27094](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27094): Transmitter: Write to outbox failed due to Indentation Error
  - Task [WI 27095](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27095): Investigate and resolve
- [PR 3154](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3154): Fix QoF Datapoint issues 
  - Task [WI 26712](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26712): Test in pre prod
- [PR 3157](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3157): TPP Common Model - Add missing Org Joins (Transform_masked Views)
  - Task [WI 27217](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27217): TPP Common Model - Quick Join Check All Transform Views
- [PR 3152](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3152): SQL - CDM Quick Optimisation fixes (removing duplicates/ cross joins)
  - User Story [WI 27112](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27112): PrimaryCateTPP Opimisations
- [PR 3156](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3156): Common Model Fixes for TPP Appointment
  - Task [WI 27140](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27140): TPP Common Model Appointment Fixes / Optimisations
- [PR 3167](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3167): Batch Progress Summary view not showing in progress
  - Bug [WI 27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138): Batch Progress Summary view not showing recent activity
- [PR 3151](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3151): Batch Progress Summary view not showing recent activity
  - Bug [WI 27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138): Batch Progress Summary view not showing recent activity
- [PR 3166](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3166): add adhoc CETAS exporting and deltalake loading pipeline
  - User Story [WI 27244](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27244): put adhoc CETAS and deltalake loader utility into code
- [PR 3153](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3153): US_27141_Add_and_remove_monitoring_columns_transmitter
  - User Story [WI 27141](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27141): Transmitter : Adding/Removing columns for Monitoring Views
  - Task [WI 27142](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27142): Add/remove columns in OLIDS Transmitter view
- [PR 3159](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3159): updating feature branch
  - No Work Items linked to this PR.
- [PR 3172](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3172): SQL - Versioner Data Pass Through Mode
  - Task [WI 27279](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27279): Create Versioner Pass Through Patch
- [PR 3170](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3170): Enhance Batch Progress Summary view
  - Bug [WI 27138](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27138): Batch Progress Summary view not showing recent activity
  - Bug [WI 27245](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27245): Directories missing from "batch progress summary" monitoring report
- [PR 3179](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3179): CETAS exporter and Deltalake Loader (SQL)
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files
  - Task [WI 26567](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26567): Ben work
  - Task [WI 26692](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26692): create CETAS sql tables (logs and configs)
  - Task [WI 26693](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26693): create CETAS sql interactions
  - Task [WI 26695](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26695): create deltalake loader (from file) sql tables (logs and configs)
  - Task [WI 26696](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26696): create deltalake loader (from file) sql interactions
- [PR 3163](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3163): Orchestrate datapoint execution
  - Task [WI 26712](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26712): Test in pre prod
- [PR 3165](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3165): feature_US26689_Add_Referential_Integrity_Test
  - User Story [WI 26689](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26689): Add Referential Integrity Test in ADF Pipeline
  - Task [WI 27231](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27231): Release to pre-prod
- [PR 3180](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3180): Transmitter: Added vectorized scanner in the "copy inserts to snowflake" activity 
  - Bug [WI 27314](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27314): Vectorized scanner is not taken in consideration while copy data to snowflake
- [PR 3178](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3178): CETAS exporter and Deltalake Loader (pipelines and notebook)
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files
  - Task [WI 26567](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26567): Ben work
  - Task [WI 26694](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26694): create CETAS orchestration (pipelines)
  - Task [WI 26697](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26697): create deltalake loader (from file) orchestration (pipelines)
  - Task [WI 26698](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26698): create deltalake loader (from file) notebook
- [PR 3038](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3038): merge master into feature branch 'cetas-export-import' to leverage dispatch utility
  - No Work Items linked to this PR
- [PR 3186](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3186): Minor Fix: default constraint on CDM config table
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files
- [PR 3182](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3182): Updated column definitions of [NationalSlotCategoryDescription]
  - Bug [WI 27304](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27304): 'versioner_LTE_load' pipeline failed
  - Task [WI 27305](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27305): Troubleshoot
  - Task [WI 27322](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27322): Create fix - Update Metadata and objects
- [PR 3183](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3183): Integrate feature - CETAS exporter and deltalake loader - into common-model pipeline
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files
- [PR 3187](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3187): Hotfix: correct trigger connnection
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files
- [PR 3184](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3184): Integrate feature - CETAS exporter and deltalake loader - into common-model pipeline (pipelines)
  - User Story [WI 26552](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26552): dedicated pool CETAS service / deltalake loader from files