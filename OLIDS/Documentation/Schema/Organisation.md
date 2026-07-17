# Organisation

- [Organisation](#organisation)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity relationships](#entity-relationships)
  - [Notes](#notes)

## Overview

Linked FHIR resource: [🔥 Organization](https://hl7.org/fhir/organization.html)

The Organisation resource is used for collections of people that have come together to achieve an objective. The Group resource is used to identify a collection of people (or animals, devices, etc.) that are gathered for the purpose of analysis or acting upon, but are not expected to act themselves.

In the context of service provision, the Organisation provides the services, the HealthcareService describes the services provided, and the Location describes the place where the service(s) are offered/available.

The Organisation resource often exists as a hierarchy of Organisation resources, using the part-of property to provide the association of the child to its parent Organisation.
This Organisational hierarchy helps communicate the conceptual structure, whereas the Location resource provides the physical representation of the hierarchy.
The linkage between Organisation and Location is from each point in the location hierarchy to the appropriate level in the Organisation hierarchy. These links don't all have to be to the top level Organisation.
When populating the Organisation and location hierarchies there is often not a clear distinction between these 2, however to assist in making the decision, Locations are always used for recording where a service occurs, and hence where encounters and observations are associated. The Organisation property on these resources might not be the location where the service took place.

OrganisationAffiliation allows you to specify details about Organisation affiliations that are more complex than simple partOf relationships, such as Organisations that are separate legal entities, or have other non-hierarchical relationships. No ownership is implied via OrganisationAffiliation. A single OrganisationAffiliation represents the details of a single relationship between a single pair of Organisations, including the period during which the relationship is active. Current network members can be discovered by searching for OrganisationAffiliations, and historic data can be retained without overhead and still be accessible when searching.

As noted in the Event pattern, a Location represents where a service is performed. An Organisation can represent who performed the service.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Compass Equivalent |
| --- | --- | --- | --- | --- |
| `ID` | `UUID` | id. | | `id` |
| `LDS_SOURCE_RECORD_ID` | `UUID` | lds record id. | | -- |
| `ORGANISATION_CODE` | `VARCHAR` | organisation code. | | `ods_code` |
| `ASSIGNING_AUTHORITY_CODE` | `VARCHAR` | assigning authority code. | | -- |
| `NAME` | `VARCHAR` | name. | | `name` |
| `PRIMARY_LOCATION_TYPE_SOURCE_CONCEPT_ID` | `UUID` | type code. | FK --> [Concept](Concept.md).CONCEPT_ID | `type_code` |
| `TYPE_DESCRIPTION` | `VARCHAR` | type desc. | | `type_desc` |
| `POSTCODE` | `VARCHAR` | postcode. | | `postcode` |
| `PARENT_ORGANISATION_ID` | `UUID` | parent organisation id. | FK --> [Organisation](Organisation.md).ID | `parent_organization_id` |
| `OPEN_DATE` | `DATE` | open date. | | -- |
| `CLOSE_DATE` | `DATE` | close date. | | -- |
| `IS_OBSOLETE` | `BOOLEAN` | is obsolete. | | -- |
| `LDS_IS_DELETED` | `BOOLEAN` | lds is deleted. | | -- |
| `SOURCE_EXTRACTION_DATE` | `TIMESTAMP` | source extraction date. | | -- |
| `LDS_TRANSFORM_DATETIME` | `TIMESTAMP_LTZ` | lds transform date time. | | -- |

## Entity relationships

> [!NOTE]
> Diagrams below are currently indicative. The precise optional/mandatory nature of certain relationships remains to be clarified.

See references to Organisation in other tables

## Notes

Table is provided by some suppliers (including both EMIS/Optum and TPP) as an 'unowned' reference dimension. As such it is not possible to allocate records to a specific recipient and instead the records are surfaced to consumers without row-access policies applied. There is no patient related data contained in this object and therefore no risk to sharing.
