# Release [Release-289] - Release Date: 2026-03-20

> [!NOTE]
> The below is a summary of the changes since the previous release [Release-286](Release-286.md).

- *Environment release date: 2026-03-20*
- *Release Date to consumers: TBC*
- *Release note published: 2026-03-20*

> [!NOTE]
> This release consolidates changes from intermediate builds Release-287 and Release-288, which were staged deployments of the PDS response handling and collation fixes (see below) while the full solution was being completed.

## Summary

Release 289 has a clear theme: **hardening the reliability of data exchange with external systems and the Versioner deployment pipeline**. The two largest bodies of work — fixing how PDS response files are read, and eliminating the Versioner nullability flip-flop — together account for the majority of the 48 commits in this release and directly resolve issues that were causing processing failures or corrupted NHS number data in production.

Alongside the hardening work, this release also delivers two significant new capabilities: a **bulk export pipeline** that allows the entire Versioner-to-CDM dataset to be re-exported in a single operation (critical for resolving data gaps), and **person subscriber count views** that provide the Fabric team with per-ICB patient numbers for both PID and Pseudo AIRLOCK outputs.

### New Features

- **Person subscriber count views for PID and Pseudo AIRLOCK** — Two new OLIDS metadata views (`OLIDS_METADATA_PERSON_SUBSCRIBER_COUNT_PID` and `OLIDS_METADATA_PERSON_SUBSCRIBER_COUNT_PSEUDO`) have been added, delivered as Synapse notebooks. Each view counts the number of patients per subscriber (London ICB) and endpoint, with ORG_NAME mapped from subscriber codes (QKK = NHS South East London ICB, QMF = NHS North East London ICB, QMJ = NHS North Central London ICB, QRV = NHS North West London ICB, QWE = NHS South West London ICB). Records carry a deterministic UUID-style `ID` derived from a SHA2-256 hash of `subscriberCode:endpointCode`, enabling stable lineage tracking across refreshes. S-flag (sensitive) patient filtering is maintained. The PID view is transmitted to PID AIRLOCK; the Pseudo view to Pseudo AIRLOCK. *[SynapseWorkspace, [PR#3311](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3311), [WI#26533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26533)]*  
  > ✨ ***Feature:*** Provides the Fabric team with per-ICB patient counts for both AIRLOCK outputs, with stable identifiers for cross-release lineage tracking.

- **Versioner bulk extract pipeline (Versioner → CDM)** — A new Synapse pipeline `versioner_process_bulk` can now export all latest records from Versioner to CDM in a single parameterised run. The pipeline accepts `source_dataset_name` and `source_dataset_version`, calls `[versioner].[get_tables_to_process_for_batch]` to retrieve all tables in scope, then iterates through each CDM table with a `ForEach` activity to export the most recent state. Previously, only incremental per-batch exports were available, leaving no mechanism to fill data gaps other than reprocessing individual batches. *[SynapseWorkspace, [PR#3306](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3306), [WI#27890](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27890)]*  
  > ✨ ***Feature:*** Enables a full re-sync of any CDM dataset in one operation, significantly simplifying gap resolution and downstream re-processing workflows.

- **Synapse SQL Pool management scripts added to source control** — Four PowerShell scripts for managing the Azure Synapse dedicated SQL Pool lifecycle are now versioned in the SQL repository: `PauseSynapseSqlPool.ps1`, `ResumeSynapseSqlPool.ps1`, `SnapshotSynapseSqlPool.ps1`, and `RestoreSynapseSqlPoolBetweenEnvironments.ps1`. Previously managed ad-hoc, these scripts can now be reliably used and updated as part of the standard release pipeline. *[SQL, [PR#3321](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3321), [WI#28044](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28044)]*  
  > ✨ ***Feature:*** Pool management operations (pause, resume, snapshot, cross-environment restore) are now source-controlled, auditable, and consistently available to the deployment team.

### Bug Fixes

- **PDS response files now converted from CSV to Parquet before processing, and read by column name** — PDS response files are returned as CSV by the NHS Personal Demographics Service, but the column order within those CSVs is not guaranteed to be consistent across responses. Previously, `OPENROWSET` read them using `FIRSTROW=2` (ordinal position binding), which caused a critical data corruption bug: when PDS shifted column order, the `[UNIQUE REFERENCE]` column — a GUID field containing only four distinct values — was silently read into the `[REQ_NHS_NUMBER]` position, writing incorrect NHS numbers into patient records. The fix introduces a new stored procedure `[Patient].[Convert_Response_File]` that reads each incoming CSV by explicit column name using `HEADER_ROW=TRUE` and writes it out as a typed Parquet external table in ADLS. The main `[Patient].[Get_Unprocessed_Response_Data]` procedure now reads from `*.parquet` rather than `*.csv`, ensuring column binding is always by name via the Parquet schema. *[SQL, [PR#3327](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3327), [PR#3322](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3322), [WI#27935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27935)]*  
  > 🐞 ***Fix:*** Eliminates the risk of NHS numbers being silently replaced with GUID values when PDS returns columns in an unexpected order. All PDS response files are now processed via a stable, name-bound Parquet intermediate, regardless of the schema variation in the source CSV.

- **New Synapse pipeline and trigger to orchestrate the CSV-to-Parquet conversion step** — A new Synapse pipeline `Registrar Patient Response Convert File` wraps the `[Patient].[Convert_Response_File]` stored procedure call. The existing `Registrar Patient Response Batch Process` and `Registrar Patient Response Master` pipelines have been updated to invoke the conversion pipeline as a prerequisite step before processing begins. The `pds_out` trigger has been updated accordingly. *[SynapseWorkspace, [PR#3315](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3315), [WI#27935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27935)]*  
  > 🐞 ***Fix:*** The pipeline layer now correctly orchestrates the conversion step so that no downstream processing can begin until the Parquet representation of each PDS batch is available and schema-validated.

- **Versioner `_Latest` and `_Metadata` table nullability fixed to stop deployment flip-flopping** — The Jinja2 templates for `_Latest` and `_Metadata` tables defined four metadata columns (`LDSFileId`, `LDSBatchId`, `LDSDateTimeSupplied`, `LDSFilepath`) as `NOT NULL`. In practice these columns legitimately contain nulls ("data holes" where source file metadata was not available at processing time), so the deployed tables held `NULL` definitions. Every deployment therefore detected a schema difference against the template's `NOT NULL` definition and attempted to alter the columns — causing repeated failed deployments and requiring constant manual intervention. The fix changes these four columns to `NULL` in both `_Latest` and `_Metadata` templates, with a `-- ToDo: Decide what to do with the data holes` comment to track the longer-term data quality question. All ~46 generated table definitions across the EMIS schema have been regenerated. *[SQL, [PR#3329](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3329), [WI#28058](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28058), [WI#28080](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28080)]*  
  > 🐞 ***Fix:*** Deployments no longer fail or require manual intervention due to nullability conflicts on metadata columns. The schema definition now reflects actual runtime data, removing a persistent source of friction from every release cycle.

- **Collation conflict in Versioner `LDSRecordHash` resolved for TPP data** — The `LDSRecordHash` is computed as `SHA2_256(CONCAT_WS('#', col1, col2, ...))` across all version-hash columns. TPP supplies some columns in a case-sensitive (CS) SQL collation, and SQL Server raises a collation conflict error when `CONCAT_WS` is asked to combine strings of mixed collations. The fix updates the `versioner_rawstaged_view_hash` Jinja2 template to append `COLLATE SQL_Latin1_General_CP1_CI_AS` to any column flagged as `isCaseSensitive: true` in its schema definition, normalising all inputs to the same collation before the hash is computed. *[SQL, [PR#3326](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3326), [WI#28059](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28059)]*  
  > 🐞 ***Fix:*** TPP data can now be versioned without raising collation errors. The fix is template-driven, so any future source with case-sensitive columns will be handled automatically provided the `isCaseSensitive` property is set in the column definition.

- **Clear down scripts rewritten with correct scoping and type declarations** — The pre-deployment clear down scripts previously had two defects: the dynamic SQL accumulation variable was declared as `NVARCHAR` (without a length) rather than `NVARCHAR(MAX)`, silently truncating the generated SQL for large schemas; and the table selection logic lacked the condition to restrict `RawContinuum` truncation to `_Temp` tables only, creating a risk of accidentally truncating `_Latest` and `_Metadata` tables. The new `ClearDownVersioner.PreDeployment.sql` and `ClearDownCommonModel.PreDeployment.sql` scripts fix both issues: they use `NVARCHAR(MAX)` throughout and explicitly scope `RawContinuum` truncation to `[T].[name] LIKE '%_Temp'`. *[SQL, [PR#3319](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3319), [WI#28013](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28013)]*  
  > 🐞 ***Fix:*** Eliminates the risk of the clear down script silently truncating incomplete SQL (due to type length overflow) or accidentally clearing tables it should not touch. The scripts are now safe to run without manual review of the generated SQL.

### Refactoring

- **Typecasted export procedures simplified to join only the `_Latest` table** — The export stored procedures (generated from the `versioner_typecasted_procedure_export` Jinja2 template) previously joined both `_Metadata` and `_Latest` to retrieve audit columns (`LDSRecordId`, `LDSFileId`, `LDSBatchId`, etc.). Since `_Latest` holds the same metadata columns as `_Metadata` for the current record, the join to `_Metadata` was redundant. The template has been updated to read all metadata from `_Latest` only, removing one join per export call and simplifying the SQL. This change is bundled in the same PR as the nullability fix above. *[SQL, [PR#3329](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3329)]*  
  > ♻️ ***Refactor:*** Reduces query complexity and removes a redundant join from every typecasted export, which is executed for each CDM table on each versioner run.

### Inputs

This change note was produced with analysis of source changes across:

- 9 Pull Requests
- 10 Work Items
- 48 Commits

## Full Details

The full details of all the Pull Requests and their associated Work Items included in this release are as follows:
- [PR 3329](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3329): HotFix: Versioner Latest Table Flip Flopping Null/NotNull & Typecasted Extract Optimisation
  - Bug [WI 28058](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28058): Latest tables in Versioner have column nullability flipflopping
  - Bug [WI 28080](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28080): Versioner Deployment - Latest Metadata tables always different to deployed
- [PR 3326](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3326): HotFix: Handle collation for case-sensitive columns in Versioner LDSRecordHash
  - Bug [WI 28059](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28059): TPP unable to process due to collation error
- [PR 3327](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3327): PDS responses must be read by column name not ordinal position > convert to parquet before read
  - User Story [WI 27935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27935): PDS responses must be read by column name not ordinal position > convert to parquet before read
- [PR 3322](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3322): PDS responses must be read by column name not ordinal position > convert to parquet before read
  - User Story [WI 27935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27935): PDS responses must be read by column name not ordinal position > convert to parquet before read
- [PR 3321](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3321): Add PowerShell scripts for Release Pipeline to Repo
  - Task [WI 28044](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28044): Add Deployment Scripts to Repo
- [PR 3319](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SQL/pullrequest/3319): Fix clear down scripts
  - Task [WI 28013](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/28013): Fix ClearDown Scripts
- [PR 3315](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3315): PDS responses must be read by column name not ordinal position > convert to parquet before read
  - User Story [WI 27935](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27935): PDS responses must be read by column name not ordinal position > convert to parquet before read
- [PR 3311](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3311): WIP: Add 2 new tables for Person subscriber count for PID and Psuedo AIRLOCK
  - User Story [WI 26533](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/26533): Additional reference data for Fabric
- [PR 3306](https://dev.azure.com/NELAnalytics/LondonDataService/_git/SynapseWorkspace/pullrequest/3306): Bulk Extract from Versioner to CDM
  - Task [WI 27890](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/27890): Create Versioner Bulk Extract Pipeline

