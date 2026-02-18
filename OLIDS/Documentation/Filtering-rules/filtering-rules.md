# OLIDS filtering rules

## Overview

The One London Integrated Data Set (OLIDS) is subjected to filtering rules before distribution to the London Data Fabric and onward sharing to subscribers.

The filtering rules are approved by the One London Board and applied based on their determination.

**Last Updated**: 18 February 2026

---

## Current Filtering Rules

As of February 2026, the following filtering rule remains in effect:

### Exclusion of patients with PDS (Person Demographics Services) sensitive flag

**Status**: Active

The decision to exclude all records relating to persons with a PDS sensitivity flag will remove any and all records that relate to a person who is marked with a PDS sensitivity flag. Such patients will have all of their records filtered out before the Engine service discloses data to the One London Data Environment services.

For more information on the PDS flags, please see:
- "Sensitive Flags" at [NHS England - Personal Demographic Service](https://www.england.nhs.uk/long-read/personal-demographic-service-pds/)
- [NHS Digital - Restricting Access to a Patient's Demographic Record](https://digital.nhs.uk/services/personal-demographics-service/restricting-access-to-a-patients-demographic-record)

---

## Policy Change: Removal of Sensitive Condition Filtering (February 2026)

### Previous Rule: Exclusion of sensitive conditions

**Status**: REMOVED (Decision: 9 February 2026, Implementation: TBC)

**Previous Implementation**: 
The exclusion of events encoded with sensitive conditions removed individual event records (such as observation records) where they contained a sensitive condition. This did not remove other related event records that did not contain the clinically encoded value. For example, the appointment record in which a diagnosis of a sensitive condition was the subject may still have been present, but the observation record of that sensitive condition was not shared.

**Previous Filtering Criteria**:
The filtering used the following SNOMED reference sets:
- SCTID: 999004351000000109: General practice summary data sharing exclusion for gender related issues
- SCTID: 999004371000000100: General practice summary data sharing exclusion for assisted fertilisation
- SCTID: 999004361000000107: General practice summary data sharing exclusion for termination of pregnancy
- SCTID: 999004381000000103: General practice summary data sharing exclusion for sexually transmitted disease

**Other reference sets not included in this filtering**:
- SCTID: 1955841000000104: National Health Service secondary use data exclusions due to Human Fertilisation and Embryology Act 2008
- SCTID: 1955851000000101: National Health Service secondary use data exclusions due to Gender Recognition Act 2004

---

### Decision to Remove Sensitive Condition Filtering

**Decision Date**: 9 February 2026

**Decision Made By**: OneLondon Health Data Board (unanimous approval)

**Endorsed By**:
- BI User Group (10-13 February 2026, e-mail consultation)
- London IG Steering Group (12 February 2026)

**Implementation Status**: Approved - timing to be agreed with Clinical Validation workstream and ICB data teams

---

### Changes to Data Flows

#### Non-Identifiable Feeds: ICB Data Teams (SEL, SWL, NCL, NEL)

**Change**: Standardised data flow specifications amended - legally restricted codes changed from 'exclude' to 'include'

**Affected Recipients**:
- South East London ICB (SEL ICB)
- South West London ICB (SWL ICB)
- North Central London ICB (NCL ICB)
- North East London ICB (NEL ICB)

**Data Format**: Pseudonymised using standard LDS Column Masker configuration:
- NHS number: Hashed
- Postcode: Hashed
- Date of Birth: Generalised

**Data Linkage**: Consistent hashing enables authorised teams to link legally restricted coded activity with existing activity records.

**Historical Data**: Full historical data reload to include previously filtered records across all time periods.

---

#### Identifiable Feeds: NWL ICB and NWL-LAP

**Change**: Standardised data flow specifications amended - legally restricted codes changed from 'exclude' to 'include'

**Affected Recipients**:
- North West London ICB (NWL ICB-specific flows)
- North West London Local Analytics Platform (NWL-LAP)

**Data Handling Controls**:

| Purpose | Format | Legally Restricted Codes |
|---------|--------|--------------------------|
| Secondary use (research, planning, analysis) | Pseudonymised | Included in persisted data |
| Direct care (patient treatment) | Identifiable | Filtered out or suitably restricted |

**Compliance**: NWL ICB will issue a Compliance Notice to NEL-LDS documenting these controls.

**Historical Data**: Full historical data reload to include previously filtered records across all time periods.

---

### Scope of Change

**Applies To**:
- LDS GP OLIDS dataflows only

**Does Not Apply To**:
- CSDS (Community Services Data Set)
- SUS / Faster SUS (Secondary Uses Service)
- MHSDS (Mental Health Services Data Set)

These datasets were assessed and found to contain records that would fall within the 'filtered' category. However, no filters will be applied, no further review will be conducted, and no system will be developed to implement blocking mechanisms for these datasets.

---

### Data Protection Safeguards

**Local Analytics Platform (LAP)**:
- All data processed in accordance with Data Processing Agreements (DPAs)
- LAP processing designed to minimise disclosure risk
- Access controls and audit mechanisms unchanged
- NWL ICB implements differential controls for secondary vs direct care use

**Ongoing Protections**:
- Non-identifiable feeds remain pseudonymised (hashed identifiers, generalised DOB)
- User authorisation requirements unchanged
- Compliance monitoring continues
- NWL Compliance Notice requirements apply

---

### Implementation

**Responsible Team**: ODS Team (LDS Delivery)

**Authority**: LDS Delivery team authorised to manage transition and agree implementation timing with user base

**Coordination Required**:
- Clinical Validation workstream (timing)
- All ICB data teams (readiness and timing)
- NWL ICB (control implementation and Compliance Notice)
- OneLondon Health Data Board representative (NWL Compliance Notice wording)

---

### Related Documentation

For full details of this policy change, including decision history, implementation steps, and technical specifications, see:
- [Decision Record: Reversal of Restricted Code Filtering](./decision-record-restricted-code-filtering-reversal.md)
- OneLondon Health Data Board Decision (9 February 2026)
- BI User Group Review (10-13 February 2026)
- London IG Steering Group Review (12 February 2026)

---

## Future Policy Considerations

**Important Note**: Should any future policy require the implementation of code filtering:
- Dataflows will need to be suspended
- Significant resources will be required to assess, develop, test, and deploy filtering mechanisms
- Historical data may require reprocessing

---
