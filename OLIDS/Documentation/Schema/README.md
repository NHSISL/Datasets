# OLIDS Schema Documentation

Reference documentation for the OLIDS (One London Integrated Data Set) data model. Each file below documents a single table: its purpose, columns (with data type, PK/FK, and masking policy), entity relationships to other tables, and any implementation notes. Most tables map to a corresponding [HL7 FHIR](https://build.fhir.org/) resource, linked from each table's Overview section.

Start with [_schema_notes.md](_schema_notes.md) for cross-cutting conventions that apply across tables — datetime formatting, source concept IDs, the Publisher/Author/Provider/Supplier organisation model, and patient age representation — before reading individual table docs.

## Tables

### People and demographics

> [!NOTE]
> These tables will have difference schema for subscribers who consume pseudonymised feeds compared to those who consume identifiable feeds. Please review the masking policy information in these sections to confirm which columns are available and how they will appear in your subscribed views.

| Table | Description |
| --- | --- |
| [Person](Person.md) | Golden-record view of a person, combining PDS-matched records with source-system fallback ("stub") records. |
| [Patient](Patient.md) | A person as registered/receiving care at a specific provider; one person may have multiple Patient records across providers. |
| [Patient_Person](Patient_Person.md) | Links Patient to Person; originally introduced to support independent incremental loading. |
| [Patient_Address](Patient_Address.md) | A patient's address(es). |
| [Patient_Contact](Patient_Contact.md) | A patient's contact details (telecom). |

### Care events

| Table | Description |
| --- | --- |
| [Encounter](Encounter.md) | An interaction between a patient and healthcare provider(s) to deliver care or assess health status. |
| [Episode_Of_Care](Episode_Of_Care.md) | An association between a patient and an organisation covering a period of managed care, during which encounters may occur. |
| [Observation](Observation.md) | Measurements and simple assertions made about a patient, device, or other subject. |
| [Allergy_Intolerance](Allergy_Intolerance.md) | A recorded allergy or intolerance risk for a patient. |
| [Medication_Order](Medication_Order.md) | A request/order for medication. |
| [Medication_Statement](Medication_Statement.md) | A record of medication a patient is, or has been, taking. |
| [Diagnostic_Order](Diagnostic_Order.md) | A request for diagnostic investigation, treatment, or operation. |
| [Procedure_Request](Procedure_Request.md) | A request for a procedure to be performed. |
| [Referral_Request](Referral_Request.md) | A request for a patient to be referred for further care. |

### Scheduling

| Table | Description |
| --- | --- |
| [Appointment](Appointment.md) | A booking of a healthcare event among patients, practitioners, and/or devices for a specific date/time; may result in one or more Encounters. |
| [Appointment_Practitioner](Appointment_Practitioner.md) | Practitioner participants associated with an appointment. |
| [Schedule](Schedule.md) | The availability of a schedulable resource (practitioner, location, device, etc.) over time. |
| [Schedule_Practitioner](Schedule_Practitioner.md) | Practitioners associated with a schedule. |

### Organisations and people delivering care

| Table | Description |
| --- | --- |
| [Organisation](Organisation.md) | An organisation involved in the provision, authoring, publishing, or supply of care records. |
| [Location](Location.md) | A physical place where services are provided or resources/participants are found. |
| [Practitioner](Practitioner.md) | An individual engaged in providing healthcare or healthcare-related services. |
| [Practitioner_In_Role](Practitioner_In_Role.md) | A practitioner's role at an organisation/location. |

### Reference

| Table | Description |
| --- | --- |
| [_schema_notes.md](_schema_notes.md) | Cross-cutting standards: datetime format, source concept IDs, Publisher/Author/Provider/Supplier organisation definitions, patient age representation. |

## Masking policy symbols

Column tables use the following symbols in the "Masking Policy" column to indicate how a column is treated for de-identified/pseudonymised data:

| Symbol | Meaning |
| --- | --- |
| ❌ | Column removed |
| #️⃣ | Hashed |
| 📅 | Date truncated/generalised (e.g. to 1st of month) |
| ℹ️ | Pseudo view only |

## Status

> [!NOTE]
> Entity relationship diagrams are currently indicative — the precise optional/mandatory nature of some relationships is still being clarified.
