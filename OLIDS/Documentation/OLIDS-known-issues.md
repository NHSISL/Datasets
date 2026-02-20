# OLIDS Known Issues

- [OLIDS Known Issues](#olids-known-issues)
  - [⛔ Data availability issues](#%E2%9B%94-data-availability-issues)
    - [📈 historical episodes of care: EMIS patients](#%F0%9F%93%88-historical-episodes-of-care%3A-emis-patients)
    - [⚙️ Optum group configuration errors](#%E2%9A%99%EF%B8%8F-optum-group-configuration-errors)
    - [❌ Allocation failures (NWL and NCL practices)](#%E2%9D%8C-allocation-failures-(nwl-and-ncl-practices))
    - [⛔ Known bulk failures](#%E2%9B%94-known-bulk-failures)
      - [DevOps 27564 - superbatch failure (NEL and SEL practices)](#devops-27564---superbatch-failure-(nel-and-sel-practices))
      - [DevOps 27565 - superbatch failure (SWL practice)](#devops-27565---superbatch-failure-(swl-practice))
      - [DevOps 27617 - SystmOne extract misconfiguration, NWL Group 16](#devops-27617---systmone-extract-misconfiguration%2C-nwl-group-16)
      - [Unknown bulk error - NWL SystmOne Groups 14 and 5](#unknown-bulk-error---nwl-systmone-groups-14-and-5)
  - [🏗️ Schema issues](#%F0%9F%8F%97%EF%B8%8F-schema-issues)
    - [general](#general)
    - [allergy\_intolerance](#allergy_intolerance)
    - [appointment\_practitioner](#appointment_practitioner)
    - [diagnostic\_order](#diagnostic_order)
    - [encounter](#encounter)
    - [medication\_order](#medication_order)
    - [medication\_statement](#medication_statement)
    - [observation](#observation)
    - [person](#person)
    - [person\_address (masked)](#person_address-(masked))
    - [person (masked)](#person-(masked))
    - [practitioner](#practitioner)
    - [procedure\_request](#procedure_request)
    - [referral\_request](#referral_request)
    - [person (pcd)](#person-(pcd))
  - [patient](#patient)
  - [appointment](#appointment)
  - [`RECORD_OWNER_ORGANISATION_CODE` Evolution](#%60record_owner_organisation_code%60-evolution)

The below is a report of the currently known issues within the One London Integrated Data Set (OLIDS)

## ⛔ Data availability issues

### 📈 historical episodes of care: EMIS patients

We are currently unable to provide historical episodes of care (practice registrations) for patients at EMIS practices.

This is due to a limitation inherint within the design of the IM1 feed from EMIS, which is designed primarily for direct care purposes and as a result focusses upon current registrations.

The underlying problem is that the source EMIS `admin_patient` table only contains a single, continually overwritten patient record, rather than a historical record of registration events.

Key points:

- EMIS supplies one record per patient in the admin_patient table.
- This record includes the current registration and deregistration dates.
- Each update overwrites the previous version, including when a patient leaves and later rejoins a practice.
- During the initial bulk extract we receive only the latest version at that time — no historical versions are provided.
- We can track changes **after** the bulk, but not historical changes **before** it.

This results in missing registration history for periods prior to our first bulk, affecting ICBs’ ability to perform trend analysis that depends on complete historical data.

This will be most notable for patients who have moved in and out of the same practice more than once in the preceeding five years prior to our first extract of that practice. Please also note that historical registrations are visible where it is the most recent registration with that practice.

In recognition of the limitation that this places upon the use of the data beyond direct care purposes, we are raising the issue with our program team with a recommendation to approach EMIS for an alternative feed that would provide historical registration information.

### ⚙️ Optum group configuration errors

We are aware that some EMIS groups have been incorrectly configured to receive data on an 'implied opt-out' basis. This significantly limits the data fed to us to only cases where the patient has an explicit data sharing opt-in. In most cases to less than one percent (1%) of the total expected population.

This affects the following practices:

| ICB | ODS | practice name |
| --- | --- | --- |
| **SEL** | G83006 | The Albion Surgery |
| SEL | G84001 | South View Partnership |
| SEL | G83062 | Slade Green Medical Ctr. |
| SEL | G83018 | Lakeside Medical |
| SEL | G85114 | Wells Park Practice |
| SEL | G85681 | The Lordship Lane Surgery |
| SEL | G84621 | Whitehouse Surgery |
| SEL | G83642 | Crayford Town Surgery |
| SEL | G84010 | The Chislehurst Partnership |
| **SWL** | Y05318 | Denmark Road Surgery |
| SWL | H83043 | Shirley Medical Centre |
| SWL | H83052 | Bramley Avenue Surgery |
| SWL | H84050 | Chessington Park Surgery |
| SWL | H83034 | Whitehorse Practice |
| SWL | H83023 | Morland Road Surgery |
| SWL | H83024 | Woodcote Medical |
| SWL | H84623 | Hampton Hill Medical Centre |
| SWL | H83010 | South Norwood Hill Medical Centre |
| SWL | H83609 | Mersham Medical Centre |
| SWL | H83016 | Keston Medical Practice |
| SWL | H85061 | Heathbridge Practice |
| SWL | H83044 | East Croydon Medical Centre |
| SWL | H83001 | Portland Medical Centre |
| SWL | H85038 | Cricket Green Medical Practice |
| SWL | H84618 | Sunray Surgery |

### ❌ Allocation failures (NWL and NCL practices)

We have identified that 65 batches of data have successfully processed through our main pipeline, but silently failed in pipeliens related to the production of allocation information. This results in the successfully processed data being available in our 'airlock' Snowflake account, but unable to be issued under the Share to ICBs.

This affects the Bulk data for the following practices:

| ICB | practice | patients affected |
| --- | --- | --- |
| NCL | -------- | ---- |
| NCL | E83026: Supreme Medical Centre | 6,159 |
| NCL | E83018: Watling Medical Centre | 24,504 |
| NCL | E83041: Wakemans Hill Surgery | 7,045 |
| NCL | Y02986: Cricklewood Health Centre | 9,865 |
| NWL | -------- | ---- |
| NWL | E85107: The Mill Hill Surgery | 16,895 |
| NWL | E87065: The Notting Hill Medical Centre | 15,037 |
| NWL | E85038: Palace Surgery | 13,658 |

This affects the delta data for the following practices:

| ICB | practice | patients affected | batches affected |
| --- | --- | --- | --- |
| NCL | -------- | ---- |
| NCL | E83041: Wakemans Hill Surgery | 7,051 | 2 |
| NCL | F85063: The Muswell Hill Practice | 3,648 | 6 |
| NCL | F83043: Ridgmount Practice | 415 | 3 |
| NCL | E83011: The Everglade Medical Practice | 248 | 6 |
| NCL | E83027: The Practice at 188 | 231 | 6 |
| NCL | Y01655: The Vale Practice | 192 | 6 |
| NCL | F85023: The Ordnance Unity Centre for Health | 187 | 6 |
| NCL | F83008: The Goodinge Group Practice | 178 | 6 |
| NCL | F83039: The Rise Group Practice | 174 | 6 |
| NCL | E83653: The Phoenix Practice | 171 | 6 |
| NCL | E83010: The Speedwell Practice | 168 | 6 |
| NCL | E83012: The Old Court House Surgery | 134 | 6 |
| NCL | F83665: Swiss Cottage Surgery | 131 | 5 |
| NCL | E83032: Oak Lodge Medical Centre | 123 | 5 |
| NCL | F83674: The Junction Medical Practice | 115 | 6 |
| NCL | F83032: St Peter's Street Medical Practice | 112 | 5 |
| NCL | F83686: Stroud Green Medical Centre | 98 | 5 |
| NCL | F83044: The Bloomsbury Surgery | 97 | 6 |
| NCL | F85675: The Alexandra Surgery | 96 | 6 |
| NCL | F83021: Ritchie Street Group Practice | 93 | 3 |
| NCL | E83020: St. Georges Medical Centre | 91 | 5 |
| NCL | F83672: St Philips Medical Centre | 90 | 3 |
| NCL | F83061: Museum Practice | 89 | 5 |
| NCL | F83673: The Medical Centre | 86 | 6 |
| NCL | F83060: The Northern Medical Centre | 83 | 6 |
| NCL | F85058: Nightingale House Surgery | 81 | 4 |
| NCL | F83045: The Miller Practice | 81 | 6 |
| NCL | F83681: Partnership Primary Care Centre | 73 | 6 |
| NCL | F85628: Welbourne GP Surgery, Welbourne H C | 72 | 2 |
| NCL | E83003: Oakleigh Road Health Centre | 70 | 5 |
| NCL | F85687: Oakwood Medical Centre | 67 | 5 |
| NCL | F83057: Parliament Hill Surgery | 67 | 5 |
| NCL | F83056: The Mitchison Road Surgery | 67 | 6 |
| NCL | F85008: Staunton Group Practice | 66 | 5 |
| NCL | E83622: Temple Fortune Medical Group | 64 | 4 |
| NCL | F85067: The 157 Medical Practice | 63 | 6 |
| NCL | F83671: The Beaumont Practice | 63 | 5 |
| NCL | F83002: River Place Health Centre | 60 | 3 |
| NCL | F83015: St Johns Way Medical Centre | 58 | 3 |
| NCL | F85678: The Town Surgery Ltd | 56 | 5 |
| NCL | E83638: The Mountfield Surgery | 51 | 6 |
| NCL | E83009: Phgh Doctors | 49 | 3 |
| NCL | E83637: Colindale Medical Centre Lp | 49 | 2 |
| NCL | F83003: Park End Surgery | 49 | 5 |
| NCL | F85039: Rainbow Practice | 48 | 3 |
| NCL | F83011: Primrose Hill Surgery | 45 | 3 |
| NCL | E83649: The Hodford Road Practice | 44 | 6 |
| NCL | F83018: Prince of Wales Group Surgery | 43 | 3 |
| NCL | E83028: Parkview Surgery | 41 | 5 |
| NCL | Y02117: St Ann's Road Surgery | 37 | 2 |
| NCL | F85030: Somerset Gardens Family Health Centre | 37 | 3 |
| NCL | E83018: Watling Medical Centre | 34 | 1 |
| NCL | E83030: Penshurst Gardens Surgery | 34 | 5 |
| NCL | E83039: Ravenscroft Medical Centre | 31 | 3 |
| NCL | F85031: Westbury Medical Centre | 27 | 2 |
| NCL | F85032: Southgate | 27 | 2 |
| NCL | F83632: Queens Crescent Practice | 26 | 3 |
| NCL | E83025: Pennine Drive Practice | 25 | 5 |
| NCL | F83664: The Village Practice | 24 | 1 |
| NCL | F83623: Keats Group Practice | 22 | 2 |
| NCL | E83026: Supreme Medical Centre | 22 | 3 |
| NCL | F85642: The North London Health Centre | 21 | 1 |
| NCL | F85688: Rutland House Surgery | 21 | 3 |
| NCL | F85697: The Old Surgery | 20 | 5 |
| NCL | E83024: St Andrews Medical Practice. | 19 | 2 |
| NCL | F85065: Stuart Crescent Medical Practice | 18 | 4 |
| NCL | F83680: Sobell Medical Centre | 17 | 2 |
| NCL | F83683: Somers Town Medical Centre | 17 | 3 |
| NCL | F83007: Roman Way Medical Centre | 14 | 3 |
| NCL | F85013: Tynemouth Medical Practice | 14 | 1 |
| NCL | E83639: Rosemary Surgery | 10 | 3 |
| NCL | Y05330: Welbourne Med Prac, Welbourne H C | 10 | 1 |
| NCL | E83007: Squires Lane Medical Practice | 10 | 2 |
| NCL | F85025: White Lodge Medical Practice | 8 | 1 |
| NCL | E83021: Torrington Park Group Practice | 8 | 1 |
| NCL | Y00316: Woodlands Medical Practice | 7 | 1 |
| NCL | F85615: Tottenham Health Centre | 7 | 1 |
| NCL | E83031: The Village Surgery | 5 | 1 |
| NCL | F83034: New North Health Centre | 4 | 1 |
| NCL | E83668: Dr Sp Talpahewa | 3 | 1 |
| NWL | -------- | ---- |
| NWL | E87609: St Johns Wood Medical Practice | 3,341 | 23 |
| NWL | E85685: The Lilyville Surgery | 2,170 | 23 |
| NWL | E87061: The Pembridge Villas Surgery | 2,106 | 23 |
| NWL | E85042: The New Surgery | 1,817 | 23 |
| NWL | E85107: The Mill Hill Surgery | 1,255 | 22 |
| NWL | E87065: The Notting Hill Medical Centre | 1,252 | 23 |
| NWL | E85677: The Horn Lane Surgery | 1,152 | 23 |
| NWL | E85129: The Mansell Road Practice | 1,068 | 23 |
| NWL | E85038: Palace Surgery | 885 | 23 |
| NWL | Y02671: The Practice Heart of Hounslow | 355 | 1 |
| NWL | E87002: Victoria Medical Centre | 171 | 1 |
| NWL | Y02842: Half Penny Steps Health Centre | 146 | 1 |
| NWL | E85716: Bath Road Surgery | 135 | 1 |
| NWL | Y02672: The Practice Feltham | 114 | 1 |
| NWL | E87011: Lisson Grove Health Centre | 109 | 1 |
| NWL | E87046: The Randolph Surgery | 106 | 1 |
| NWL | Y01011: Barlby Surgery | 98 | 1 |
| NWL | E85719: Ashville Surgery | 96 | 1 |
| NWL | E85007: St. Margarets Practice | 96 | 1 |
| NWL | E85744: Argyle Health-Isleworth Practice | 92 | 1 |
| NWL | E85121: Guru Nanak Medical Centre | 86 | 1 |
| NWL | E87745: Cavendish Health Centre | 84 | 1 |
| NWL | E85663: The Saluja Clinic | 78 | 1 |
| NWL | Y00902: The Westbourne Green Surgery | 75 | 1 |
| NWL | E85004: Albany Practice | 74 | 1 |
| NWL | E85687: Acton Lane Medical Centre | 74 | 1 |
| NWL | E85680: Cloister Road Surgery | 72 | 1 |
| NWL | E85059: Chestnut Practice | 71 | 1 |
| NWL | Y02906: Canberra Old Oak Surgery | 71 | 1 |
| NWL | E85001: Thornbury Road Centre for Health | 71 | 1 |
| NWL | E85735: Brentford Family Practice | 70 | 1 |
| NWL | E87753: Belgrave Medical Centre | 68 | 1 |
| NWL | E85605: Brentford Group Practice | 66 | 1 |
| NWL | E85025: Cassidy Road Medical Centre | 63 | 1 |
| NWL | E87047: Earls Court Medical Centre | 59 | 1 |
| NWL | E85030: Chiswick Health Practice | 58 | 1 |
| NWL | E85697: Greenbrook Bedfont | 57 | 1 |
| NWL | E87663: Third Floor Lanark Road Medical Centre | 55 | 1 |
| NWL | E85712: Goodcare Practice | 53 | 1 |
| NWL | E85058: Blue Wing Family Doctor Unit | 52 | 1 |
| NWL | E87005: Belgravia Surgery | 52 | 1 |
| NWL | E85112: Elmtrees Surgery | 47 | 1 |
| NWL | E85013: Westseven GP | 47 | 1 |
| NWL | E85040: West4 Gps | 46 | 1 |
| NWL | E87066: Fitzrovia Medical Centre | 44 | 1 |
| NWL | E85108: Mandeville Medical Centre | 38 | 1 |
| NWL | E85075: GP Surgery @ Acton Gardens | 36 | 1 |
| NWL | E85617: Acton Town Medical Centre | 33 | 1 |
| NWL | E85023: Chepstow Gardens Medical Centre | 32 | 1 |
| NWL | E85024: Carlton Surgery | 31 | 1 |
| NWL | E85032: Ashchurch Surgery | 28 | 1 |
| NWL | E85130: Chiswick Family Practice | 27 | 1 |
| NWL | E85045: Twickenham Park Medical Centre | 25 | 1 |
| NWL | E87741: Woodfield Road Medical Centre | 23 | 1 |
| NWL | E85071: Clifford House Medical Centre | 17 | 1 |
| NWL | E87702: The Surgery | 14 | 1 |
| NWL | E85721: The Town Surgery | 10 | 1 |

### ⛔ Known bulk failures

We are tracking and investigating the following batch failures that include bulk extracts.

#### DevOps 27564 - superbatch failure (NEL and SEL practices)

**status**: data has now been reprocessed, ready to be transformed and published in the next upcoming release

affected practices with bulk extracts:

| ICB | ODS | Practice |
| --- | --- | --- |
| NEL | --- | --- |
| NEL | F86644 | Waltham Forest Comm & Fam Hth Serv Ltd |
| NEL | F84093 | Tollgate Medical Centre |
| NEL | F86034 | Green Lane, Goodmayes Medical Practice |
| SEL | --- | --- |
| SEL | G85032 | Torridon Road Medical Practice |
| SEL | G83021 | Vanbrugh Group Practice |

#### DevOps 27565 - superbatch failure (SWL practice)

**status**: data has now been reprocessed, ready to be transformed and published in the next upcoming release

affected practices with bulk extracts:

| ICB | ODS | Practice |
| --- | --- | --- |
| SWL | --- | --- |
| SWL | H85649 | Colliers Wood Surgery |

#### DevOps 27617 - SystmOne extract misconfiguration, NWL Group 16

The following practices are part of a group with a misconfigured extract specification within the SystmOne gateway. We are working to manually correct the extracted data to avoid a rebulk.

affected practices:

| ICB | ODS | Practice |
| --- | --- | --- |
| NWL | Y04225 | Ealing Community Prt - Care Home Service |
| NWL | E85049 | Belmont Medical Centre |
| NWL | E85006 | Waterside Medical Centre |
| NWL | E85005 | The Surgery, Dr Dasgupta & Partners |
| NWL | E85034 | Grosvenor House Surgery |
| NWL | E85091 | Brunswick Surgery |
| NWL | E87751 | Srikrishnamurthy Harrow Road Surgery |
| NWL | E85725 | The Grove Medical Practice |
| NWL | E85103 | Lady Margaret Road Medical Centre |
| NWL | E85021 | Yeading Medical Centre |

#### Unknown bulk error - NWL SystmOne Groups 14 and 5

An uknown bulk error appears to have occurred for NWL S1 Groups 14 and Groups 5. At this time we are unable to verify the cause, nor advise of a resolution beyond a likely reprocessing being required.

This affects the following practices:

| ICB | ODS | Practice |
| --- | --- | --- |
| NWL | E85643 | Meadow View |
| NWL | E87004 | Health Partners at Violet Melchett |
| NWL | E87738 | Knightsbridge Medical Centre |
| NWL | E85746 | Grove Park Terrace Surgery |
| NWL | E85028 | Hillcrest Surgery |
| NWL | E87016 | Holland Park Surgery |
| NWL | E85600 | Willow Practice |
| NWL | E85041 | Hanwell Health Centre (Naish) |
| NWL | E85718 | Hatton Medical Practice |
| NWL | E85658 | Holly Road Medical Centre |
| NWL | E85090 | Hammond Road Surgery |

## 🏗️ Schema issues

NOTE: THE BELOW IS OUT OF DATE AND WILL BE UPDATED

### general

- The following tables are not populated:
  - `FLAG` - this is because there is currently no mapping from EMIS data to the flag table.
- Evolution of the `RECORD_OWNER_ORGANISATION_CODE` column. It has been desribed as confusing as such we will work towards a managed change to a new set of definitions.

### allergy_intolerance

- The field `allergy_intolerance_core_concept_id` is reflective of the unmapped concept and is labelled incorrectly. This should be relabeled as a **raw_concept_id** i.e. `allergy_intolerance_raw_concept_id`
- The field `allergy_intolerance_raw_concept_id` is currently unmapped and is empty (all `null`)

### appointment_practitioner

- This table contains a significantly inflated volume of records due to the manner in which business id (`id` column) values are being generated by the common modelling transforms. Each batch will simply add to the table, rather than merge into the table.
- A full refresh will be conducted to rebase and correct this issue, once the underyling code used to generate the `id` values is also corrected.

### diagnostic_order

- The field `diagnostic_order_core_concept_id` is reflective of the snomed code contained in the dimension table supplied by EMIS. This is prone to errors and as a result should not be shown. Instead users should apply mapping using the terminology tables supplied, via a join to the `diagnostic_order_raw_concept_id`. This field will be removed.
- **TO BE CONFIRMED:** The field `is_primary` is not defined correctly and will display `FALSE/0` for all records.

### encounter

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `encounter_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `encounter_raw_concept_id` as a result in future releases.

### medication_order

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `medication_order_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `medication_order_raw_concept_id` as a result in future releases.

### medication_statement

- The field `is_deleted` is the source value from EMIS and should be replaced by a supplier agnostic column `lds_is_deleted` which will standardise the representation of the deleted state across all data sources. This field will be removed and replaced in due course.
- The field `medication_statement_core_concept_id` is reflective of the supplied surrogate key value for the encoding of the consultation type. This is a **raw** concept and should be relabelled as such. This will be relabelled as `medication_statement_raw_concept_id` as a result in future releases.
- The field 'bnf_reference' is marked as a legacy field in the provider's documentation. The field is set to null for all rows.

### observation

- the field `observation_raw_concept_id` is set to `null` for all items.
- the field `observation_core_concept_id` is reflective of the source datas encoding (or surrogate key value) and is therefore a **raw** concept. This should be relabelled as such. This will be relabelled as `observation_raw_concept_id` and will replace the existing field of the same name.
- the field `is_problem` is **not** defined correctly and will display `TRUE/1` for all records.
- the field `is_primary` is **not** defined correctly and will display `FALSE/0` for all records.

### person

- the field `organisation_id` is missing.

### person_address (masked)

- the field `organisation_id` is missing.

### person (masked)

- `primary_patient_id` is incorrectly labelled as `LDSBusinessId_PrimaryPatient`.
- `matched_nhs_number_hash` is missing an underscore, and is incorrectly shown as `matched_nhs_numberhash`

### practitioner

- the field `organisation_id` is missing.

### procedure_request

- the field `procedure_core_concept_id` is a reflection of the source datas encoding (or surrogate key), and should be labelled as such as a **raw** concept. This field will be relabelled to `procedure_raw_concept_id`
- the field `organisation_id` is missing.
- the field `status_concept_id` is a reflection of the source datasets representation of the concept, but does undergo transformation to standardise this representation (expressed as boolean columns in the source). It will be confirmed whether this should be relabelled as **raw** or left as is.

### referral_request

- the field `referral_request_priority_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabbeld as `referral_request_priority_raw_concept_id` at a later release.
- the field `referal_request_type_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabbeld as `referral_request_type_raw_concept_id` at a later release.
- the field `referral_request_specialty_concept_id` is reflective of the source datasets coding system and is therefore a **raw** concept. This should be relabelled as such. This field will be relabeled as `referral_request_specialty_raw_concept_id` at a later release.
- the field `encounter_id` is currently hardcoded to `null` for all EMIS data. We will investigate if it is possible to map this safely in a future release (using the `CareRecord_Observation` field `ConsultationGuid`, which is a foreign key to the table `CareRecord_Consultation` which is used to populate the `encounter` OLIDS table)

### person (pcd)

The fields “telephone_number”, “mobile_number”, “email_address”, “sensitivity_flag” and “mps_id” are set to null to mitigate a formatting error in the source data which would otherwise risk the leaking of identifying data. Contact information in patient_contact is unaffected. Sensitive patient filtering is based on error_success_code so is unaffected.
- the birth date of the patient is presented as returned by PDS, however no determination of date precision not conversion to date (from varchar) is applied.
- the birth week (iso) is not currently derived.
- the death date of the patient is presented as returned by PDS, however no determination of date precision not conversion to date (from varchar)is applied.
- the death week (iso) is not currently derived.
- the following fields are labelled by PDS as to be ignored, but are still currently displayed in the person object, these will be removed in a subsequent release:
  - `as_at_date`
  - `local_patient_id`
  - `internal_id`
  - `mps_id`

## patient

- Within the pre‑production environment, the Date of Birth (DOB) field contains NULL values as of 08/01/2026. Because DOB is used to derive Birth Year and Birth Month, these downstream fields are also being populated as NULL in the output dataset. This affects both EMIS and TPP data set.

## appointment

- The field booking method concept id doesn't appear to be available within TPP data set, as such all TPP's booking method concept is set as NULL from the derivation as of 08/01/2026. EMIS is not affected.

## `RECORD_OWNER_ORGANISATION_CODE` Evolution

Note that we have formalised the definitions of "publisher", "author" and "supplier" as below:

- PUBLISHER / `ORGANISATION_CODE_PUBLISHER`
  - is the data controller authorising the publication of data into the London Data Service, and directly governs onward distribution of a record
  - example 1: a GP Practice may be the PUBLISHER of a GP appointment record
  - example 2: NHS England may be the PUBLISHER of a Commissioning Data Set / MHSDS record
  - example 3: Facts and Dimensions Ltd may be the PUBLISHER of a reference data object from "UK Health Dimensions" a record

- AUTHOR  / `ORGANISATION_CODE_AUTHOR` (not currently shown)
  - is the originating controller that creates the record information.
  - example 1: a GP Practice may be the AUTHOR of a GP appointment record
  - example 2: Barts Health Trust may be the AUTHOR of a Secondary User Services (SUS) Commissioning Data Set record
  - example 3: the Office For National Statistics may be the author of a reference item within a "UK Health Dimensions" table

- SUPPLIER / `ORGANISATION_CODE_SUPPLIER` (not currently shown)
  - is the organisation / entity that provides the data (or access to the data) to the London Data Service, but does not necessarily govern the data flow (i.e. they may be a processor, not a controller).
  - example 1: a GP system supplier such as EMIS or TPP may be the SUPPLIER of a GP appointment record.
  - example 2: a Data Services for Commissioners Regional Office (DSCRO) may be the SUPPLIER of a CDS record.
  - example 3: Facts and Dimensions Ltd may be the SUPPLIER of their own "UK Health Dimensions" records.

An organisation can simultaneously be publisher, author and supplier of a record. This would mean that they are responsible for the originating governance of the record (data capture), are directly responsible for submission to London Data Services (i.e. they do not submit to a intermediary data controller operating a larger data collection), and directly facilitate the flow of data into the London Data Service (i.e. they do not use a sub-processor or processor to supply that data into the service).

An organisation may take other contextual roles related to the event record in question. For example:

- `ORGANISATION_CODE_PROVIDER`: An organisation responsible for delivery of a care service to a service user / patient.
- `ORGANISATION_CODE_MANAGING`  An organisation responsible for the delivery of care to a service user or patient. This context is used in scenarios or context in which multiple providers may contribute to the same event, but one must be responsible overall for the delivery (i.e. episode of care)
- `ORGANISATION_CODE_

A refined column naming convention will be phased into the OLIDS schema, with an initial release linked to episode of care.
