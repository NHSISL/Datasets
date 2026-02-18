# Decision Record: Reversal of Restricted Code Filtering in OLIDS GP Dataflows

**Status**: Approved for Implementation | **Decision Date**: 9 February 2026

---

## Executive Summary

The OneLondon Health Data Board has unanimously approved the removal of restricted code filtering within LDS GP OLIDS dataflows. The standardised data flow specifications will be amended to change legally restricted codes from 'exclude' to 'include', with full historical data reload required. The LDS Delivery team has been given approval to manage and oversee the transition, including agreeing implementation timing with ICB data teams and the Clinical Validation workstream.

---

## Decision History

### Original Decision
**Decision Made By**: London IG Steering Group

**Action**: Implementation of filtering restrictions on legally restricted codes within LDS GP OLIDS dataflows, including:
- Gender reassignment, assisted conception, sexually transmitted diseases
- Domestic violence, forced marriages, vulnerable children
- Victims of crime codes
- Criminal behaviour codes

**Implementation**: Standardised data flow specification set legally restricted codes to 'exclude'.

---

### Decision Reversal (February 2026)

**Monday, 9 February 2026 - OneLondon Health Data Board**
- Unanimously approved instruction to remove all filtering restrictions

**10-13 February 2026 - BI User Group**
- E-mail review of instruction wording - no comments for change

**Thursday, 12 February 2026 - London IG Steering Group**
- Instruction considered - no comments for change

**Outcome**: Instruction approved for implementation with LDS Delivery team authorised to manage transition and agree timing with user base.

---

## Approved Changes

### NON-IDENTIFIABLE FEEDS: ICB Data Teams (SEL, SWL, NCL, NEL)

#### Specification Amendment
**Action**: Amend standardised data flow specification for GP data to SEL ICB, SWL ICB, NCL ICB, and NEL ICB - change legally restricted codes from **'exclude' to 'include'**.

**Data Format**: Pseudonymised using standard LDS Column Masker configuration:
- NHS number: Hashed
- Postcode: Hashed  
- Date of Birth: Generalised

**Data Linkage**: Hashing routine for existing activity and legally restricted coded activity will be identical, enabling authorised teams to link records using pseudo identifiers.

---

### IDENTIFIABLE FEEDS: NWL ICB and NWL-LAP

#### Specification Amendment
**Action**: Amend standardised data flow specification for GP data to NWL ICB-specific flows and NWL-LAP - change legally restricted codes from **'exclude' to 'include'**.

**Data Format**: Can include identifiable data for direct care purposes.

#### NWL ICB Controls
**Control Implementation**: NWL ICB will implement controls on received data flow:

| Purpose | Format | Legally Restricted Codes |
|---------|--------|--------------------------|
| Secondary use (research, planning, analysis) | Pseudonymised | Included in persisted data |
| Direct care (patient treatment) | Identifiable | Filtered out or suitably restricted |

**Compliance Notice**: NWL ICB to issue Compliance Notice to NEL-LDS documenting these controls.

---

## Implementation Requirements

### Technical Actions - ODS Team
1. Amend data flow specifications: change legally restricted codes 'exclude' → 'include' for all OLIDS GP flows
2. Reload all historical data to OLIDS output specification  
3. Apply pseudonymisation (hashed NHS number, hashed postcode, generalised DOB) to non-identifiable feeds
4. Validate consistent hashing across existing and legally restricted activity
5. Confirm previously filtered records now present across all time periods

### Coordination and Timing - LDS Delivery Team
1. Agree implementation timing bilaterally with Clinical Validation workstream
2. Coordinate with all ICB data teams (SEL, SWL, NCL, NEL, NWL) on readiness
3. Ensure NWL ICB controls implemented before go-live
4. Finalise NWL Compliance Notice wording with OneLondon Health Data Board representative
5. Communicate exact timing to all affected teams (critical for clinical validation)

### Validation
1. Verify record counts against pre-filtering baseline
2. Confirm legally restricted codes present in outputs
3. Test data linkage using pseudo identifiers (non-identifiable feeds)
4. Validate NWL ICB controls functioning correctly
5. Monitor system performance post-implementation

---

## Scope Limitations

### OLIDS Only
This decision applies **exclusively to LDS GP OLIDS dataflows**.

**Other Datasets Assessed but Unchanged**:
- CSDS (Community Services Data Set)
- SUS / Faster SUS (Secondary Uses Service)  
- MHSDS (Mental Health Services Data Set)

**Assessment Finding**: Records within the 'filtered' category exist in these datasets.

**Decision**: No filters will be applied to these datasets, no further review will be conducted, and no system will be developed to implement blocking mechanisms.

**Future Policy Implications**: Any future requirement to implement code filtering will necessitate dataflow suspension and significant resource investment to develop, test, and deploy filtering mechanisms.

---

## Data Protection Safeguards

### Local Analytics Platform (LAP)
- All data processed in accordance with Data Processing Agreements (DPAs)
- LAP processing designed to minimise disclosure risk
- Access controls and audit mechanisms unchanged
- NWL ICB implements differential controls for secondary vs direct care use

### Ongoing Protections
- Non-identifiable feeds remain pseudonymised (hashed identifiers, generalised DOB)
- User authorisation requirements unchanged
- Compliance monitoring continues
- NWL Compliance Notice requirements apply

---

## Summary

### What Changed
- Data flow specifications: legally restricted codes 'exclude' → 'include'
- Applies to: SEL ICB, SWL ICB, NCL ICB, NEL ICB (pseudonymised), NWL ICB and NWL-LAP (identifiable with controls)
- Full historical data reload with previously filtered records now included
- Consistent hashing enables data linkage for authorised teams

### What Remained Unchanged
- OLIDS output specification standards
- Pseudonymisation requirements for non-identifiable feeds
- CSDS, SUS/Faster SUS, MHSDS dataflows (no filters applied)
- Data governance, access controls, and audit processes

### Authority
- LDS Delivery team authorised to manage transition and agree timing with user base
- No further governance approval required for implementation timing

---

## Dependencies

**Critical**:
- NWL ICB control implementation and Compliance Notice
- Clinical Validation workstream timing coordination
- System capacity for full historical data reload
- ICB data team readiness (all 5 teams)

---

## Related Documentation

- [Filtering Rules Documentation](../Filtering-rules/)
- OneLondon Health Data Board Decision (9 Feb 2026)
- BI User Group Review (10-13 Feb 2026)
- London IG Steering Group Review (12 Feb 2026)
- OLIDS Output Specification
- Data Processing Agreements
- NWL ICB Compliance Notice (pending)

---
