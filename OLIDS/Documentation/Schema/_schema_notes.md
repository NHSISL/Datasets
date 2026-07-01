# Schema notes

- [Provider, Author, Publisher Organisation ID](#provider-author-publisher-organisation-id)
    - [Publisher Organisation](#publisher-organisation)
    - [Author Organisation](#author-organisation)
    - [Provider Organisation](#provider-organisation)
    - [Supplier Organisation](#supplier-organisation)

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
