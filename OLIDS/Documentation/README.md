# OLIDS Documentation

Documentation for the One London Integrated Data Set (OLIDS): how source data is transformed into the common model, what filtering is applied before distribution, and the entity relationships within the resulting schema.

## Contents

- [known-issues-deviations.md](known-issues-deviations.md) — Log of known defects and expected deviations from the DDS, maintained ahead of UAT so testers can distinguish genuine bugs from expected behaviour

- **[Source-data/](Source-data/)** — Source system context
  - [supported-source-systems.md](Source-data/supported-source-systems.md) — LDS position on which GP clinical systems are in scope for ingestion
  - [optum-emis/](Source-data/optum-emis/) — EMIS specification versions, change history, and a Q&A on ingestion behaviour

- **[Source-transforms/](Source-transforms/)** — Source-to-OLIDS transformation logic
  - [EMIS-to-OLIDS-mapping.md](Source-transforms/EMIS-to-OLIDS-mapping.md) — Table-by-table mapping from EMIS source objects to the OLIDS specification
  - [patient-to-person.md](Source-transforms/patient-to-person.md) — How patient records are linked to persons via PDS, including allocation logic and worked scenarios

- **[Filtering-rules/](Filtering-rules/)** — Rules applied before OLIDS data is shared onward
  - [filtering-rules.md](Filtering-rules/filtering-rules.md) — Current filtering rules approved by the One London Board, with supporting value set definitions

- **[Synapse-Platform-Archive/](Synapse-Platform-Archive/)** — Archived documentation from the legacy Synapse platform
  - [OLIDS-entity-relationship.md](Synapse-Platform-Archive/OLIDS-entity-relationship.md) — Entity relationship diagrams for the OLIDS schema
  - [schema-dictionary/](Synapse-Platform-Archive/schema-dictionary/) — Per-table schema definitions
  - [Release-notes/](Synapse-Platform-Archive/Release-notes/) — Historical release notes by deployment stage
