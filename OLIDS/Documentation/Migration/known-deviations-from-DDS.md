# Known deviations from Discovery Data Services (DDS) / Compass

Users in North East London ICB, West and North London ICB and South East London ICB will be migrating their consumption of GP data away from the Compass schema delivered through Discovery Data Services (DDS) and over to the OLIDS schema delivered by London Data Services (LDS).

The inventory below lists known deviations from the Compass specification and asosciated transforms that are known to London Data Services, but are not planned to be closed.

## Source data deviations

### DV04 - Shared Care Records within SystmOne (TPP)

London Data Services has extracted and retained all shared care records from data publishers.

We have sought Information Governance input from ICB leads and from Information Commissioners Office to confirm our interpretation that these shared care records are shared with the publisher for the purposes of onward direct care, and therefore publishers are able to onward share these shared care records where appropriate to do so.

TPP extracted data published to subscribers will include all "shared care records". These are records made visible to the publishing controller but authored by another care provider. This includes:

- records shared from one GP practice to another as a TPP specific alternative to the national GP2GP system
- records shared from a secondary care provider (i.e. community care) running a TPP SystmOne patient administration system, and where both the care provider as a whole, and the individual patient, agree to share the record back to the patients primary care provider.

These records are distinguished by the difference between the `publishing_organisation_id` and the `author_organisation_id`.

Users of Compass should note that the legacy system included only shared care records authored by another participating GP practice within the same region, so a shared care record was only made visible to the subscriber if the author was also a signatory to the commissioners sharing agreement.

To match the same position would require users to filter on the `author_organisation_id` being a local GP practice with an active signatory to the DSA

## Transform deviations

### DV01 - Referral Request logic

Outgoing referral information does not match DDS data.

LDS has implemented logic documented as equivalent to DDS, but output does not reconcile exactly against NEL DDS. | Do not raise as a defect. Report any discrepancy that appears to go beyond a like-for-like comparison mismatch.

### DV02 - Observations as problems

In DDS, Observation records also marked as Problems produce a duplicate record. OLIDS has implemented logic to remove this duplication.

Users should expect fewer Observation records in OLIDS than DDS for Problem-linked observations. This is by design.

### DV03 - Masked columns with default values

Due to Snowflake masking limitations, certain columns (e.g. date fields) return a default value rather than NULL or a masked placeholder such as '*****'. This is by design.

## Concept deviations

### `Xe1Xs` - Vascular Dementia (Stroke and Dementia QoF impacting)

- DDS maps to SCT: `56267009` Multi-infarct dementia (disorder)
- OLIDS maps to SCT: `429998004` - Vascular dementia

End users confirmed that OLIDS mapping is correct.

### `XaRFF` - Has end of life advance care plan (Palliative Care QoF impacting)

- DDS maps to SCT: `935911000000108` Has end of life care plan (finding) which is an inactive code not in Pal care QOF cluster
- OLIDS maps to SCT: `713673000` - Has end of life care plan (finding)

End users confirmed that OLIDS mapping is correct and aligns with national mappings, DDS is likely a legacy mapping that should have been updated.

### `Eu7z0` - mental deficiency / sub-normality not otherwise specified

- DDS maps to SCT: `91138005` (old term now inactive) (disorder) (inactive)
- OLISA maps to SCT: `110359009` Intellectual disability (disorder) (active)

End users confirmed that OLIDS mapping is correct and DDS maps to an inactive concept

### `XaNbn` - Chronic kidney disease stage 3A

- DDS maps to SCT: `309861000000100` Chronic kidney disease stage 3A (disorder) (inactive)
- OLIDS maps to SCT: `700378005` Chronic kidney disease stage 3A (disorder)

End users confirmed that OLIDS mapping is correct and DDS maps to an inactive concept

### `XaNbo` - Chronic kidney disease stage 3B

- DDS maps to SCT: `309871000000107` Chronic kidney disease stage 3B (disorder) (inactive)
- OLIDS maps to SCT: `700379002` Chronic kidney disease stage 3B (disorder)

End users confirmed that OLIDS mapping is correct and DDS maps to an inactive concept
