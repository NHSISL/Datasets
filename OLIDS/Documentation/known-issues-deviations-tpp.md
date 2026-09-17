# Known issues and deviations (TPP)

- Programme: London Data Service (LDS) Replatforming — OLIDS
- Purpose: This log records issues and known behavioural deviations identified ahead of User Acceptance Testing (UAT), so testers can distinguish genuine defects from expected differences before raising tickets.

## 1. Known Issues

> [!IMPORTANT]
> **This list represents known genuine defects or limitations of the service**.
> <br>Testers should **not** re-raise these as new bugs, but should report any impact beyond what is described below.

| Ref | Area | Description | Impact on UAT | Status | Owner |
| --- | --- | --- | --- | --- | --- |
| KI01 | Encounters | The `is_latest` logic does not select a single record when EventLink records are sequenced. | Duplicates | ![Status](https://img.shields.io/badge/Status-Accepted-darkgreen) | ![Owner](https://img.shields.io/badge/LDS-00ADC3) |
| KI02 | Patient Addresses | patient_address start date > end_date for a few records | DQ issue in raw data | ![Status](https://img.shields.io/badge/Status-Closed-green) | n/a |

## 2. Deviations from DDS (Not Defects)

> [!IMPORTANT]
> **Intentional or explainable differences between LDS OLIDS and DDS Compass — expected behaviour, not bugs.**
> <br>Flagged so testers do **not** log them as issues.

| Ref | Area | Description | Tester Guidance |
| --- | --- | --- | --- |
