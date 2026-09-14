# Concept

- [Concept](#concept)
  - [Overview](#overview)
  - [Columns](#columns)
  - [Entity Relationships](#entity-relationships)

## Overview

Linked FHIR resource: [🔥 CodeSystem.Concept](https://hl7.org/fhir/codesystem-definitions.html#CodeSystem.concept)

Concepts that are in a code system. The concept definitions are inherently hierarchical, but the definitions must be consulted to determine what the meanings of the hierarchical relationships are.

## Columns

| Column Name | Data Type (Size) | Description | PK/FK | Masking Policy | Compass Equivalent |
| --- | --- | --- | --- | --- | --- |
| `CONCEPT_ID` | `UUID` | unique identifier | PK | | |
| `CODE` | `VARCHAR` | the code described by this concept identifier | | | |
| `DISPLAY` | `VARCHAR` | the description or displayed text for this code | | | |
| `SYSTEM` | `VARCHAR` | the concept system that this concept falls within (i.e. snomed, EMIS concepts, CTV3) expressed as the URL within ontoserver. | | | |
| `PRESENT_IN_TERMINOLOGY_SERVER` | `BOOLEAN` | true where the concept_ID exists within ontoserver terminology services | | | |
| `IS_MAPPED` | `BOOLEAN` | true where the Concept_ID has an entry within the concept_map object | | | |
| `USE_COUNT` | `VARCHAR` | currently not populated | | | |

## Entity Relationships

Please see individual OLIDS tables for relevant relationships with other objects.
