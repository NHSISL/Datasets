# [Release-222] - 2025-09-08

> [!NOTE]
> The below is a summary of the changes from [release 169](Release-169.md) (previous pre-production release)

### Summary

**169 to 179:** This release delivers several improvements to performance, reliability, and data accuracy across the One London Data Platform. Key highlights include enhanced pipeline configurations for better throughput and error handling, expanded support for data monitoring and statistics, adjustments to data models for improved compatibility and correctness, and multiple bug fixes to ensure robust operation. Notable changes include optimisations to the Delta Lake SQL importer, new features for data allocation and transmission, and updates to address data truncation and confidentiality handling.

**179 to 189:** This release delivers significant improvements to the One London Data Platform, focusing on enhanced data processing, transmission reliability, and system performance. Key updates include optimisations to the transmitter outbox process, expanded FileWarden integration, improvements to data allocation and indexing, and multiple bug fixes to ensure data integrity and operational stability.

**189 to 199:** This release brings several improvements to the Allocator, FileWarden, and OrganisationLoader components, introduces new sensitivity filtering features, and delivers multiple bug fixes and refinements across the platform. Key updates include enhanced organisation data matching, improved allocation tracking, new sensitivity filtering for data transmission, and more robust pipeline and notebook logic.

**199 to 209:** This release delivers several improvements and fixes across the platform, including enhanced mapping and debugging views, improved allocation and deallocation processes, spelling corrections for greater data accuracy, and updates to pipelines and notebooks for more robust and streamlined operations. No changes affect the data leaving the service, but internal processes and developer tooling have been significantly refined.

**209 to 219:** This release delivers several improvements to data processing, reliability, and control within the One London Data Platform. Highlights include enhanced batch processing for Registrar Address Response, new configuration for extract groups, optimised pipelines and notebook activities, improved error handling, and fixes for concurrency and specification issues. End users and data subscribers will benefit from increased throughput, better control over data ingress, and more robust processing.

**219 to 222** This release introduces enhanced configuration and tagging capabilities for the Delta Lakehouse, improvements to GP Register data management, more robust handling of large data transmissions, and several bug fixes and refinements to data processing pipelines. These changes collectively improve data accuracy, reliability, and flexibility for users of the One London Data Platform.

---

### New Features

- Introduced new stored procedures for enhanced data statistics and monitoring in both SQL and Synapse environments. *[SQL, [PR 2359](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2359), [WI 23797](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23797)]; SynapseWorkspace, [PR 2360](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2360), [WI 23797](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23797)]; SynapseWorkspace, [PR 2368](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2368), [WI 23797](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23797)]*
    > ✨ **Feature**: Enables improved reporting and operational monitoring for platform data flows.

- Added new monitoring views to support operational oversight. *[SQL, [PR 2329](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2329)]*
    > ✨ **Feature**: Provides greater visibility into platform activity and status.

- Added support for ingestion of the SRTheatreBookingSecondaryProcedure table for TPP, ensuring compatibility with new specifications. *[SQL, [PR 2323](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2323), [WI 23609](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23609)]*
    > ✨ **Feature**: Prepares the platform for future data sources without impacting current outputs.

- Added publisher and subscriber views based on the LDS GP Register to support data allocation for transmission. *[SQL, [PR2387](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2387), [WI21945](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21945)]*
    > ✨ **Feature**: Enables more flexible and accurate data allocation for data transmission.

- Integrated FileWarden module into the Preprocessor Azure Synapse Notebook, including new logging and validation views for EMIS/TPP metadata. *[SQL, [PR2402](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2402), [WI18883](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/18883)]*
    > ✨ **Feature**: Adds data flow protection and validation for sensitive datasets.

- Added stored procedures and views required for FileWarden Azure Notebook functionality, with dummy data for initial configuration. *[SQL, [PR2385](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2385), [WI18883](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/18883)]*
    > ✨ **Feature**: Prepares system for future data processing agreement enforcement.

- File Warden notebook functions and unit tests added for preprocessor integration. *[SynapseWorkspace, [PR2384](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2384), [WI18883](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/18883)]*
    > ✨ **Feature**: Improves data protection by enabling FileWarden logic in notebook processing.

- Added configurable sensitivity filtering to data transmission for specific ValueSets, enhancing privacy controls for sensitive health data. *[SynapseWorkspace, [PR 2456](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2456)]*
    > ✨ **Feature**: Enables the platform to filter out sensitive data categories before transmission, improving data privacy.

- OrganisationLoader: Introduced new stored procedures and Synapse pipelines to process and load organisation data from EMIS and TPP sources into the Lakehouse and Metadata databases. *[SQL, [PR 2432](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2432)], [SynapseWorkspace, [PR 2433](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2433)], [WI 24009](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24009)]*
    > ✨ **Feature**: Ensures up-to-date organisation information is available for matching and validation processes.

- Added pipeline run IDs to Allocator for improved tracking of allocation updates. *[SynapseWorkspace, [PR 2426](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2426)], [WI 23439](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23439), [WI 23812](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23812)]*
    > ✨ **Feature**: Allows users to trace allocation changes back to specific pipeline runs, improving auditability.

- Added mapping views and procedures for linking GP register data from SharePoint to LDS tables, facilitating easier integration and governance mapping. *[SQL, [PR 2475](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2475), [WI 23812](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23812)]*
    > ✨ **Feature**: Enables seamless mapping between external GP register data and LDS governance tables for improved data management.

- Introduced several new views for quickly examining complex table joins, supporting better debugging and tracing for transmitter, allocator, and governance modules. *[SQL, [PR 2481](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2481), [WI 24237](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24237)]*
    > ✨ **Feature**: Makes troubleshooting and understanding relationships between tables easier for developers and analysts.

- Added a utility function to convert datetime inputs into SQL-compatible formats, supporting a wide range of input formats for robust datetime normalization. *[SynapseWorkspace, [PR 2473](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2473), [WI 24219](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24219)]*
    > ✨ **Feature**: Ensures consistent datetime formatting across SQL operations, reducing errors in data processing.

- Introduced a new Registrar Address Response batch processing pipeline that determines previously processed files and batch processes all unprocessed .csv response files using OpenRowset. *[SQL, [PR 2515](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2515), [WI 24239](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24239), [WI 24244](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24244)]*
    > ✨ **Feature**: Enables more efficient and reliable batch processing of address responses.

- Added PCD OLIDS views to the platform, expanding available data views. *[SynapseWorkspace, [PR 2502](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2502), [WI 24292](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24292)]*
    > ✨ **Feature**: Provides new data views for Primary Care Data (PCD).

- Added a notebook to generate all OLIDS views, including fixes for invalid SQL in terminology views. *[SynapseWorkspace, [PR 2491](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2491), [WI 24260](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24260)]*
    > ✨ **Feature**: Simplifies and automates the creation of OLIDS views.

- Added new configuration and event tables to metadata to support processing of valueset tags in the Delta Lakehouse, enabling more granular control over which tables and columns are tagged. *[SQL, [PR 2552](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2552)]*
    > ✨ **Feature**: Enables incremental creation of valueset tags, enhancing data governance and traceability.

- Added a set of notebooks under DeltaLakehouse for incremental creation of valueset tags across all CDM tables. *[SynapseWorkspace, [PR 2553](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2553)]*
    > ✨ **Feature**: Improves metadata tagging, supporting better data lineage and compliance.

- Introduced fileCombiner configuration objects, allowing dynamic adjustment of file combining processes via metadata. *[SQL, [PR 2513](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2513), [WI 24606](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24606)]*
    > ✨ **Feature**: Provides flexibility for file combining operations, reducing manual intervention.

- Created pipeline to ingest and merge LDS GP Register records from SharePoint, supporting improved data integration. *[SynapseWorkspace, [PR 2535](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2535), [WI 23435](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23435)]*
    > ✨ **Feature**: Ensures GP Register data is always up-to-date with the latest SharePoint entries.
---

### Improvements

- Optimised Delta Lake SQL importer by increasing timeout and Spark node size, and introduced partitioning for improved performance. *[SynapseWorkspace, [PR 2376](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2376), [WI 23833](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23833), [WI 23860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23860)]; SynapseWorkspace, [PR 2377](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2377), [WI 23834](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23834)]*
    > 🎯 **Impact**: Faster and more reliable data imports, especially with large backlogs.

- Refined pipeline activity retry settings across Synapse workspace for more robust error handling. *[SynapseWorkspace, [PR 2358](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2358), [WI 23785](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23785)]*
    > 🎯 **Impact**: Reduces pipeline failures and improves operational stability.

- Split scheduled pipelines into separate triggers for improved scheduling flexibility. *[SynapseWorkspace, [PR 2338](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2338)]*
    > 🎯 **Impact**: Allows more granular control of data processing schedules.

- Added additional fields to Subscriber.EndPoint table and updated transmitter pipelines to support max rows per file, improving compatibility with Snowflake and reducing timeouts. *[SQL, [PR 2335](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2335), [WI 23615](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23615)]; SynapseWorkspace, [PR 2336](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2336), [WI 23615](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23615)]*
    > 🎯 **Impact**: Enables successful ingestion of larger datasets and prevents transmission failures.

- Added 'ApplyAllocation' flag to LDS.DataSetObjectForSubscriberEndPoint table for fine-grained allocation control. *[SQL, [PR 2273](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2273), [WI 22330](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22330)]*
    > 🎯 **Impact**: Improves allocation management for different subscribers and endpoints.

- OLIDS views now present the greatest watermark value from all source tables, ensuring up-to-date data tracking. *[SQL, [PR 2348](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2348), [WI 23380](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23380)]*
    > 🎯 **Impact**: Enhances data freshness and reliability for downstream consumers.

- Added LDSBusinessKey to OrganisationRelationship for improved traceability. *[SQL, [PR 2337](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2337), [WI 23419](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23419)]*
    > 🎯 **Impact**: Facilitates better data lineage and auditing.

- Changed Registrar and Common Model objects to process coordinate and lat/long values as varchars for Parquet compatibility. *[SQL, [PR 2334](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2334), [WI 23624](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23624)]*
    > 🎯 **Impact**: Ensures compatibility with Parquet file formats.

- Changed UPSN to USRN in PatientAddressUPRN-related objects to correct AddressBase errors and improved data type handling. *[SQL, [PR 2324](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2324), [WI 23580](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23580)]*
    > 🎯 **Impact**: Increases data accuracy for address records.

- Added Primary field to SRDischargeDelay for improved data granularity. *[SQL, [PR 2369](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2369), [WI 20878](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/20878)]; SQL, [PR 2371](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2371), [WI 20878](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/20878)]*
    > 🎯 **Impact**: Enables more detailed discharge delay tracking.

- Increased PharmacyMessage field size from 8000 to max to prevent data truncation. *[SQL, [PR 2361](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2361), [WI 23778](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23778)]; SQL, [PR 2367](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2367), [WI 23778](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23778)]*
    > 🎯 **Impact**: Ensures complete pharmacy message data is captured.

- Set LDSSequence to 1 by default for Registrar Address responses for consistency. *[SQL, [PR 2342](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2342), [WI 23237](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23237)]*
    > 🎯 **Impact**: Standardises address response records.

- Added LDSIsDeleted to Registrar Address Get_Response_Extract to support data deletion tracking. *[SQL, [PR 2343](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2343), [WI 23237](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23237)]*
    > 🎯 **Impact**: Improves data lifecycle management.

- Changed EMIS Transform views to use deduplicated Clinical Coding view, preventing duplicate records. *[SQL, [PR 2341](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2341), [WI 23431](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23431)]*
    > 🎯 **Impact**: Enhances data quality by eliminating duplicates.

- Increased ModeOfContact field size in Appointment_Slot from 20 to 26 to prevent truncation. *[SQL, [PR 2340](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2340), [WI 23240](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23240)]*
    > 🎯 **Impact**: Ensures full contact mode information is retained.

- Added additional unit tests for CSV file functions to improve reliability. *[SynapseWorkspace, [PR 2321](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2321), [WI 23610](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23610)]*
    > 🎯 **Impact**: Increases confidence in CSV data processing.

- Updated pipeline concurrency settings for Registrar Response to improve processing reliability. *[SynapseWorkspace, [PR 2352](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2352)]*
    > 🎯 **Impact**: Prevents potential conflicts and improves pipeline stability.

- Renamed delta lakehouse pipelines for better clarity and organisation. *[SynapseWorkspace, [PR 2274](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2274), [WI 23188](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23188)]*
    > 🎯 **Impact**: Easier identification and management of pipelines.

- Migrated transmitter outbox file writes to Spark notebooks, replacing serverless SQL to improve performance and scalability. *[SynapseWorkspace, [PR2416](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2416), [WI23897](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23897)]*
    > 🎯 **Impact**: Reduces transmission errors and improves file generation speed.

- Expanded logging capabilities for Delta Lakehouse event logs and procedures, improving traceability and compatibility. *[SQL, [PR2399](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2399), [WI23860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23860), [WI23873](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23873), [WI23874](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23874)]*
    > 🎯 **Impact**: Enhances auditability and monitoring of data processing events.

- Introduced checkpointing and optimisations to Delta Lakehouse SQL importer for more efficient data processing. *[SynapseWorkspace, [PR2398](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2398), [WI23833](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23833), [WI23860](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23860), [WI23873](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23873), [WI23874](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23874)]*

    > 🎯 **Impact**: Improves performance and reliability of large data imports.
- Changed LDS.GPRegister index to use ODS code for improved uniqueness and performance. *[SQL, [PR2419](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2419), [WI21987](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21987)]*

    > 🎯 **Impact**: Ensures more reliable indexing and faster data access.
- Changed Registrar Extract LDSRecordId to match the requesting record, enabling correct data allocation and transmission. *[SQL, [PR2415](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2415), [WI24041](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24041)]*

    > 🎯 **Impact**: Ensures Registrar-based data is allocated and transmitted correctly.
- Added record hash to NDOO records and removed LDSRecordId_Request for better change tracking. *[SQL, [PR2364](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2364), [WI23761](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23761)]*

    > 🎯 **Impact**: Improves ability to track changes and differences between records.
- Increased PharmacyMessage field size from 8000 to max for improved data handling. *[SQL, [PR2391](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2391), [WI23778](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23778)]*

    > 🎯 **Impact**: Prevents message truncation and supports larger pharmacy messages.
- Changed data type for LDSBusinessKey in OrganisationRelationship CDM table to VARCHAR(8000) for consistency. *[SQL, [PR2380](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2380), [WI23863](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23863)]*

    > 🎯 **Impact**: Ensures compatibility and correct population of data in downstream views.
- Updated Snowflake warehouse name for NCL transmissions to use a medium-sized warehouse, improving performance. *[SQL, [PR2400](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2400), [WI24011](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24011)]*
    > 🎯 **Impact**: Optimises data transmission for NCL datasets.

- Added collation to all concept joins to prevent data duplication due to case differences. *[SQL, [PR2414](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2414), [WI24039](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24039)]*
    > 🎯 **Impact**: Ensures accurate data joins and prevents duplicate rows.

- Removed collation in Transform views and ReferralRequest view for non-varchar types, improving join operations. *[SQL, [PR2422](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2422), [WI24039](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24039)], [PR2421](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2421), [WI21987](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21987)]*
    > 🎯 **Impact**: Fixes join issues and improves data processing reliability.

- FileWarden: Integrated Sharepoint GP DPA List and OrganisationLoader data for more accurate organisation matching and DPA validation. *[SQL, [PR 2446](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2446)], [WI 24007](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24007)]*
    > 🎯 **Impact**: Improves accuracy of DPA matching, reducing data access errors.

- Wired up the [SystemOrganisationIdentifier] column in the Sharepoint table to enhance FileWarden’s organisation lookup logic, with fallback to OrganisationLoader when necessary. *[SQL, [PR 2454](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2454)], [WI 24116](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24116)]*
    > 🎯 **Impact**: Ensures correct organisation matching for EMIS data, improving data governance.

- OrganisationLoader: Added [ExtractBatchDate] to datasets to resolve duplicate organisation records and improve matching logic. *[SQL, [PR 2435](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2435)], [WI 24009](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24009)]*
    > 🎯 **Impact**: Reduces errors in organisation matching and supports FileWarden logic.

- Allocator: Updated views and LDS GP Register to ensure allocation delta tables are populated and metadata is accurate. *[SQL, [PR 2452](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2452)], [WI 21987](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21987)]*
    > 🎯 **Impact**: Enables more reliable allocation tracking and reporting.

- Provided subscriber and subscription information to Allocator views for enhanced allocation support. *[SQL, [PR 2424](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2424)], [WI 23812](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23812)]*
    > 🎯 **Impact**: Improves transparency and traceability of data allocations.

- Updated pipeline: Common Model Master to include calls to Terminology, improving data enrichment processes. *[SynapseWorkspace, [PR 2449](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2449)], [WI 24070](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24070)]*
    > 🎯 **Impact**: Enhances data quality and consistency.

- Added a cell for running olids_terminology notebook in transmitter_write_to_outbox notebook, streamlining terminology updates. *[SynapseWorkspace, [PR 2453](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2453)]*
    > 🎯 **Impact**: Ensures terminology is kept up to date in transmitted data.

- FileWarden Notebook: Improved merge logic on association_metadata delta file to correctly update creation and modification dates. *[SynapseWorkspace, [PR 2450](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2450)], [WI 23434](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23434)]*
    > 🎯 **Impact**: Increases accuracy of metadata tracking.

- Enhanced logging in delta_lakehouse_functions notebook to better identify issues with valueset population. *[SynapseWorkspace, [PR 2448](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2448)], [WI 24070](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24070)]*
    > 🎯 **Impact**: Improves troubleshooting and data integrity

- Improved function logic in delta_lakehouse_functions notebook to handle empty watermarks more gracefully. *[SynapseWorkspace, [PR 2447](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2447)], [WI 24114](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24114)]*
    > 🎯 **Impact**: Reduces errors during data import.

- Enhanced pipeline: FileCombiner Processing to loop until all files are processed, with batch and size limits for efficiency. *[SynapseWorkspace, [PR 2417](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2417)], [WI 23838](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23838)]*
    > 🎯 **Impact**: Ensures complete file processing and prevents pipeline overload.

- Share Point link service connection improvements for better integration. *[SynapseWorkspace, [PR 2440](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2440)], [WI 23937](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23937)]*
    > 🎯 **Impact**: Strengthens data connectivity with Sharepoint.

- Updated pipeline: Common Model CDM for improved data model processing. *[SynapseWorkspace, [PR 2445](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2445)]*
    > 🎯 **Impact**: Enhances data model consistency and reliability

- Updates to the environment values procedure and enhanced transmitter disabled items view, making metadata copying and debugging transmitter items more transparent. *[SQL, [PR 2484](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2484), [WI 24247](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24247)]*
    > 🎯 **Impact**: Internal metadata management and debugging are easier and more reliable.

- Allocator procedure now includes subscriber code and subscription ID, improving allocation data completeness. *[SQL, [PR 2468](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2468), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
    > 🎯 **Impact**: Allocation records are more detailed, supporting better tracking and auditing.

- Allocation notebook and schema updated to include subscriber code, subscription ID, and processed date, with improved partitioning and schema management. *[SynapseWorkspace, [PR 2462](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2462), [WI 23812](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23812), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
    > 🎯 **Impact**: Allocation datasets are more organized and easier to manage.

- Added 'id' field to allocation OLIDS view for unique business key merging, facilitating easier data integration with external systems. *[SynapseWorkspace, [PR 2478](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2478), [WI 23822](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23822)]*
    > 🎯 **Impact**: Data merging and synchronization with external databases is more reliable.

- Removed unnecessary parameters from Allocator pipeline, simplifying its execution. *[SynapseWorkspace, [PR 2483](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2483), [WI 24236](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24236), [WI 24248](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24248)]*
    > 🎯 **Impact**: Running allocation processes is easier and less error-prone.

- Updated Transmitter Export Dataset Object To Outbox pipeline to pull sensitivity filtering flag from pipeline, improving configuration flexibility. *[SynapseWorkspace, [PR 2482](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2482)]*
    > 🎯 **Impact**: Enhanced control over data transmission sensitivity.

- Multiple updates to notebooks (transmitter_functions, olids_terminology, allocator_functions, transmitter_write_to_outbox, etc.) for improved reliability, error handling, and developer usability. *[SynapseWorkspace, [PRs 2487](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2487), [2486](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2486), [2477](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2477), [2466](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2466)]*
    > 🎯 **Impact**: Notebooks are easier to use, less prone to errors, and more consistent in their outputs.

- Added a new config table to identify active extract groups, with updates to the preprocessor procedure to filter by active groups, improving data ingress control. *[SQL, [PR 2517](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2517), [PR 2526](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2526), [PR 2538](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2538), [WI 22286](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22286)]*
    > 🎯 **Impact**: Allows more granular control over which data extract groups are processed.

- Increased FileCombiner default batch size limit to 50 for improved processing throughput. *[SynapseWorkspace, [PR 2528](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2528)]*
    > 🎯 **Impact**: Enables faster batch processing of files.

- Updated transmitter configuration to set Airlock warehouse to use the medium warehouse, increasing throughput capacity. *[SQL, [PR 2497](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2497)]*
    > 🎯 **Impact**: Improves data transmission performance to Airlock.

- Changed timeout for Snowflake script activities from 10 minutes to 59 minutes, reducing risk of premature timeouts. *[SynapseWorkspace, [PR 2544](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2544), [WI 24426](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24426)]*
    > 🎯 **Impact**: Increases reliability of long-running Snowflake scripts.

- Updated Common Model CDM pipeline to add retry logic for lookup operations, improving resilience. *[SynapseWorkspace, [PR 2542](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2542)]*
    > 🎯 **Impact**: Reduces failures due to intermittent issues in CDM lookups.

- Temporarily added retry logic to Common Model Continuum pipeline to address intermittent issues. *[SynapseWorkspace, [PR 2523](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2523)]*
    > 🎯 **Impact**: Improves reliability of Common Model Continuum processing.

- Enhanced preprocessor pipeline with new parameters for Spark executor configuration and increased batch throttling, improving scalability and performance. *[SynapseWorkspace, [PR 2536](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2536), [WI 24423](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24423)]*
    > 🎯 **Impact**: Allows more flexible and efficient scaling of data processing.

- Moved Allocator process to the end of Preprocessor Master pipeline for better parallel execution and removed unnecessary triggers. *[SynapseWorkspace, [PR 2540](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2540), [WI 24423](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24423)]*
    > 🎯 **Impact**: Optimises pipeline execution and resource usage.

- Set Allocator pipeline concurrency to 1 to prevent simultaneous executions. *[SynapseWorkspace, [PR 2504](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2504), [WI 24309](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24309)]*
    > 🎯 **Impact**: Ensures reliable sequential processing in Allocator pipeline.

- Updated pipeline: Transmitter Export Dataset Object To Outbox for improved data export. *[SynapseWorkspace, [PR 2493](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2493)]*
    > 🎯 **Impact**: Enhances dataset object export reliability.

- Changed code systems for improved data accuracy. *[SQL, [PR 2507](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2507), [WI 23794](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23794)]*
    > 🎯 **Impact**: Ensures correct code system mapping in data outputs.

- Removed FileWarden config that disabled it on PreProd, ensuring correct configuration on new deployments. *[SQL, [PR 2503](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2503), [WI 19935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/19935), [WI 24310](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24310)]*
    > 🎯 **Impact**: Ensures FileWarden is enabled as intended on PreProd environments.

- Changed Episodicity code system for identifying unmapped codes, removed unnecessary semicolons in metadata procedures, and added a configuration view to show code system usage. *[SQL, [PR 2509](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2509), [WI 21798](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21798)]*
    > 🎯 **Impact**: Increases transparency and reduces errors in code mapping.

- Updated GP Register merge procedure to support insert, update, and delete operations, rather than just insert. *[SQL, [PR 2561](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2561)]*
    > 🎯 **Impact**: Ensures SharePoint updates and deletions are accurately reflected in the GP Register.

- Enabled merging LDS GP Register from SharePoint data, ensuring allocations are based on the latest DSA/DPA agreements. *[SQL, [PR 2534](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2534), [WI 23435](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23435)]*
    > 🎯 **Impact**: Improves accuracy of practice allocations and agreement tracking.

- Populated LDSDataSetId in all Registrar requests and responses, removing hardcoded references and supporting multiple datasets. *[SQL, [PR 2560](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2560), SynapseWorkspace, [PR 2559](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2559), [WI 24527](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24527)]*
    > 🎯 **Impact**: Increases flexibility for processing different datasets.

- Updated transmitter event table and pipelines to use bigint/int64 for row counts, preventing overflow during large transmissions. *[SQL, [PR 2547](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2547), [WI 24437](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24437)], SynapseWorkspace, [PR 2548](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2548), [WI 24437](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24437)]*
    > 🎯 **Impact**: Ensures reliable logging and processing of large data volumes.

- Updated Preprocessor Master pipeline to integrate GPRegister SharePoint import, improving automation of data updates. *[SynapseWorkspace, [PR 2562](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2562)]*
    > 🎯 **Impact**: Streamlines data ingestion and reduces manual steps.

- Changed lds_batch_id and id to uppercase in relevant notebooks for consistency. *[SynapseWorkspace, [PR 2557](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2557)]*
    > 🎯 **Impact**: Standardizes data formats for downstream processing.

- Generate 'LDSRecordId' in uppercase and optimized related tests for better case handling. *[SynapseWorkspace, [PR 2550](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2550), [WI 24436](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24436)]*
    > 🎯 **Impact**: Reduces case sensitivity errors in record identification.
---

### Bug Fixes

- Set `ldsEndDatetime` as NULL within CDM extraction views to resolve performance bottlenecks. *[SQL, [PR 2375](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2375), [WI 23833](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23833), [WI 23861](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23861)]*
    > 🐞 **Fix**: Significantly improves data extraction performance during backlog processing.

- Fixed typo in table name used for priority labelling in Prescribing IssueRecord. *[SQL, [PR 2362](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2362), [WI 23683](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23683)]*
    > 🐞 **Fix**: Ensures correct priority labels are applied.

- All IsConfidential columns made nullable to prevent pipeline failures when rows are deleted. *[SQL, [PR 2322](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2322), [WI 23604](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23604)]; SQL, [PR 2319](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2319), [WI 23604](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23604)]*
    > 🐞 **Fix**: Prevents critical failures in the Common Model CDM pipeline.

- On Synapse Serverless, all columns now set to nullable to ensure compatibility. *[SQL, [PR 2278](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2278), [WI 23078](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23078)]*
    > 🐞 **Fix**: Resolves issues with Synapse Serverless external tables.

- Fixed issue where 'Registrar Patient Response' pipeline failed in 'Create outbox file' activity. *[SQL, [PR 2353](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2353), [WI 23712](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23712)]*
    > 🐞 **Fix**: Ensures successful outbox file creation for Registrar Patient Response.

- Fixed empty file and CSV header row issues in transmitter pipelines. *[SynapseWorkspace, [PR 2320](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2320), [WI 23592](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23592)]*
    > 🐞 **Fix**: Prevents transmission errors due to empty files or incorrect headers.

- Fail Pre-processor pipeline if either a row or a file fails, improving error detection. *[SynapseWorkspace, [PR 2345](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2345), [WI 23574](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23574)]*
    > 🐞 **Fix**: Ensures failed data is not processed further, increasing reliability.

- Fixed issues with some indexes to improve database performance and reliability. *[SQL, [PR2420](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2420), [WI24044](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24044)]*
    > 🐞 **Fix**: Resolves index-related errors for more stable data access.

- Fixed transmitter bug by changing row count datatype from INT to BIGINT to handle large volumes. *[SQL, [PR2390](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2390), [WI23953](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23953)]*
    > 🐞 **Fix**: Prevents failures in data transmission for large datasets.

- Fixed altered v_concept_report.sql to support BIGINT counts, preventing overflow errors in Power BI reports. *[SQL, [PR2396](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2396)]*
    > 🐞 **Fix**: Ensures Power BI terminology reports work with large record volumes.

- Fixed conceptmap duplicate issue by grouping only on code when processing concepts. *[SQL, [PR2413](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2413)]*
    > 🐞 **Fix**: Prevents duplication when concepts have different display values.

- Bug fix to resolve duplicates in Transform_masked.PrimaryCareTPP_SRAppointment_Appointment procedure. *[SQL, [PR2386](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2386), [WI23904](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23904)]*
    > 🐞 **Fix**: Ensures unique appointment data.

- Fixed casting of nulled LDSEndDatetime values to datetime datatype in CDM extraction views. *[SQL, [PR2389](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2389), [WI23872](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23872), [WI23949](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23949)]*
    > 🐞 **Fix**: Prevents extraction failures to delta lake.

- Use COUNT_BIG instead of COUNT in reporting and appointment processing to handle larger datasets. *[SQL, [PR2383](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2383), [WI23865](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23865)], [PR2382](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2382), [WI23865](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23865)]*
    > 🐞 **Fix**: Prevents errors in reports and processing for large record counts.

- Fixed incorrect date format used in transmitter outbox notebook. *[SynapseWorkspace, [PR2427](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2427), [WI24060](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24060)]*
    > 🐞 **Fix**: Ensures correct date formatting in transmitted files.

- Fixed issues preventing valueset tag matching by correcting join logic in tag calculation. *[SQL, [PR 2455](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2455)]*
    > 🐞 **Fix**: Ensures tags are calculated correctly, improving metadata accuracy.

- Allocator: Multiple bug fixes to views and GP Register, including removal of merge defects and ambiguous references. *[SQL, [PR 2452](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2452)], [WI 21987](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/21987)]*
    > 🐞 **Fix**: Resolves allocation and metadata errors.

- FileCombiner: Fixed incorrect parameter usage in pipeline, ensuring correct file array handling. *[SynapseWorkspace, [PR 2436](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2436)], [WI 24081](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24081)]*
    > 🐞 **Fix**: Prevents pipeline errors during file combining.

- Fixed transmitter spark notebook error when writing 'old' dates in parquet files by updating spark config settings. *[SynapseWorkspace, [PR 2428](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2428)], [WI 24065](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24065)]*
    > 🐞 **Fix**: Ensures successful file writing for all date values.

- transmitter: Fixed notebook and column references for OLIDS datasets, resolving function and data source issues. *[SynapseWorkspace, [PR 2444](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2444)], [WI 24111](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24111)]*
    > 🐞 **Fix**: Prevents errors in OLIDS data processing.

- Corrected several spelling errors in OLIDS views and common-model transforms, ensuring accurate column names and improving data integrity. *[SQL, [PR 2476](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2476), [WI 24228](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24228)]*
    > 🐞 **Fix**: Prevents potential data mismatches and confusion due to misspelled column names.

- Ensured certain fields (OTHER_GIVEN_NAME, POSTCODE, DATE_OF_DEATH, GP_PRACTICE_CODE) are set to null in PDS requests, reducing unnecessary data in requests. *[SQL, [PR 2472](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2472)]*
    > 🐞 **Fix**: Streamlines PDS requests for better interoperability and compliance.

- Fixed issue with missing parameter in apply_deallocations functions, ensuring correct deallocation processing. *[SynapseWorkspace, [PR 2480](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2480), [WI 24237](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24237)]*
    > 🐞 **Fix**: Deallocation operations now run smoothly without errors.

- Fixed error in allocator notebook related to incorrect column name for high watermark value. *[SynapseWorkspace, [PR 2462](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2462), [WI 23812](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23812), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
    > 🐞 **Fix**: Prevents allocation process failures due to column name mismatches.

- Fixed bug in olids_terminology notebook preventing transmission of concept_map. *[SynapseWorkspace, [PR 2466](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2466)]*
    > 🐞 **Fix**: Ensures concept maps are transmitted correctly.

- Fixed delta lakehouse SQL importer notebook to properly check existence of delta lake tables before overwriting, preventing destructive operations. *[SynapseWorkspace, [PR 2465](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2465), [WI 24166](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24166)]*
    > 🐞 **Fix**: Safeguards against unintended data loss when initializing delta lakes.

- Corrected parameter counts in allocator functions, removing erroneous pipeline_id argument. *[SynapseWorkspace, [PR 2459](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2459), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
    > 🐞 **Fix**: Functions now accept the correct parameters, reducing errors in allocation and deallocation processes.

- Fixed specification and object ID selection in `FileWarden.vDPAFilter`, ensuring correct mapping. *[SQL, [PR 2514](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2514)]*
    > 🐞 **Fix**: Corrects data mapping for file warden filtering.

- Changed COUNT to COUNT_BIG in transmitter row count procedure to fix arithmetic overflow. *[SQL, [PR 2500](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2500), [WI 24291](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24291)]*
    > 🐞 **Fix**: Prevents overflow errors when counting large numbers of rows.

- Fixed fileWarden write to associations lake concurrency failure by partitioning files correctly and updating partitioning columns. *[SynapseWorkspace, [PR 2518](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2518), [WI 24366](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24366)]*
    > 🐞 **Fix**: Resolves data concurrency issues for association metadata tags.

- Fixed FileCombiner batch ID setting placement so each destination batch is assigned a unique BatchID. *[SynapseWorkspace, [PR 2506](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2506)]*
    > 🐞 **Fix**: Ensures correct batch identification during file combining.

- Registrar pipeline now fails on empty LDSManifest.txt files, improving error detection for missing events. *[SQL, [PR 2527](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2527), [WI 24374](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24374)]*
    > 🐞 **Fix**: Prevents silent failures when no matching request records are found.

- Added retries to the file validator JSON report file writing function to mitigate concurrency issues and improve error reporting. *[SynapseWorkspace, [PR 2525](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2525), [WI 24360](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24360)]*
    > 🐞 **Fix**: Reduces risk of report writing failures due to concurrency.

- Fixed syntax issue with GROUP BY in notebook: olids_terminology by using column names instead of aliases. *[SynapseWorkspace, [PR 2545](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2545), [WI 24428](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24428)]*
    > 🐞 **Fix**: Ensures correct SQL execution in OLIDS terminology notebook

- Excluded agreements with no start date and/or DPA version from publisher tables, preventing erroneous data transmission. *[SQL, [PR 2563](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2563), [WI 23435](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23435)]*
    > 🐞 **Fix**: Ensures only valid agreements are processed, reducing risk of data errors.

- Removed commas from family and given names in Patient.Select_Request_Rows to prevent column shift errors in CSV files. *[SQL, [PR 2556](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2556), [WI 24596](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24596)]*
    > 🐞 **Fix**: Prevents data misalignment in exported files.

- Fixed incorrect join in OLIDS episode of care view, ensuring practitioner roles are matched using the correct column. *[SynapseWorkspace, [PR 2549](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2549), [WI 24444](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24444)]*
    > 🐞 **Fix**: Improves accuracy of episode of care reporting.

- Fixed missing variable `allocation_delta_lake_table_path` in transmitter notebook, restoring correct file path handling. *[SynapseWorkspace, [PR 2558](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2558), [WI 24602](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24602)]*
    > 🐞 **Fix**: Ensures transmitter notebooks run successfully.

- Fixed error handling bug in file_warden_functions by correcting variable name, restoring backoff retry logic. *[SynapseWorkspace, [PR 2546](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2546), [WI 24438](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24438)]*
    > 🐞 **Fix**: Improves reliability of file warden processing.


---

### Refactoring

- Updated pipelines calling notebook activities to use dynamic executors, improving resource management. *[SynapseWorkspace, [PR 2315](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2315), [WI 23568](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23568)]*
- Changed SchedulePractitioner Transform view to use correct LDSRecordId for EMIS source table. *[SQL, [PR 2355](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2355), [WI 23772](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23772), [WI 23773](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23773)]*
- Removed row delimiter parameterisation for DataLakeTextDataset, setting it to default. *[SynapseWorkspace, [PR 2333](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2333), [WI 23237](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23237)]*
- Changed data types for USRN and related address fields for improved compatibility. *[SQL, [PR 2324](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2324), [WI 23580](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23580)]*
- Sync metadata and updated 4383 files for improved consistency. *[SQL, [PR2388](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2388), [WI23893](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23893)]*
- Disabled FileWarden in PreProd until DPA metadata is ready, ensuring correct data flow until full configuration. *[SQL, [PR2411](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2411), [WI24046](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24046)]*
- Made temporary fixes more permanent in several procedures and configurations. *[SQL, [PR2407](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2407)], [PR2401](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2401)]*
- Multiple notebook and pipeline updates for development and debugging purposes. *[SynapseWorkspace, [PR2405](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2405), [WI23897](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23897)]*
- Updating notebook: delta_lakehouse_functions - removed casting of datetime LDSStartDateTime for improved query performance. *[SynapseWorkspace, [PR2379](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2379), [WI23859](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23859)]*
- Corrected minor spelling error in pull request template ("mesaage" to "message"). *[SQL, [PR 2439](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2439)], [WI 24085](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24085)]*
- Removed source query settings from notebook activity parameters and reorganised parameter sections for clarity. *[SynapseWorkspace, [PR 2434](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2434)], [WI 24070](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24070)]*
- FileWarden: Cleaned up unit tests and commented out creation of managed delta tables for clarity and reliability. *[SynapseWorkspace, [PR 2450](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2450)], [WI 23434](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23434)]*
- Added subscriber code and subscription ID to allocator procedure for improved tracking and management. *[SQL, [PR 2468](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2468), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
- Deleted obsolete trigger: allocator_inbox_landing, cleaning up unused resources. *[SynapseWorkspace, [PR 2458](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2458), [WI 24125](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24125)]*
- Simplified the [LDSDateTimeSupplied] function in FileRegister pipeline to use MIN instead of windowed function for performance optimisation. *[SQL, [PR 2537](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2537)]*
- Added try-catch blocks to Continuum_masked AppointmentPractitioner for improved error handling. *[SQL, [PR 2524](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2524)]*
- Removed lds_record_id and certain internal lakehouse columns from the exclusion list in OLIDS views and transmitter module, allowing these columns to flow through to subscribers. Also added lds_record_id to all relevant views. *[SynapseWorkspace, [PR 2532](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2532), [WI 24412](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24412)]*
- Refactored transmitter logic to insert records marked as deleted instead of deleting them, and added new metadata columns for better event tracking. *[SynapseWorkspace, [PR 2555](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2555), [WI 24598](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24598)]*
- Improved add_row_register_columns_to_dataframe function and its unit test for case sensitivity and performance. *[SynapseWorkspace, [PR 2550](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2550), [WI 24436](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24436)]*

---

### Inputs

This change note was automatically produced from:

- **43 + 32 + 28 + 21 + 36 + 21 = 181** Pull Requests
- **36 + 37 + 19 + 17 + 22 + 15 = 146** Work Items
- **185 + 503 + 181 + 134 + 146 + 181 = 1,330** Commits
