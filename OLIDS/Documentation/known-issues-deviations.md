# Known issues and deviations

- Programme: London Data Service (LDS) Replatforming — OLIDS
- Purpose: This log records issues and known behavioural deviations identified ahead of User Acceptance Testing (UAT), so testers can distinguish genuine defects from expected differences before raising tickets.

## 1. Known Issues

> [!IMPORTANT]
> **This list represents known genuine defects or limitations of the service**.
> <br>Testers should **not** re-raise these as new bugs, but should report any impact beyond what is described below.

| Ref | Area | Description | Impact on UAT | Status | Owner |
| --- | --- | --- | --- | --- | --- |
| KI01 | External Service Data — Refresh Currency | External service data is not refreshed daily. Last date of processing: <br>- UPRN: [TBC], <br>- NDOO: [TBC], <br>- PDS: [TBC] | UPRN / NDOO: no impact beyond missing data. PDS: reduced referential integrity for records linking to the Person table. | ![Status=Draft](https://img.shields.io/badge/Open-red) | ![Team=LDSTeam](https://img.shields.io/badge/LDS_Team-00ADC3) |
| KI02 | Appointment Records — Orphaned References | Due to how EMIS issues appointment records, an appointment may reference a patient no longer registered at the practice. These records fail referential integrity and appear as orphaned. This issue is not considered a defect and therefore will not be closed | Expected orphaned/failed-RI records on Appointment. Source-system (EMIS) issue; not resolvable by the LDS team. | ![Status=Draft](https://img.shields.io/badge/Open-red) | n/a |
| KI03 | Organisation / Practitioner — Row Access Policy | Row-level security policies have been incorrectly applied to the Organisation and Practitioner tables. May cause referential integrity issues for patients referred to services, or treated by practitioners, whose records belong to a different ICB. | Cross-ICB referral/treatment relationships may appear broken. Should be resolved before UAT begins. | ![Status=Draft](https://img.shields.io/badge/In_Progress-orange) — Target: fix before UAT | ![Team=LDSTeam](https://img.shields.io/badge/LDS_Team-00ADC3) |

## 2. Deviations from DDS (Not Defects)

> [!IMPORTANT]
> **Intentional or explainable differences between LDS OLIDS and DDS Compass — expected behaviour, not bugs.**
> <br>Flagged so testers do **not** log them as issues.

| Ref | Area | Description | Tester Guidance |
| --- | --- | --- | --- |
| DV01 | Referral Request | Outgoing referral information does not match DDS data. LDS has implemented logic documented as equivalent to DDS, but output does not reconcile exactly against NEL DDS. | Do not raise as a defect. Report any discrepancy that appears to go beyond a like-for-like comparison mismatch. |
| DV02 | Observation | In DDS, Observation records also marked as Problems produce a duplicate record. OLIDS has implemented logic to remove this duplication. | Expect fewer Observation records in OLIDS than DDS for Problem-linked observations. This is by design. |
| DV03 | Masked Columns | Due to Snowflake masking limitations, certain columns (e.g. date fields) return a default value rather than NULL or a masked placeholder such as '*****'. | Do not report default masked values (e.g. 1900-01-01 style dates) as data quality issues. |

