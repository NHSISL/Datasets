# EMIS to OLIDS transformations

## Overview

The documentation below outlines the source to product transformations that have been applied to map the incoming EMIS data to the output OLIDS specification.

## Source table inventory

The EMIS dataset consists of the following source objects:

- Admin_Location
- Admin_Organisation
- Admin_OrganisationLocation
- Admin_Patient
- Admin_PatientHistory
- Admin_UserInRole
- Agreements_SharingOrganisation
- Appointment_Session
- Appointment_SessionUser
- Appointment_Slot
- Audit_PatientAudit
- Audit_RegistrationAudit
- CareRecord_Consultation
- CareRecord_Diary
- CareRecord_Observation
- CareRecord_ObservationDiary
- CareRecord_Problem
- Coding_ClinicalCode
- Coding_DrugCode
- Prescribing_DrugRecord
- Prescribing_IssueRecord

## Mappings

### Admin_Location

| source column | Engine-CDM column | OLIDS column |
| --- | --- | --- |
| `LocationGuid` | Component of `[Location].[LDSBusinessKey]` | Component of `[location].[LDS_business_key]` |
| `LocationName` | `[Location].[Name]` | `[location].[name]` |
| `LocationTypeDescription` | `[Location].[Description]` | `[location].[type_desc]` |
| `ParentLocationGuid` | *Unmapped* | *Unmapped* |
| `OpenDate` | `[Location].[OpenDate]` | `[Location].[open_date]` |
| `CloseDate` | `[Location].[CloseDate]` | `[location].[close_date]` |
| `MainContactName` | *Unmapped* | *Unmapped* |
| `FaxNumber`* | `[LocationContact].[Value]` | `[location_contact].[value]` |
| `EmailAddress`* | `[LocationContact].[Value]` | `[location_contact].[value]` |
| `PhoneNumber`* | `[LocationContact].[Value]` | `[location_contact].[value]` |
| `HouseNameFlatNumber` | `[Location].[AddressLine1]` | `[location].[address_line_1]` |
| `NumberAndStreet` | `[Location].[AddressLine1]` | `[location].[address_line_1]` |
| `Village` | `[Location].[AddressLine2]` | `[location].[address_line_2]` |
| `Town` | `[Location].[AddressLine3]` | `[location].[address_line_3]` |
| `County` | `[Location].[AddressLine4]` | `[location].[address_line_4]` |
| `Postcode` | `[Location].[PostCode]` | `[location].[postcode]` |
| `Deleted` | *Unmapped* | *Unmapped* |
| `ProcessingId` | *Unmapped* | *Unmapped* |

Notes:
- `FaxNumber`, `EmailAddress` and `PhoneNumber` are pivoted and entered into `location_contact` as individual entries per populated value.