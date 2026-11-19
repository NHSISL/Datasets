# Migrating to OLIDS

This folder contains guidance and resources to help you transition from other dataset schemas (such as Compass from Discovery Data Services) to the **One London Integrated Data Set (OLIDS)**.

## What is OLIDS?

OLIDS is a standardized data model that provides a consistent, unified view of healthcare data regardless of the source system (EMIS, TPP, etc.). Instead of working with multiple different table structures and naming conventions, OLIDS presents data in a single, predictable format.

### Benefits of Moving to OLIDS

- **Consistency**: Work with familiar table and field names across all data
- **Simplicity**: Reduced learning curve when switching between different data sources
- **Quality**: Enhanced data validation and documentation
- **Integration**: Easier to combine data from multiple providers in unified analyses

## Transitioning from Compass (DDS)

If you're currently using the Compass schema from Discovery Data Services, OLIDS offers comparable coverage of clinical and operational data.

You'll find that the core entities (patients, episodes, diagnoses, etc.) exist in OLIDS, but table and field names differ from Compass.

## Getting Started

### 1. Understand the OLIDS Data Model

Review the available documentation to familiarize yourself with the OLIDS structure:
- **[Schema Documentation](../Schema/)** - Descriptions of all tables and their fields
- **[Source Data](../Source-data/)** - Understanding what data is available and where it originates

### 2. Map Your Current Queries

Take your existing analyses and identify equivalent tables and fields in OLIDS. Document:
- Which OLIDS tables contain the data you need
- How field names have changed
- Any differences in data format or calculation logic

### 3. Validate Your Results

When you've rewritten your queries for OLIDS:
- Compare record counts with your previous results
- Spot-check specific patient records for consistency
- Verify that calculated metrics align with expectations

### 4. Migrate Your Analyses

Once you've validated a few key queries:
- Gradually migrate remaining analyses to OLIDS
- Document any findings or discrepancies
- Share lessons learned with colleagues

## Migration Resources

| Resource | Purpose |
|----------|---------|
| [known deviations from DDS](./known-deviations-from-DDS.md) | A list of known variances when migrating from Compass / DDS |
