# OLIDS filtering rules

- [OLIDS filtering rules](#olids-filtering-rules)
- [Overview](#overview)
  - [exclusion of sensitive conditions](#exclusion-of-sensitive-conditions)
  - [exclusion of patients with PDS (person demographics services) sensitive flag](#exclusion-of-patients-with-pds-(person-demographics-services)-sensitive-flag)

# Overview

The One London Integrated Data Set (OLIDS) is subjected to filtering rules before distribution to the London Data Fabric and onward sharing to subscribers.

The filtering rules are approved by the One London Board and applied based on their determination.

The current set of rules are:

- exclusion of sensitive conditions
- exclusion of patients with a PDS sensitivity flag
 
## exclusion of sensitive conditions

The decision to exclude events encoded with sensitive conditions will remove individual event records (such as observation records) where they contain a sensitive condition. Note that this will not remove other related event records that do not contain this clinically encoded value. For example, the appointment record in which a diagnosis of a sensitive condition was the subject may still be present, but the observation record of that sensitive condition will not be shared.

The One London Board did not specify a set list of codes to be used, and as such we have opted to use the snomed reference sets to act as the filtering rule definitions. The reference sets are:

- SCTID: 999004351000000109: General practice summary data sharing exclusion for gender related issues
- SCTID: 999004371000000100: General practice summary data sharing exclusion for assisted fertilisation
- SCTID: 999004361000000107: General practice summary data sharing exclusion for termination of pregnancy
- SCTID: 999004381000000103: General practice summary data sharing exclusion for sexually transmitted disease

Other reference sets currently **not** included in this filtering are:

- SCTID: 1955841000000104: National Health Service secondary use data exclusions due to Human Fertilisation and Embryology Act 2008
- SCTID: 1955851000000101: National Health Service secondary use data exclusions due to Gender Recognition Act 2004

## exclusion of patients with PDS (person demographics services) sensitive flag

The decision to exclude all records relating to persons with a PDS sensitivity flag will remove any and all records that relate to a person who is marked with a PDS sensitivity flag. Such patients will have all of their records filtered out before the Engine service discloses data to the One London Data Environment services.

For more information on the PDS flags, please see:

- "Sensitive Flags" at [https://www.england.nhs.uk/long-read/personal-demographic-service-pds/](https://www.england.nhs.uk/long-read/personal-demographic-service-pds/)
- [https://digital.nhs.uk/services/personal-demographics-service/restricting-access-to-a-patients-demographic-record](https://digital.nhs.uk/services/personal-demographics-service/restricting-access-to-a-patients-demographic-record)