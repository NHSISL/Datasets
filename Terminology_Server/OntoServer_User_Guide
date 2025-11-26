OntoServer User Guide
=====================

Contents:
---------

Part | Topic
---- | -----
**1** | [Introduction](#introduction)
1.1  | Code System
1.2  | Value Set 
1.3  | Concept Map
**2** | [Snapper](#snapper)
2.1  | Creating a code system
2.2  | Creating a value set 
2.3  | Creating a Concept Map
2.4  | Creating a concept map in Snapper: Author
2.5  | Creating a concept map in Snapper: Map
2.6  | Searching in Snapper
**3** | [Shrimp](#shrimp)
3.1  | Expression Constraint Language
3.2  | Building SNOMED-CT Expressions
**4** | [APIs](#apis)
**5** | [Appendices](#appendices)
5.1  | Appendix 1
5.2  | Appendix 2
5.3  | Appendix 3

---

## Introduction

Ontoserver is a clinical terminology server that implements the Fast Healthcare Interoperability Resources (FHIR) standard for exchanging electronic health data. It serves as a platform for managing and sharing terminology related resources like Code Systems, Value Sets and Concept Maps.

**Code Systems** are structured sets of codes that represent specific concepts within a healthcare setting. Examples include SNOMED CT, LOINC, or ICD-10.  
**Value Sets** reference standardised code systems like SNOMED CT, LOINC, or ICD-10, ensuring interoperability and consistency across different systems. Custom value sets can be created to meet specific needs, allowing for flexibility and adaptation to different contexts.  
**Concept Maps** define relationships between codes from different code systems. They translate the codes from one Code System / Value Set to another.


The OneLondon instance of Ontoserver can be accessed here: 

[OneLondon Terminology server - Navigation and Service Status](https://ontology.onelondon.online/)


It enables the navigation of different features that Ontoserver offers, including:
* Access to the authoring tool (Snapper)
* API endpoints
* Terminology Browsing tools (Shrimp)
* User and community admin
* Admin tool access (Authoring and Production servers)

---

## Snapper

The Authoring Tool is comprised of Snapper:Author and Snapper:Map components.
* [Snapper:Author](https://ui.ontology.onelondon.online/snapper/?iss=https://ontology.onelondon.online/authoring/fhir) enables the creation and maintenance of the FHIR® terminology resources: CodeSystem, ValueSet, and ConceptMap.
* Snapper:Map *(click button/link top right of webpage)* streamlines ConceptMap authoring and maintenance

Use the **Authoring Server** to create content and the **Production Server** to explore and access content.

The first time you access Snapper, you will be asked to accept the terms of use.
Scroll to the bottom, checking the appropriate boxes, before accepting the sub-license conditions.

Click the green Login button in the top right-hand corner (to log in). A sign in page will appear.  
Sign in with your username and password.  
If you have an nhs.net account, you can link your Microsoft account to your profile enabling you to use the ‘Microsoft’ button at the bottom of the page.

There are different levels of access:  
**Consumer:** Read-only access and the ability to access the Account Management console.  
**Author**: Read and write access and the ability to access the Account Management console.  
**Approver**: All the capabilities of an author, plus the ability to syndicate resources for publication and access the Account Management console.  

Once logged in, the green button will change to a combination of red and light blue.

### Creating a code system

Code systems may be created for a number of reasons. A service may receive historic data from a legacy system and want to map it to an up-to-date code system (like SNOMED-CT). In order to use data that comes from a different code system, it is necessary to create that Code System in Ontoserver.

Here is a [link to a video](https://www.youtube.com/watch?reload=9&v=qToK8al2vr8&feature=youtu.be) that can help visualise the following steps:


1. Click the green button next to “FHIR Code Systems” on the tool bar on the left of the screen.
2. Enter a title (see appendix 1)
3. Enter a name  (see appendix 1)
4. Enter a URI (see appendix 2)
5. Enter a version number (see appendix 3)
6. State whether the code system is case sensitive (or not)
7. Codes and descriptions can be entered manually into the fields or imported from a csv, tsv or scsv file.
8. Click the ‘Additional Metadata” tab to enter ‘Publisher’, ‘Name’ and contact ‘Details’
9. A ‘Narrative’ providing some additional information about how the Code System is to be used (or describing its purpose) can be added in the third (Narrative) tab if desired.
10. Then select the fourth tab – ‘Upload to FHIR server’.

It is recommended that a validation is performed and if there are no errors or issues to fix, the resource can be uploaded using the ‘Upload Code System’ button. A message will appear when it has successfully uploaded.

### Creating a value set

Value sets can be used in the front end of computer systems to limit the range of possible values that can be entered into a field. They can also be used to apply conditional logic and ensure that data complies with Industry standards.

Here is a [link to a video](https://www.youtube.com/watch?v=u1wAOk3Y-0w) that can help visualise the following steps:

1. Follow steps 1 to 5 (above) for creating a code system (selecting the green button next to FHIR Value Sets instead of next to FHIR Code Systems)
2. Specify the code system (or systems) and version that the codes in the value set have come from.
3. Follow steps 7 to 11 (from Code System above) to successfully upload your value set.


### Creating a Concept Map

The ability to define relationships between concepts can be useful. Relationships can help facilitate the transition from older code systems (like EMIS or TPP) to newer standards (like SNOMED) which can support interoperability in healthcare systems.  
There are two ways that Snapper can be used to create concept maps:
* A Concept map can be created in Ontoserver using Snapper: Author
* Or it can be created using Snapper: Map

### Creating a concept map in Snapper: Author

If the concepts have already been mapped and the Concept Map just needs to be uploaded into OntoServer, Snapper: Author is the appropriate tool.
1. Click the green button next to “FHIR Concept Maps” on the tool bar on the left of the screen.
2. Enter a title (see appendix 1)
3. Enter a name  (see appendix 1)
4. Enter a URI (see appendix 2)
5. Enter a version number (see appendix 3)
6. Enter a Source Code System (this is the code system that the codes in your concept map are mapping from). It must already be stored in OntoServer and can be found either by searching the name, description or URL. A version and/or value set can also be entered.
7. Enter a Target Code System (this is the code system that the codes in your concept map are mapping to). It must already be stored in OntoServer and can be found either by searching the name, description or URL. A version and/or value set can also be entered.
8. The codes can be entered manually into the fields or imported from a csv, tsv or scsv file.
9. Click the ‘Additional Metadata” tab to enter ‘Publisher’, ‘Name’ and contact ‘Details’
10. A ‘Narrative’ providing some additional information about how the Code System is to be used (or describing its purpose) can be added in the third tab if desired.
11. Then select the fourth tab – ‘Upload to FHIR server’.
12. It is recommended that you validate first and if there are no errors or issues to fix, you can Upload the Concept Map. You will get a message to say that it has successfully uploaded.

### Creating a concept map in Snapper: Map
If the maps don’t already exist and need to be created, there is an automap feature in Snapper:Map and once mapped, can be loaded directly into OntoServer.

Here is a [link to a video](https://www.youtube.com/watch?v=RRbSoQ927bw) that can help visualise the following steps:

1. Click on Snapper:Map in the top right hand corner of the screen
2. You may need to log in again.
3. Click the green button next to “Classic Maps” on the tool bar on the left of the screen.
4. Enter a title
5. Click on “Reference an existing CodeSystem”
6. Change ‘Source’ to the code system you are mapping from. It should be stored in OntoServer and can be found either by searching the name, description or URL. You can also enter a value set that references that code system.
7. Change the target to the code system you are mapping to. It should be stored in OntoServer and can be found either by searching the name, description or URL. You can also enter a value set that references that code system.
8. Select the mapping relationships that are required and press “Done”.
9. The menu can be accessed by clicking on the three horizontal lines at the top of the screen.
10. A drop-down menu will appear. It contains a number of options including ‘show source codes’, ‘select all rows’ and ‘Metadata’ which, when clicked, will re-open the screen where the title information was entered (see point 4 above).
11. The codes that are to be mapped from the source code system can be imported from a csv, tsv or scsv file.
12. Click the button for source code and then select the column that contains the source codes and do the same to select the column with the source label.
13. The same can be done with target code and target label (if you are not automapping).
14. Select one, two or all the rows and “Automap”
15. Mappings should be validated for accuracy and equivalences entered by selecting the appropriate choice from a drop-down in the ‘Map’ column. Select “equivalent” if the two codes are similar in meaning or “inexact” if they are not. (More information about equivalences can be found here).
16. When the mappings are complete and validated, the concept map can be uploaded to Ontoserver by clicking the three horizonal lines and selecting ‘upload’.


### Searching in Snapper

Return to Snapper:Author and select the button that says “Find existing FHIR Resources”. Code Systems, Value Sets and Concept Maps can be searched by Name, ID or URL

Once the resource has been found, click the green button next to the resource.
And it will appear in the menu on the left-hand side. The Code System, Value Set or Concept Map can be viewed in Snapper.

---

## Shrimp

[Shrimp](https://ontoserver.csiro.au/shrimp/launch.html?iss=https://ontology.onelondon.online/production1/fhir) is a web-based terminology browser that allows users to search, visualize, and explore hierarchical terminologies like SNOMED CT and LOINC. There are other ways of viewing code systems (e.g. using the [NHS SNOMED Browser](https://termbrowser.nhs.uk/?)), but Shrimp enables the use of Expression Constraint Language to precisely define complex criteria and relationships between concepts which can help when building value sets.

The tabs (top right in the browser) allow the user to choose code systems or value sets and also there is the ability to search (or filter) a specific resource and version. The ‘search terms’ field allows the user to enter terms to find concepts e.g. “hypertension”.

The main part of the Shrimp web page gives a visual representation of where a concept fits into SNOMED (showing both parent and child relationships) and allows exploration through the hierarchy. Any concept that is clicked on (or selected) becomes the concept in focus.

A purple box means that the concept is sufficiently defined, whereas the blue boxes are primitive concepts. More information about this can be found [here](https://confluence.ihtsdotools.org/display/DOCEG/Sufficiently+Defined+vs+Primitive+Concept).

At the bottom of the page there is more information about the code that has been selected (including its fully specified name, the preferred term and any synonyms)


### Building SNOMED CT expressions  
Begin by clicking the **ECL** button in the blue bar at the top of the screen.

ECL stands for Expression Constraint Language. It is a formal language used to define sets of clinical meanings within SNOMED CT. You can find out more [here](https://docs.snomed.org/snomed-ct-user-guides/mrcm-maintenance-tool-user-guide/faqs/the-expression-constraint-language-ecl)

Start by clicking the **New query** button, on the top left-hand side of the screen
Give it a name and choose the concept(s) that you want to include in your query.
Other concepts and different types of relationship (for example) can be excluded. 
And the result is a list of matches.

The query can be saved and re-used, or the Value Set can be copied and pasted into snapper for use in a concept map.

---

## API’s

One of the limitations of Snapper as a tool to author Code Systems, Values Sets and Concept Maps is that it is a browser-based user interface and there is a limit to how much information it can hold.

For bigger resources, sending requests directly to Ontoserver using APIs can work better.

To find out more about Postman and using APIs to Create, Read, Update and Delete resources in Ontoserver, please see the ‘Ontoserver Guide to Postman’.

---


## Appendices

### Appendix 1: Title and naming standards

The authoring server is an area where users can create their own resources for their own use. 

However, it may be that some of those resources have wider value and could be added to the production server, where they can be used across the whole of London.

In those instances, a naming convention should be used for Code Systems, Value Sets and Concept Maps.

The ‘title’ should start by referencing the code system (or systems in the case of a concept map) that are contained, followed by a short description that briefly describes the content and reference to the type of resource (“cs” for code system, “vs” for value set or “cm” for concept map), for example a concept map that maps EMIS drug codes to SNOMED should have the title “EMIS to SNOMED DrugCodes cm”

The ‘name’ should be computer readable. You can copy and paste the title into the name field, but Ontoserver will automatically add underscores in place of spaces e.g. “EMIS_to_SNOMED_DrugCodes”.


### Appendix 2: URI Standards

URIs (or URLs) are needed when creating code systems, value sets and concept maps. Ideally, they should reference an actual place on the internet where the resource can be found.

If there isn’t an online resource, then a URI (or URL) is still required.

All URIs should start with **https://** plus a reference to the author or owning organisation followed by a **.com**, **.net** or **.nhs**. Following that would be a forward slash and a reference to the content, another forward slash and a reference to the resource itself.

For example, a URI for a value set created by the London Data Service (LDS) that has diabetes codes in it would look like: https://LDS.nhs/diabetes/vs (where vs = value set)
A URI for a code system might look like https://LDS.nhs/UCUM/cs (where cs = code system).
A URI for a concept map might look like https://LDS.nhs/UCUMtoSNOMED/measurements/cm (where cm = concept map)


### Appendix 3 Versioning 

All terminology resources support versioning, with a new version created every time a resource (e.g. concept map) is updated. There is no limit to the number of versions that we can keep.
