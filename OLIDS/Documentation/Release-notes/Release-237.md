# [Release-237] - 2025-10-13

> [!NOTE]
> The below is a summary of the changes from [release 223](Release-223.md) (previous pre-production release)

### Summary

This release introduces important new features and improvements to the One London Data Platform, focusing on enhanced data governance, monitoring, allocation processes, and operational reliability. Notable updates include support for metadata-only allocations, improved traceability for pipeline runs, new configuration options for data filtering, and several bug fixes that enhance data accuracy and system stability.


### New Features

- Added support for governance metadata-only allocations in both SQL tables/views and the allocator notebook, enabling allocation generation when only metadata changes occur without new associations. *[SQL, [PR 2712](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2712), [WI 24861](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24861)]; SynapseWorkspace, [PR 2713](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2713), [WI 24861](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24861)]*
    > ✨ **Feature**: Ensures allocations reflect governance changes, improving compliance and auditability.

- Added tables and procedures for tracking Change Data Feed (CDF) metadata for delta lake tables, supporting more accurate versioning and data processing. *[SQL, [PR 2674](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2674), [WI 24920](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24920)]; SynapseWorkspace, [PR 2675](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2675), [WI 24920](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24920)]*
    > ✨ **Feature**: Enables precise tracking of data changes for improved allocation and processing accuracy.

- Added a new monitoring schema and batch progress view to the metadata database for improved operational monitoring. *[SQL, [PR 2616](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2616), [WI 24767](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24767)]*
    > ✨ **Feature**: Enhances visibility of batch processing for operational teams.

- Added a table to store subscriber exclusion lists, preventing incorrect deletion flags during GP register merges. *[SQL, [PR 2706](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2706), [WI 25260](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25260)]*
    > ✨ **Feature**: Protects key subscriber mappings from accidental deletion.

- Added new child pipelines for Common Model post-process and Lakehouse sync, improving data flow and processing after transformations. *[SynapseWorkspace, [PR 2651](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2651), [WI 22902](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22902)]*
    > ✨ **Feature**: Streamlines post-processing and data synchronization.

- Added utility pipeline to test endpoint connectivity for subscribers. *[SynapseWorkspace, [PR 2579](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2579), [WI 24707](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24707)]*
    > ✨ **Feature**: Facilitates troubleshooting and operational checks.

### Improvements

- Fixed EMIS AppointmentPractitioner LDSBusinessId definition to prevent row duplication in CDM_masked procedures. *[SQL, [PR 2589](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2589), [WI 24727](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24727)]*
    > 🐞 **Fix**: Ensures unique identifiers and prevents data duplication.

- Fixed archiving logic in FileMover and related pipelines to permanently delete source files instead of archiving, aligning with new operational requirements. *[SynapseWorkspace, [PR 2661](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2661), [WI 24866](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24866); PR 2672](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2672), [WI 24934](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24934)]*
    > 🐞 **Fix**: Prevents unnecessary archiving and reduces storage use.

- Fixed registrar response handling to treat null datasetID as PrimaryCareEMIS, ensuring correct dataset identification. *[SQL, [PR 2626](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2626), [WI 24799](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24799)]*
    > 🐞 **Fix**: Ensures accurate dataset mapping.

- Fixed column name issues in Get_Unprocessed_Response_Data.sql to prevent pipeline failures due to invalid characters. *[SQL, [PR 2628](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2628)]*
    > 🐞 **Fix**: Allows successful processing of PDS responses.

- Fixed EMIS Diagnostic Order records selection to only include relevant observations, improving data quality. *[SQL, [PR 2606](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2606), [WI 24754](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24754)]*
    > 🐞 **Fix**: Prevents inclusion of unrelated diagnostic records.

---

### Refactoring

- Removed old procedures and objects no longer in use, including TPP v155 generated objects, for cleaner codebase and improved maintainability. *[SQL, [PR 2709](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2709), [WI 25250](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/25250); PR 2644](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2644), [WI 24616](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24616); PR 2610](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2610), [WI 24616](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24616); PR 2631](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2631), [WI 24616](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24616)]*

- Moved existing monitoring views to a new schema for better organisation. *[SQL, [PR 2636](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2636), [WI 24767](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/24767)]*

- Updated pull request templates for improved documentation and review process. *[SQL, [PR 2617](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/2617)]; SynapseWorkspace, [PR 2618](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/2618)]*

---

### Inputs

This change note was automatically produced from:

- 70 Pull Requests
- 54 Work Items
- 616 Commits