OntoServer Guide to Postman
=====================

Contents:
---------

Part | Topic
---- | -----
**1**| [Introduction](#introduction)
1.1  | Client credentials
**2**| [Code Systems](#code-systems)
1.1  | How to READ a Code System
2.2  | How to PUT a Code System
2.3  | How to update a Code System
**3**| [Value Sets](#value-sets)
3.1  | How to Search a Value Set by name
3.2  | How to expand a Value Set
**4**| [Concept Maps](#concept-maps)
4.1  | How to read a concept map
4.2  | How to update a concept map

---

## Introduction

One of the limitations of Snapper as a tool to author Code Systems, Values Sets and Concept Maps is that it has a browser-based user interface and there is a limit to how much information it can hold.

For bigger resources, sending requests directly to Ontoserver using an Application Programming Interface (API) can work better.

Postman is an environment that supports the building, testing and use of APIs.

[The Postman website can be accessed here](https://www.postman.com/lp/ent-api-postman/?utm_campaign=gg_emea_tier1_search_bofu_brand&utm_source=google&utm_medium=cpc&utm_content=brand_exact&utm_term=postman&rm_gid=176288922947&rm_ci=22103383812&rm_kw=postman&rm_mt=e&rm_n=g&rm_cr=784172502453&gad_source=1&gad_campaignid=22103383812&gclid=Cj0KCQiAiqDJBhCXARIsABk2kSmNVAX5KOmyIM5RWd0hkgU4EpSo4_c3WI-lz2_6LmIxIcXGrj73eLAaAticEALw_wcB)

Postman also enables the creation and sharing of collections. Ontoserver collections can be imported into your own Postman instance. 

These collections contain CRUD (Create, Read, Update and Delete) operations using the POST, GET, PUT and DELETE, HTTP method (see onelondon.postman.zip).

**GET requests** are used to get data from an endpoint. For example, you can read specific information in a concept map, by sending a GET request.

**POST requests** send data (usually in JSON or XML format) via an API  to Ontoserver. For example, you can create a code system using a POST request.

**PUT requests** are used to overwrite an existing piece of data. For example, if you create a concept map using a POST request, you can add more maps by using a PUT request.

**DELETE requests** are used to delete data that was previously created via a POST request. For example, a value set that is no longer needed, could be deleted by using a DELETE request.

### Client Credentials

In order to connect Postman to Ontoserver, you will first need Client Credentials. These can be requested from the OneLondon Terminology service via the IT Service Desk.

In the collection, under the heading “Authentication”, there is a POST request called “Obtain Token – System Account”.

Click on the ‘Body’ tab and select the ‘x-www-form-urlencoded’ radio button (if not already selected) you will see the grant_type, client_id and client_secret options in the body.

You will need to put your own client_id and client_secret into the API by first hovering over the {{client_id}} and {{client_secret}} values and then entering your credentials into the field that appears. Save (top right) and then press the blue “send" button.

Once the request has been sent (or posted), you should receive a response in the body that looks a little like the below.

```

    "access_token": 
    "xxx this would be a long stream of letters and numbers xxx",  
    "expires_in": 28800,
    "refresh_expires_in": 0,
    "token_type": "Bearer",
    "not-before-policy": 0,
    "scope": "PERM_core_READ profile PERM_LDS_WRITE PERM_restricted_READ username PERM_core_WRITE PERM_LDS_READ"

```

Once connected you can start using Postman to Create, Read, Update and Delete resources in Ontoserver.

---

## Code Systems

If you are already proficient with JSON and using APIs, then you can find the [FHIR specification for Code Systems here](https://hl7.org/fhir/R4/codesystem.html). 
If you aren’t, it’s recommended that you begin by creating a code system in Snapper (see ‘OntoServer User Guide’ for details). Once created, copy the id so that you can use Postman to read it.

### How to read a Code System

1. Select CodeSystem from the collection.
2. Choose ‘Read’ from the list in the collection.
3. Select ‘Read a CodeSystem’
4. You will see that this is a ‘GET’ request, followed by a url.
5. Hover over {{terminology-server}} and in the window that appears, make sure the URL is: https://ontology.onelondon.online/authoring/fhir This is the first part of the query.
6. Next is the type of resource /CodeSystem/
7. And if you paste the id of the Code System you created in Snapper directly after the forward slash, you will end up with a URL that looks like this:

https://ontology.onelondon.online/authoring/fhir/CodeSystem/4a6c85ab-a69b-4198-846e-adb7fa2c1a23

8. Press send.


If it works, you should get the response **200 OK**

And below it (in the body) you should see the details of the code system, e.g.

```
{ 
    "resourceType": "CodeSystem", 
    "id": "4a6c85ab-a69b-4198-846e-adb7fa2c1a23",
    "meta": { 
        "versionId": "9", 
        "lastUpdated": "2024-12-16T09:07:03.050+00:00" 
    }, 
    "text": { 
        "status": "generated", 
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h2>LDS Demo cs</h2><tt>http://LDS.nhs/demo/cs</tt></div>" 
    },
    "url": "http://LDS.nhs/demo/cs",
    "version": "1", 
    "name": "LDS_Demo_cs", 
    "title": "LDS Demo cs", 
    "status": "draft", 
    "contact": [ 
        { 
            "telecom": [ 
                { 
                    "system": "email" 
                } 
            ] 
        } 
    ], 
    "caseSensitive": false, 
    "compositional": false, 
    "content": "complete", 
    "count": 12, 
    "concept": [ 
        { 
            "code": "101", 
            "display": "Crohn's disease of small intestine", 
            "definition": "Crohn's disease of small intestine" 
        }, 
        { 
            "code": "102", 
            "display": "Crohn's disease of large intestine", 
            "definition": "Crohn's disease of large intestine" 
        }, 
        { 
            "code": "103", 
            "display": "Ulcerative Colitis",
            "definition": "Ulcerative Colitis"
        }, 
        { 
            "code": "104", 
            "display": "indeterminate colitis", 
            "definition": "indeterminate colitis" 
        } 
    ] 
}

```

### How to update a Code System

**PUT** allows you to update an existing Code System.

You can add more codes to the code system by adding to the JSON that is already there.

N.B. You will also have to change the count to include the codes you have added.

And may also want to change the version number.

Once you have amended the JSON to include your additional codes, descriptions and detail, you can **PUT** the concept map into Ontoserver.

1. Under CodeSystem in the Postman collection, go to ‘Put’
2. Select "put codesystem".
3. In the PUT request section at the top of the screen **{{terminology-server}}/CodeSystem/c1e6ef04-dcd8-4a19-a479-8c6ab2f7e080** change the id to the correct one for your resource.
4. In the 'body' section, with the 'raw' button selected, paste your updated code.
5. Press the blue 'send' button.

If successful, you will receive a **200 OK** message.

You can check to see that your changes have been successful by READing the code system again.

---

## Value Sets

If you are already proficient with JSON and using APIs, then you can find the [FHIR specification for Value Sets here](https://hl7.org/fhir/R4/valueset.html)

If you aren’t, it’s recommended that you begin by creating a value set in Snapper (see ‘OntoServer User Guide’ for details).

### How to 'Search' a Value Set by name

1. Go to the ValueSet collection and choose “Search all ValueSets by name”.
2. You can search for the entire name or just a part of it. For example, if I create a value set and name it “LDS_Demo_vs”, I can search for it by entering LDS as the value in the name parameter e.g **{{terminology-server}}/valueset/?name=lds**

Press send and  you will get a response that looks like the following:
```
{ 
    "resourceType": "Bundle", 
    "id": "d1671c34-f44e-30c6-a498-432adb99ab98",
    "meta": {
        "lastUpdated": "2024-12-16T10:30:15.287+00:00", 
        "tag": [ 
            { 
                "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationValue", 
                "code": "SUBSETTED", 
                "display": "Resource encoded in summary mode"
            } 
        ] 
    }, 
    "type": "searchset", 
    "total": 1, 
    "link": [ 
        { 
            "relation": "self", 
            "url": "https://ontology.onelondon.online/authoring/fhir/ValueSet/?_summary=true&name=lds" 
        }
    ], 
    "entry": [
        { 
            "fullUrl": "https://ontology.onelondon.online/authoring/fhir/ValueSet/3406835a-3092-41e1-8ccd-f47be3cfa9a1","resource": {
                "resourceType": "ValueSet", 
                "id": "3406835a-3092-41e1-8ccd-f47be3cfa9a1", 
                "meta": {
                    "versionId": "1",
                    "lastUpdated": "2024-12-16T09:07:31.669+00:00", 
                    "url": "http://LDS.nhs/Demo/vs", 
                    "name": "LDS_Demo_vs", 
                    "title": "LDS Demo vs", 
                    "status": "draft", 
                    "publisher": "London Data Service"
                } 
            } 
        }
    ] 
}

```


If you would like to see a full list of all the valid codes within a ValueSet, then you can use the "expand" operation.

### How to expand a value set

Chose “expand explicit ValueSet” from the Operations folder in the ValueSet collection.

Copy the id number of the ValueSet (if you don’t know the id number, you can search by name following the instructions above) and paste it into the URL at the top.

Click on the blue ‘Send’ button and the response should look something like this:

```

{
  "resourceType": "ValueSet", 
  "url": "http://LDS.nhs/Demo/vs", 
  "name": "LDS_Demo_vs", 
  "title": "LDS Demo vs", 
  "status": "draft", 
  "expansion": 
    {
        "identifier": "urn:uuid:229e67f1-efd7-43f9-a876-a73184bffb86", 
        "timestamp": "2024-12-16T10:32:11+00:00", 
        "total": 4, 
        "contains": 
        [
            {
                "system": "http://LDS.nhs/demo/cs", 
                "code": "101", 
                "display": "Crohn's disease of small intestine"
            },
            {
                "system": "http://LDS.nhs/demo/cs", 
                "code": "102", 
                "display": "Crohn's disease of large intestine" 
            },
            {
                "system": "http://LDS.nhs/demo/cs", 
                "code": "103", 
                "display": "Ulcerative Colitis" 
            },
            {
                "system": "http://LDS.nhs/demo/cs", 
                "code": "104", 
                "display": "indeterminate colitis" 
            }
        ]
    } 
}


```

And you can see all of the codes and descriptions (display) listed in the “contains” section.

---

## Concept Maps

If you are already proficient with JSON and using APIs, then you can find the [FHIR specification for Concept Maps here](https://hl7.org/fhir/R4/conceptmap.html)

If you aren’t, it’s recommended that you begin by creating a concept map in Snapper (see ‘OntoServer User Guide’ for details).

### How to READ a Concept Map

1. Go to the Concept Maps collection and choose “Read a ConceptMap”.
2. You can Read the contents of a Concept Map by searching the ID number. For example, if I create a Concept Map and name it “LDS_Demo_cm”, I can search for it by entering the ID to the end of the URL.

Use the blue Send button to send the query to the server and the response will look something like this:

```
{ 
    "resourceType": "ConceptMap", 
    "id": "1342915679", 
    "meta": 
        { 
            "versionId": "4", 
            "lastUpdated": "2024-12-16T10:45:07.033+00:00" 
    }, 
    "text": { 
        "status": "generated", 
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h2>LDS Demo Map</h2><tt>http://LDS.nhs/LDS/DemoMap_cm</tt></div>" 
    }, 
    "url": "http://LDS.nhs/LDS/DemoMap_cm", 
    "name": "LDS_Demo_Map", 
    "title": "LDS Demo Map", 
    "status": "draft",  
    "group": [ 
        { 
            "source": "http://LDS.nhs/demo/cs", 
            "target": "http://snomed.info/sct", 
            "element": [ 
                { 
                    "code": "101", 
                    "display": "Crohn's disease of small intestine", 
                    "target": [ 
                        { 
                            "code": "56689002", 
                            "display": "Crohn's disease of small intestine", 
                            "equivalence": "equivalent" 
                        } 
                    ] 
                }, 
                { 
                    "code": "102", 
                    "display": "Crohn's disease of large intestine", 
                    "target": [ 
                        { 
                            "code": "7620006", 
                            "display": "Crohn's disease of large bowel", 
                            "equivalence": "equivalent" 
                        } 
                    ] 
                }, 
                { 
                    "code": "103", 
                    "display": "Ulcerative Colitis", 
                    "target": [ 
                        { 
                            "code": "64766004", 
                            "display": "Ulcerative colitis", 
                            "equivalence": "equivalent" 
                        } 
                    ] 
                }, 
                { 
                    "code": "104", 
                    "display": "indeterminate colitis", 
                    "target": [ 
                        { 
                            "code": "235746007", 
                            "display": "Indeterminate colitis", 
                            "equivalence": "equivalent" 
                        } 
                    ] 
                }, 
                { 
                    "code": "105", 
                    "display": "Sigmoidoscopy", 
                    "target": [
                        { 
                            "code": "24420007", 
                            "display": "Sigmoidoscopy", 
                            "equivalence": "equivalent" 
                        } 
                    ] 
                }, 
            ]
        }
    ]
}          

```

### How to update a concept map

**PUT** works for concept maps in the same way as it does for Code Systems, see [How to update a code system](#how-to-update-a-code-system).

The Concept Map can be updated with additional mappings or changes to the metadata.

