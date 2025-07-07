# Release 156 - Release date: 2025-07-07

The below is a summary of the changes from release 154 (previous pre-production release)

## ✨ New Features

- Added views for monitoring PrimaryCareTPP publisher status and patient counts, enabling better reporting on data received from TPP (SystmOne) extraction groups. *[SQL !2225, work item #22777]*
  > ✨ ***Feature**: This will allow LDS to present the onboarding status for TPP practices in our Power BI dashboard.*

- Added missing triggers for ConceptMap, CodeSystem, and ValueSet in Terminology Ingress. *[SynapseWorkspace, !2230]*
  > ✨ ***Feature**: This will allow the operational team to automatically process of terminology artefacts, currently handled through manual intervention.*

- Introduced a pull request template to help detail changes and impacts for end users and stakeholders. *[SQL, !2232, #22872, #22873]*
  > ✨ ***Feature**: This an internal feature enhancement to ensure clarity in our future release notes and automations thereof.*

## 🧰 Improvements

- Updates to delta lake table list and related views, adding more useful fields and calculated columns for future enhancements and easier monitoring. *[SQL, !2237, #22744]*
  > 🎯 ***Impact**: This an internal enhancement to improve information available in operational views.*

- Enhanced performance for NCL data loading with new workload classifiers and updates to procedures and views, improving throughput and efficiency. *[SQL, !2229, #22785,
#22786]*
  > 🎯 ***Impact**: This should improve the throughput of data through the Versioner and Common-Model processes (SQL dependent processes).*

- Increased ForEach loop parallelism to 50 in CommonModel pipelines for higher throughput. *[SynapseWorkspace, !2227, #22787; !2222, #22742]*
  > 🎯 ***Impact**: This should improve the throughput of data through the Common-Model processes.*

- Direct delta lake build and transmission from SQL server database tables, streamlining data flow and reducing file handling steps. *[SynapseWorkspace, !2236, #22744]*
  > 🎯 ***Impact**: This should improve the throughput of data through the delta lake build processes and reduce the number of fail points.*

- Updated environment values for improved configuration management. *[SQL, !2224, #22611]*
- Changed Patient UPRN view naming for consistency and traceability. *[SQL, !2214, #18475]*
    > 🎯 ***Impact**: internal consistency change.*

- Updates to pipelines to allow pseudo hashing Salt value to be added at deployment for the File Masker process, enhancing data security. *[SynapseWorkspace, !2218, #22735]*
    > 🎯 ***Impact**: security change.*

- Updates to support delta lake import after main CDM processing and to optimise handling of PCD vs non-PCD tables. *[SynapseWorkspace]*

## 🐞 Bug Fixes

- Changed Registrar Request header and copy activities to match new requirements, including encoding and field updates. *[SQL, !2233, #22539; SynapseWorkspace, !2238, #2
2539]*
    > 🐞 ***Fixes**: The responses from PDS trace, UPRN match and National Opt-Out tracking requests where all empty. This is a fix for one cause of / factor impeding this issue. Please note however that Person_ID and person related objects will remain unpopulated at this time.*

- Fixed bug causing empty Registrar responses for PDS, UPRN, and NDOO requests. *[SQL, !2233, #22539; SynapseWorkspace, !2238, #22539]*
    > 🐞 ***Fixes**: The responses from PDS trace, UPRN match and National Opt-Out tracking requests where all empty. This is a fix for one cause of / factor impeding this issue. Please note however that Person_ID and person related objects will remain unpopulated at this time.*

- Added or amended priority condition in OLIDS masked and PCD views for improved data joins. *[SQL, !2211, #22726]*
    > 🐞 ***Fixes**: This fixes an issue that prevents the population of person_id values from OLIDS tables. This is a fix for one cause of / factor impeding this issue. Please note however that Person_ID and person related objects will remain unpopulated at this time.*

- Added dummy `CDM_masked.PatientPerson` procedure to prevent failures in Common Model Loop Tables activities. This was preventing the processing of the patient person tables within the common data model processing. *[SQL, !2208, #22709]* 
    > 🐞 ***Fixes**: This will unblock the processing of OLIDS PatientPerson objects. This is a fix for one cause of / factor impeding this issue. Please note however that Person_ID and person related objects will remain unpopulated at this time.*

- Fixed issue where dynamic SQL 'COPY INTO' returned NULL row counts for new label queries, resolving data load failures into Versioner and CommonModel Synapse databases. *[SQL, !2244, #22932, #22937]*
    > 🐞 ***Fixes**: This fixes an issue encountered when loading real data for the first time.*

- Fixed EMIS PatientAddress Transform view to use hashed postcode for PostCodeHash. *[SQL, !2231, #22862]*
    > 🐞 ***Fixes**: hashed postcode was previously coded as a placeholder 'null' value.*

- Fixed event ID parameter name error in Common Model Queue Files pipeline, preventing repeated pipeline runs. *[SynapseWorkspace, !2228, #22782]*
    > 🐞 ***Fixes**: This fixes an issue that caused a pipeline to hang continuously waiting for a pipeline that would never end.*

- Fixed issue with file validator incorrectly checking for missing/unexpected columns. *[SynapseWorkspace, !2239, #22924, #22929]*
    > 🐞 ***Fixes**: schema validation was not triggered successfully. This fixes the issue, the validation process should now detect unexpected schema misalignment in recieved data.*

- Ensured unique LDSBusinessKey/ID values are added to Versioner RawContinuum LDSBusinessID registers, preventing duplicate patient records. *[SQL, !2212, #22680; !2207,
#22680]*
    > 🐞 ***Fixes**: This prevents duplicative business key/ID values from being generated into the dataset continuum.*

- Fixed issue with file creation not triggering events in the Common Model outbox. *[SynapseWorkspace, !2213, #22706]*
    > 🐞 ***Fixes**: This will allow automated processing to continue without manual intervention.*

- Switched FileRegister Replay to old overwrite method to resolve issues with LDSBatchReady.txt triggers. *[SynapseWorkspace, !2209, #22658]*
    > 🐞 ***Fixes**: File Register service was triggering twice, and was not triggered at all if no File Register records existed at all (empty initial table).*

- Fixed delta lake builder error by explicitly specifying pool/size and authentication type. *[SynapseWorkspace, !2216, #22734]*
    > 🐞 ***Fixes**: Delta lake builder process was failing due to authentication errors.*

- Fixed issue with Common Model Master pipeline failing to start due to nested repetition actions. *[SynapseWorkspace, !2247, #22938]*
    > 🐞 ***Fixes**: Moving from implicit seqeuential processing of CDM files to parallel running introduced a new error. This resolves the error.*

- Partial fix to duplication problem in MedicationStatement by changing join to use Dedupe Transform view. *[SQL, !2223, #22765]*
    > 🐞 ***Fixes**: partial fix for duplicative OLIDS Medication Statement records.*

- Changed MedicationStatement to use Coding_ClinicalCode for improved record deduplication.
    > 🐞 ***Fixes**: partial fix for duplicative OLIDS Medication Statement records.*

- Investigated and resolved issue with CommonModel outbox containing duplicate BatchId subfolders. *[SynapseWorkspace, !2205, #22701; !2206, #22701]*
    > 🐞 ***Fixes**: Common model process produced an erroneous batch file due to misaligned parameter settings. This is now fixed.*
