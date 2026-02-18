# London Data Service: Position on Acquiring Data from New GP Clinical Systems

---

## Background

The London Data Service (LDS) was established to ingest, standardise, and securely distribute GP clinical data across London's Integrated Care Boards (ICBs). At the time of its establishment, the scope of data ingestion was explicitly defined and limited to:

- **TPP SystmOne** – via the TPP gateway
- **EMIS Web** – via the IM1 bulk feed mechanism

A small number of community and health scenarios were also included where those data flows followed the same IM1 ingestion pattern already in use.

**Vision** (a legacy GP clinical system) was specifically considered and excluded from scope at the outset. ICBs were advised at the time of establishment that other new or emerging system providers would not be automatically considered for inclusion without a separate, formally scoped process.

---

## The Emergence of New GP Clinical Systems

The GP clinical system market is evolving. **Medicus** is the first substantively new GP clinical system to receive NHS approval in approximately 25 years, having been formally approved by NHS England in June 2025. A small number of GP practices across London have already transitioned to Medicus, and there is reasonable anticipation that further transitions may follow as practices assess modern alternatives to established systems.

Medicus does offer an IM1 bulk extract capability; however, at the time of writing, the Medicus IM1 integration is available only via the **transactional API** (which operates on an individual patient basis) rather than the **bulk feed** mechanism. The LDS ingestion pipeline requires bulk feed availability to function effectively and at scale. The transactional API is not suitable for population-level analytics ingestion into the LDS.

---

## LDS Position

The London Data Service welcomes the innovation represented by new GP clinical systems and recognises the importance of comprehensive data coverage across all GP practices in London. However, any expansion of the LDS ingestion scope beyond TPP and EMIS must be treated as a **formal programme variation**, not an operational change.

The following principles underpin this position:

- **Scope was defined at inception.** The LDS was scoped, funded, and resourced to support TPP and EMIS extracts. Any extension constitutes a material change to that scope.
- **Technical readiness must be confirmed.** Supporting a new GP system provider requires validation that a suitable bulk extraction mechanism exists, is stable, is accredited, and is compatible with the LDS ingestion architecture. For Medicus specifically, bulk feed availability via IM1 is a prerequisite that is not yet confirmed as production-ready for LDS purposes.
- **Resource implications are significant.** Onboarding a new clinical system is not a minor configuration task. It requires dedicated technical scoping, data modelling, information governance review, security assessment, testing, and ongoing maintenance. This effort is comparable in scale to other major LDS onboarding programmes and cannot be absorbed within existing operational resource.
- **Governance must precede delivery.** No detailed technical scoping, planning, or build activity will be initiated without a formal **variation request** being submitted by the relevant ICB(s) to the **OneLondon London Health Data (OLHD) Board**, and without that variation being approved by all partner organisations.

---

## Pathway for ICBs Wishing to Propose an Extension

Any ICB wishing to propose the onboarding of a new GP clinical system data source into the LDS — including Medicus — is asked to follow this process:

1. **Submit a formal variation request** to the OLHD Board as part of the relevant annual plan cycle.
2. The variation request should articulate the **clinical and operational case**, the number of practices affected, anticipated growth in adoption, and the benefits to population health analytics.
3. Upon receipt of a formal variation request, the OneLondon Product and Technical teams will **undertake detailed technical scoping**, including assessment of the IM1 bulk feed status for the relevant system, infrastructure requirements, information governance implications, and resource and cost planning.
4. A **business case and delivery plan** will be developed, with resource and funding requirements clearly identified, before any commitment to delivery is made.
5. Approval of the business case by the OLHD Board and all partner ICBs is required prior to commencement of any build or integration work.

---

## Current Status

At this time:

- **No formal variation requests** have been received or approved by the OLHD Board in respect of Medicus or any other new GP clinical system provider.
- **Initial engagement** has taken place between the OneLondon Product team and some ICBs regarding the concept of Medicus onboarding; this engagement was exploratory in nature and does not constitute a commitment or agreement to proceed.
- **The IM1 bulk feed for Medicus** is not currently confirmed as available in a form suitable for LDS ingestion.
- Further technical scoping — which would itself consume material resource across technical, product, and project management functions — will only be authorised following receipt and approval of a formal variation request.

---

## Next Steps

ICBs that have indicated an interest in extending GP data coverage within the LDS are invited to prepare and submit formal variation requests to the OLHD Board. Until such requests are received and approved, the LDS team is not in a position to commit resource to scoping, planning, or delivery of this work.

OneLondon remains committed to supporting the broadest possible GP data coverage for London and will work constructively with ICBs to assess the viability of new system integrations through the appropriate governance pathway.

---

*For further information, please contact the OneLondon Programme team.*
