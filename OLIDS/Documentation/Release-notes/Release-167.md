# Release 167 - Release date: 2025-07-15

> [!NOTE]
> The below is a summary of the changes from release 156 (previous pre-production release)

## ✨ New Features

- Added value set tagging views to OLID output, enabling better representation of relationships between terminology value sets and other data. *[SQL, PR2257, WI22021]*
  > ✨ ***Feature**: This will improve through put for value set tagging when these are released.*

- Added ValueSet tagging output to the lakehouse, supporting better linkage to OLIDS tables. *[SQL, PR2257, WI22021]*
  > ✨ ***Feature**: This work is in preparation to release value set tags as supplementary data feed.*

- Added auto-pause activity to Synapse pipelines to automatically pause databases on master pipeline failure, preventing unnecessary resource usage. *[SynapseWorkspace, PR2261, WI22982, WI22983]*
  > ✨ ***Feature**: This an internal feature enhancement to reduce cost pressures and add cost controls.*

## 🧰 Improvements

- Updated and cleaned up TerminologyResource stored procedures. *[SQL, PR2257, WI22021]*
    > 🎯 ***Impact**: None. Internal maintenance*

- Updated procedures and views to use new remapped metadata view instead of original columns. *[SQL, PR2262, WI22908]*
    > 🎯 ***Impact**: Internal consistency in use of metadata*

- General cleanup of unused resources and removal of obsolete hash functions. *[SQL, PR2263, WI23078]*
    > 🎯 ***Impact**: None. Internal maintenance*

## 🐞 Bug Fixes

- Updated file validator to halt pre-processing if files have missing or unexpected fields, ensuring only valid files are processed. *[SynapseWorkspace, PR2265, WI22968]*
  > 🐞 ***Fixes***: [DevOps Item 22204: TC06_FV: FileValidator: Invalid Row - Missing Column Failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22204) This ensures that the file validation process correctly halts processing where file schema does not match the expected schema based on supplied information from the vendor.

- Enhanced file loading to handle empty CSV files and ensure column headers are processed correctly, even when wrapped in quotes. *[SynapseWorkspace, PR2285, WI23330]*
  > 🐞 ***Fixes***: [DevOps Item 22204: TC06_FV: FileValidator: Invalid Row - Missing Column Failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22204) This ensures that the file validation process correctly halts processing where file schema does not match the expected schema based on supplied information from the vendor.

- Fixed issue with rows containing invalid data not being removed from final output after pre-processing. *[SynapseWorkspace, PR2258, WI22336]*
  > 🐞 ***Fixes***: [DevOps Item 22204: TC06_FV: FileValidator: Invalid Row - Missing Column Failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22204) This ensures that the file validation process correctly halts processing where file schema does not match the expected schema based on supplied information from the vendor.

- Added PatientHash and PostcodeHash to Lakehouse and CommonModel for improved data linkage. *[SQL, PR2259, WI23067]*
  > 🎯 ***Impact**: This allows the common modelling service to leverage the patient hash to return the SK_PatientID.*
  >
  > 🐞 ***Fixes***: This fixes [GitHub issue: #20 SK_PatientID column in patient is always NULL](https://github.com/NHSISL/Datasets/issues/20)

- Fixed issue where Registrar records were missing LDSDataSetId, ensuring correct population of this field. *[SQL, PR2268, PR2284, WI23092]*
  > 🐞 ***Fixes***: This fixes missing dataset ID value from registrar responses, directly impacting issue [#17 Person table is empty](https://github.com/NHSISL/Datasets/issues/17)

- Fixed Registrar bugs where staging tables did not match output, columns were in the wrong order, and LDSDatasetId was null. *[SQL, PR2255, WI22978]*
  > 🐞 ***Fixes***: This fixes [GitHub issue #17: Person table is empty](https://github.com/NHSISL/Datasets/issues/17) due to missing dataset ID value from registrar responses.

- Addressed issue causing EpisodeOfCare records to be missing for some patients, ensuring all EMIS patients have at least one episode of care. *[SQL, PR2267, WI22886]*
  > 🐞 ***Fixes***: This fixes [Github issue #16: Not all patients have an episode of care record](https://github.com/NHSISL/Datasets/issues/16)

- Removed CDM_pcd tables from reports to prevent downstream processing issues when tables are empty. *[SQL, PR2272]*
  > 🐞 ***Fixes***: This fixes issue with concept map reporting, which was blocked by empty PCD tables

- Fixed formatting error in Registrar Address Request CSVs where fields with commas were not properly wrapped in quotes. *[SynapseWorkspace, PR2279, WI23237]*
    > 🐞 ***Fixes***: This fixes DevOps item [RegistrarAddressRequest CSVs have formatting error](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23237) causing issue with integration with the Assign Address Matching Service, otherwise preventing processing of UPRN address matching.

- Fixed issue where filters on deleted records in left joins were inadvertently removing valid references, resolving orphaned observation records. *[SQL, PR2254, WI22763, WI22809]*
  > 🐞 ***Fixes***: This fixes [Github issue #21: Orphaned Observation records](https://github.com/NHSISL/Datasets/issues/21)

- Removed UnstructuredPostalAddress from masked PatientUPRN objects as it was redacted and not useful. *[SQL, PR2256, WI23060]*
  > 🐞 ***Fixes***: This fixes issue with presence of PCD field in the planned masked UPRN output.

- Converted scalar functions to inline table-valued functions for compatibility with Synapse Serverless. *[SQL, PR2264, WI23078]*
  > 🐞 ***Fixes***: Unable to deploy salted Hash lookup to SQL Serverless Pools

- Added missing Salt SqlVariable to CommonModel and Lakehouse databases, and cleaned up unused resources. *[SQL, PR2263, WI23078]*
  > 🐞 ***Fixes***: Unable to deploy salted Hash lookup to SQL Serverless Pools

- Fixed issue with external data source by removing Hadoop and adding Managed Identity, resolving failures in CommonModel and Lakehouse databases. *[SQL, PR2266, WI23078]*
  > 🐞 ***Fixes***: Unable to deploy salted Hash lookup to SQL Serverless Pools

- Fixed issue with file validator not removing invalid rows when no replacement values were specified. *[SynapseWorkspace, PR2258, WI22336]*
  > 🐞 ***Fixes***: DevOps [item 22205: TC05_FV: File Validator Invalid Data - mismatching data datatype failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/22205) 
