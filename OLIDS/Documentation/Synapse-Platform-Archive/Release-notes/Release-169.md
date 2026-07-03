# Release 169 - Release date: 2025-07-19

> [!NOTE]
> The below is a summary of the changes from [release 168](Release-168.md) (previous pre-production release)

## 🐞 Bug Fixes

- Changesd `Select_Request_Rows` operation in Registrar service to apply distinct operation to resultset. *[SQL, PR2314, WI23527]*
  > 🐞 ***Fixes***: [DevOps Bug 23527: Duplicate request rows in PDS request files](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23527). This fixes a minor bug in the PDS request files, whereby duplicative request entries were created. This was already handled by sequencing operations, but this bug reduces the storage and processing pressure/overhead this would otherwise create.

- Remove comparison of `Display` value from Concept merge operations. *[SQL, PR2311, WI23451]*
  > 🐞 ***Fixes***: [DevOps Bug 23566: Display comparison causing duplication of mappings](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23566). This change ensures that: Concepts created via the unmapped code pipeline are updated with the correct Display value when the relevant terminology resource is processed, without creating duplicates and that the Concept table remains free of duplicate entries, which will also prevent duplicate mappings in downstream.

- Added filter to preprocessor service to ignore entire batches that contain any failures *[SQL, PR2309, WI22886]*
  > 🐞 ***Fixes***: [DevOps problem 23525: Preprocessor failing on malformed CSV](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23525) This allows preprocessor service to continue publishing batches that contain well formed CSVs, when one batch in the processed group fails.

- Set row delimiter for Regisrar Address Response files with LF only. *[Synapse, PR2307, WI23237]*
  > 🐞 ***Fixes***: [DevOps 23237: RegistrarAddress response failing](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23237) This alters a discrepancy with the planned UPRN response files.

- Fix for issue with CSV file reader function and escape characters. *[Synapse, PR2308, WI23525]*
  > 🐞 ***Fixes***: [DevOps problem 23525: Preprocessor failing on malformed CSV](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/23525) This allows preprocessor service to continue publishing batches that contain well formed CSVs, when one batch in the processed group fails.
