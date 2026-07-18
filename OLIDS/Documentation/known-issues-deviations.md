# Known issues and deviations

- Programme: London Data Service (LDS) Replatforming — OLIDS
- Purpose: This log records issues and known behavioural deviations identified ahead of User Acceptance Testing (UAT), so testers can distinguish genuine defects from expected differences before raising tickets.

## 1. Known Issues

> [!IMPORTANT]
> **This list represents known genuine defects or limitations of the service**.
> <br>Testers should **not** re-raise these as new bugs, but should report any impact beyond what is described below.

| Ref | Area | Description | Impact on UAT | Status | Owner |
| --- | --- | --- | --- | --- | --- |
| KI01 | External Service Data — Refresh Currency | External service data is not refreshed daily. Last date of processing: <br>- UPRN: 27-02-2026, <br>- NDOO: 27-02-2026, <br>- PDS: 27-02-2026 | UPRN / NDOO: no impact beyond missing data. PDS: reduced referential integrity for records linking to the Person table. | ![Status](https://img.shields.io/badge/Status-Open-red) <br>[![DevOps](https://img.shields.io/badge/DevOps-29779-blue)](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/29779) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI02 | Appointment Records — Orphaned References | Due to how EMIS issues appointment records, an appointment may reference a patient no longer registered at the practice. These records fail referential integrity and appear as orphaned. This issue is not considered a defect and therefore will not be closed | Expected orphaned/failed-RI records on Appointment. Source-system (EMIS) issue; not resolvable by the LDS team. | ![Status](https://img.shields.io/badge/Status-Accepted-darkgreen) <br>[![DevOps](https://img.shields.io/badge/DevOps-29780-blue)](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/29780) | n/a |
| KI03 | Organisation / Practitioner — Row Access Policy | Row-level security policies have been incorrectly applied to the Organisation and Practitioner tables. May cause referential integrity issues for patients referred to services, or treated by practitioners, whose records belong to a different ICB. | Cross-ICB referral/treatment relationships may appear broken. | ![Status](https://img.shields.io/badge/Status-Fixed-green) <br>[![DevOps](https://img.shields.io/badge/DevOps-29781-blue)](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/29781) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI04 | Row-access policy query performance | Row-level security policies are applied per table, and if queries are not carefully constructed they can have deleterious effects on query runtime speed/performance. Some users have reported that 10 minute timeouts have been reached. | Users are asked to ensure that queries are constructed so as to scan the table once only, and project results up for final presentation style transforms | ![Status](https://img.shields.io/badge/Status-Testing-yellow) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI05 | Historical Episodes of Care (Registrations) | EMIS data is supplied in such a way that only the current status of a patient record, including their registration date, is known. If a patient has previously been registered with the practice within the preceding five-year window then this will not be visible to the service, only the latest registration will be. A fix using the new features within the `Admin_PatientHistory` file will be planned as an enhancement after UAT of both EMIS and TPP replatforming | Users are advised to compare current registration counts only, and to expect a higher degree of variance for historical registration counts for time periods over 1 month | ![Status](https://img.shields.io/badge/Status-Enhancement-blue) - Enhancement planned for implementation after UAT. | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI06 | Patients will only ever match to PDS responses that share the same NHS Number | The `PATIENT_PERSON` model uses the same method used in `PERSON` to generate the expected mapped `PERSON_ID`. Where a PDS trace results in a `MATCHED_NHS_NO` that differs from the requesting EMIS record's NHS number, the resulting `PERSON.ID` value will differ. | Users may see a higher than normal number of EMIS based 'stub' person records, rather than person records based on PDS responses. | ![Status](https://img.shields.io/badge/Status-Open-red) <br>[![DevOps](https://img.shields.io/badge/DevOps-29792-blue)](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/29792) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI07 | Location records absent | (Raised in error) A transform defect was detected that appeared to show a reduction on row counts. This has been reviewed and the defect notice removed as it was raised in error. | Users can see all expected Location resources in the Location table | ![Status](https://img.shields.io/badge/Status-Closed-green) <br>[![DevOps](https://img.shields.io/badge/DevOps-29804-blue)](https://dev.azure.com/NELAnalytics/LondonDataService/_workitems/edit/29804) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |

## 2. Deviations from DDS (Not Defects)

> [!IMPORTANT]
> **Intentional or explainable differences between LDS OLIDS and DDS Compass — expected behaviour, not bugs.**
> <br>Flagged so testers do **not** log them as issues.

| Ref | Area | Description | Tester Guidance |
| --- | --- | --- | --- |
| DV01 | Referral Request | Outgoing referral information does not match DDS data. LDS has implemented logic documented as equivalent to DDS, but output does not reconcile exactly against NEL DDS. | Do not raise as a defect. Report any discrepancy that appears to go beyond a like-for-like comparison mismatch. |
| DV02 | Observation | In DDS, Observation records also marked as Problems produce a duplicate record. OLIDS has implemented logic to remove this duplication. | Expect fewer Observation records in OLIDS than DDS for Problem-linked observations. This is by design. |
| DV03 | Masked Columns | Due to Snowflake masking limitations, certain columns (e.g. date fields) return a default value rather than NULL or a masked placeholder such as '*****'. | Do not report default masked values (e.g. 1900-01-01 style dates) as data quality issues. |
