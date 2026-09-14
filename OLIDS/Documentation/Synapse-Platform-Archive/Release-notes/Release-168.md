# Release 168 - Release date: 2025-07-18

> [!NOTE]
> The below is a summary of the changes from [release 167](Release-167.md) (previous pre-production release)

## ✨ New Features

- Changed UPRN schemas to add new fields, supporting better address data integration. *[SQL, PR2303, WI22870]*
    > ✨ ***Feature**: preparations to surface Latitude, Longitude and Coordinate data in identifiable UPRN matching*

- Added new database objects for the Common Model, supporting Registrar and Terminology enhancements and fixes below. *[SQL, PR2305, WI23459]*

- Introduced event logging capabilities for the new notebook-based column masking service, enabling tracking of masking events in the metadata database. *[SQL, PR2282, WI23307]*
    > ✨ ***Feature**: preparations to migrate Column Masker service from dataflow to spark technologies*

## 🧰 Improvements

- Changed procedures to handle unknown concept codes, ensuring previously unseen codes are processed correctly. *[SQL, PR2301, WI21798]*
  > 🎯 ***Impact**: removes deprecated features.*

- Updated pipeline concurrency settings to avoid race conditions in the Common Model Master pipeline. *[SynapseWorkspace, PR2296, WI23407]*

- Improved support for boolean types in Azure SQL functions for notebook-based procedures. *[SynapseWorkspace, PR2283, WI23307]*

## 🐞 Bug Fixes

- Added LDSBusinessKey field to the CDM AppointmentPractitioner view to ensure correct population in delta lake views. *[SQL, PR2291, WI23419, WI23420]*
  > 🐞 ***Fixes***: [DevOps Bug 23419: LDSBusinessKey missing from Appointment Practitioner, Organisation and other OLIDS tables](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23419). This fixes a gap in the dataset schema not showing the PDS trace responding NHS number pseudonym.

- Added `SK_PatientID` fields for requested and matched NHS numbers in OLIDS person tables for improved traceability. *[SQL, PR2304, WI23451]*
  > 🐞 ***Fixes***: [DevOps Bug 23451: SK_PatientIDs for person table using incorrect source columns, and only showing requested NHS number](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23451). This fixes a gap in the dataset schema not showing the PDS trace responding NHS number pseudonym.

- Removed filter limiting views to only the latest patient record, ensuring all valid records are shown. *[SQL, PR2300, WI22886]*
  > 🐞 ***Fixes***: [GitHub problem 19: Medication Orders contains too few records](https://github.com/NHSISL/Datasets/issues/19) This ensures that all records in the delta lake are transmitted.

- Fixed temp table creation bug affecting columnstore indexes. *[SQL, PR2294, WI23214]*
  > 🐞 ***Fixes***: [DevOps 23214: Terminology report dataset failure](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23214) This removes the duplicate source of data feed to the report from pcd equivalents to masked objects.

- Fixed typo and aliased property classification field to match Compass, ensuring consistency in OLIDS view fields. *[SQL, PR2289, WI22539]*
- Removed erroneous fields causing binding errors in Person views, preventing data issues. *[SQL, PR2288, WI22539, WI22752, WI22753]*
  > 🐞 ***Fixes***: [GitHub problem 17: Person table and Patient_Person table is empty](https://github.com/NHSISL/Datasets/issues/17) These fixes allow for us to process PDS responses.

- Fixed synchronisation of column naming to match lakehouse parquet files, resolving issues where columns appeared as NULL. *[SQL, PR2293, WI23422]*
  > 🐞 ***Fixes***: [DevOps problem 23422: Person ID is null in allergy_intolerance](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23422) This resolves a silent error whereby the delta lake read in SQL would fail to correctly read columns with a different cased column name (i.e. "ColumnName" vs "columnname").

- Added a check to prevent null lengths in configuration tables, avoiding metadata generation problems. *[SQL, PR2287, WI23189]*
  > 🐞 ***Fixes***: [DevOps problem 23189: Metadata Objects 2 scripts: pipeline failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23189) This resolves an error whereby the deployment of configuration variables per environment failed.

- Joined SK_PatientId of associated patient to Person objects for improved linkage. *[SQL, PR2297, WI23402]*
  > 🐞 ***Fixes***: [DevOps problem 23402: Patient Response file move error](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23402) This resolves an error with file movement operations blocking the handling of PDS responses.
  > 🐞 ***Fixes***: [GitHub problem 17: Person table and Patient_Person table is empty](https://github.com/NHSISL/Datasets/issues/17) These fixes allow for us to process PDS responses.

- Set output folder for Registrar Requests to avoid unnecessary subfolder creation. *[SynapseWorkspace, PR2295, WI23402, WI23403]*
- Fixed issues with Registrar response files and address response parsing errors in pipelines. *[SynapseWorkspace, PR2295, WI23402, WI23403]*
  > 🐞 ***Fixes***: [DevOps problem 23403: Patient Address file move error](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23403) This resolves an error with file movement operations blocking the handling of URPN address matching responses.
