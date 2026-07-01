# Release 170 - Release date: 2025-07-23

> [!NOTE]
> The below is a summary of the changes from [release 169](Release-169.md) (previous pre-production release)

## ℹ️ Summary

- This release resolves one major bug in the service that prevented the distribution of data from release 169
- No user reported bugs are resolved by this release

## 🐞 Bug Fixes

- Changed `IsConfidential` column in CDM to a nullable column. *[SQL, PR2319, WI23604]*
  > 🐞 ***Fixes***: [DevOps Bug 23604: Common Model failed](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/236034). This fixes a minor bug in the PDS request files, whereby duplicative request entries were created. This was already handled by sequencing operations, but this bug reduces the storage and processing pressure/overhead this would otherwise create.
