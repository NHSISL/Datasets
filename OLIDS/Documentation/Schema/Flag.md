# Flag

- [Flag](#flag)
  - [Overview](#overview)
  - [Columns](#columns)

## Overview

> [!IMPORTANT]
> The Flag table will **not** be provided during testing of Primary Care EMIS data.
> <br>There is no mapping currently undertaken from Primary Care EMIS data to the Flag entity
> <br>The Flag object is expected to be populated as part of Primary Care TPP mapping.

Linked FHIR resource: [🔥 Flag](https://build.fhir.org/flag.html)

A flag is a warning or notification of some sort presented to the user - who may be a clinician or some other person involved in patient care. It usually represents something of sufficient significance to warrant a special display of some sort - rather than just a note in the resource. A flag has a subject representing the resource that will trigger its display. This subject can be of different types, as described in the examples below:

- A note that a patient has an overdue account, which the provider may wish to discuss with them - in case of hardship for example (subject = Patient)
- An outbreak of Ebola in a particular region (subject=Location) so that all patients from that region have a higher risk of having that condition
- A particular provider is unavailable for referrals over a given period (subject = Practitioner)
- A patient who is enrolled in a clinical trial (subject=Group)
- Special guidance or caveats to be aware of when following a protocol (subject=PlanDefinition)
- Warnings about using a drug in a formulary requires special approval (subject=Medication)

A flag is typically presented as a label in a prominent location in the record to notify the clinician of the potential issues, though it may also appear in other contexts; e.g. notes applicable to a radiology technician, or to a clinician performing a home visit. For patients, the information in the flag will often be derived from the record, and therefore, for a thorough and careful clinician, who has the time to review the notes will be redundant. However, given the volume of information frequently found in patients' records and the potentially serious consequences of losing sight of some facts, this redundancy is deemed appropriate. As well, some flags may reflect information not captured by any other resource in the record. (E.g. "Patient has large dog at home")

Examples of Patient related issues that might appear in flags:

- Risks to the patient (functional risk of falls, spousal restraining order, latex allergy)
- Patient's needs for special accommodations (hard of hearing, need for easy-open caps)
- Risks to providers (dog in house, patient may bite, infection control precautions)
- Administrative concerns (incomplete information, prepayment required due to credit risk)

## Columns

<To be added>
