# Schema notes

- [Schema notes](#schema-notes)
  - [Standards](#standards)
    - ["datetime" or "date time"](#datetime-or-date-time)
    - [source concept ID](#source-concept-id)
  - [Provider, Author, Publisher Organisation ID](#provider-author-publisher-organisation-id)
    - [Publisher Organisation](#publisher-organisation)
    - [Author Organisation](#author-organisation)
    - [Provider Organisation](#provider-organisation)
    - [Supplier Organisation](#supplier-organisation)
  - [Patient Ages](#patient-ages)

## Standards

### "datetime" or "date time"

This schema uses a standard of "DATETIME" (one word) rather than "DATE TIME" (two words)

### source concept ID

OLIDS objects will store the source systems code or concept, mapping can then be applied locally on demand by the consumer. To clarify this behaviour all such encoded concepts are noted as "SOURCE" concept identifiers. This is to clear denote that they are representative of the value as supplied by the source system.

## Provider, Author, Publisher Organisation ID

The majority of tables include a Publisher, Provider and an Author ID. These are included as all three can differ and represent different contextual relationships between a record and an organisation.

> [!NOTE]
> Some tables include additional Organisation IDs specific to their context.

### Publisher Organisation

A publisher is the controller who permits the release of data to the London Data Service for processing and eventual publication to a subscribing organisation or individual.

The publisher of an electronic healthcare record can be the provider of the healthcare event, or a party involved in the gathering or consumption of data relating to that healthcare event. A publisher may or may not be the record author.

Examples of scenarios in which the publisher is **not** the author include:
- the publication of Commissioning Data by NHS England to commissioners. For these datasets, the authoring organisations are the individual healthcare providers, but they initially submit their individual collections of data to NHS England as a national collector of the data, who then assumes a data controller role under the terms of the Health and Social Care Act 2012. NHS England then issues Data Sharing Agreements to commissioners, and other organisations, to permit the release of data for various purposes.
- Extracts from clinical systems that use or include record-sharing between organisations, such as TPP. In these systems a publisher may be aware of records authored or provided by another organisation, and these are included in their publications to LDS. In these situations the publisher will release the records to LDS, but they are not the originating author.

A publisher is often identifiable in the dataset as the closest proximal data controller to the London Data Service for that dataset on the way into the service. The full determination of the publisher of a dataset will be indicated by the data controller who permitted the release of data into the service for onward publication to a subscriber.

### Author Organisation

An author is the controller who generated the record and captured the information from primary sources into an electronic record, including from other systems.

The author of an electronic healthcare record will typically be the provider of that care. The author is distinguished from other controller types by their role in gathering the data directly from real-world events and transcribing into an electronic record.

Note that a record Author can also be a record Publisher and a record Supplier, dependent upon the various roles that the organisation carries out in capturing and sharing of the record.

### Provider Organisation

A provider organisation is the organisation responsible for the delivery or management of care. These organisations are clinically responsible for the event or entity described.

### Supplier Organisation

A supplier is a controller or processor organisation, that delivers the data to the London Data Service. A supplier may be either a controller or processing organisation. In cases where the supplier is a controller, they will often be a publisher and/or author as well. However in cases where the supplier is a processor only, they cannot be the record author or record publisher due to their role as a processor.

Suppliers may be a healthcare system supplier as well. An example of this is in the Primary Care EMIS / Optum dataset. In this scenario, EMIS/Optum are the supplier of the data. They orchestrate the extraction of data from individual primary care services (who are the record authors and record publishers in this scenario), and supply those extractions to the London Data Service through a secure file transfer service.

## Patient Ages

Ages shown in the OLIDS dataset for de-identified (also known as "masked" or "pseudonymised") data are shown in:

- whole integer years
- age brackets aligned to HES child ages
- days since birth up to 27 days for neonates

This is aligned with the Hospital Episode Statistics age categorisation as below:

| OLIDS Column | HES column | Definitions | Values |
| :--- | :--- | :--- | :--- |
| `AGE_AT_EVENT` | `age` | **HES:** <br> Number of whole years between patient's date of birth and the event. <br>The event date typically used is the end date, unless otherwise stated within the column name. <br><br>**OLIDS:**<br> Number of whole years between patient's date of birth and the event. <br>The event date typically used is the end date, unless otherwise stated within the column name. | nnn = Age in years |
| `AGE_AT_EVENT_BABY` | `ENDAGE` and `STARTAGE` (APC) <br> `APPTAGE` (OP) <br> `ARRIVALAGE` (AE) | **HES:**<br>The patient's age, in completed years, at the end of a finished episode. <br>For patients under 1 year old, special codes in the range 7001 to 7007 apply.<br><br>**OLIDS:**<br>The patient's age, in completed years, at the end of an event. <br>For patients under 1 year old, special codes in the range 7001 to 7007 apply. | nnn = Age in years<br> 120 = 120 years or more<br> 7001 = Less than 1 day  <br> 7002 = 1 to 6 days  <br> 7003 = 7 to 28 days  <br> 7004 = 29 to 90 days (under 3 months)  <br> 7005 = 91 to 181 days (approximately 3 months to under 6  months)  <br> 7006 = 182 to 272 days (approximately 6 months to under 9 months)  <br> 7007 = 273 to <1 year (approximately 9 months to under 1 year)  <br> Null = Not applicable (other maternity event) or not known <br> [See HES Data Dictionary](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics/hospital-episode-statistics-data-dictionary)|
| `AGE_AT_EVENT_NEONATE` | `NEODUR` (APC) | **HES:** <br>The age in days of a baby admitted as a patient. It is derived from the Admission Date (ADMIDATE) and Date of Birth (DOB). <br>If the baby is older than 27 days, NEODUR is not calculated. <br><br>**OLIDS:** <br>The age of a patient at the end of an event where the patient is under 28 days old.<br> If the baby is older than 27 days, no age in days is given. | 2n = Age of patient in days from 0 to 27. <br> `NULL` = Not applicable. Patient is older than 27 days. |
