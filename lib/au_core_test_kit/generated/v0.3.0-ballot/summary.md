# 4 AU Core v0.3.0-ballot


## 1.1 Capability Statement

<details>

<summary>Retrieve information about supported server functionality using the FHIR capabilties interaction.</summary>

# Background
The Capability Statement Sequence tests a FHIR server's ability to formally describe features supported by the API by using the [Capability Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource. The features described in the Capability Statement must be consistent with the required capabilities of a AU Core **Responder**. The Capability Statement resource allows clients to determine which resources are supported by a FHIR Server. Not all servers are expected to implement all possible queries and data elements described in the AU Core API. The **AU Core Responder Capability Statement** requires that
    the Patient resource and **at least** one additional resource profile from the AU Core profiles.

# Testing Methodology
This test sequence accesses the server endpoint at `/metadata` using a `GET` request. It parses the Capability Statement and verifies that: * The endpoint is secured by an appropriate cryptographic protocol * The resource matches the expected FHIR version defined by the tests * The resource is a valid FHIR resource * The server claims support for JSON encoding of resources * The server claims support for the Patient resource and one other resource It collects the following information that is saved in the testing session for use by later tests: * List of resources supported * List of queries parameters supported

</details>

### Tests


#### 1.1.1 FHIR server secured by transport layer security
<details>

<summary>Show details</summary>

Systems **SHALL** use TLS version 1.2 or higher for all transmissions not taking place over a secure network connection.



</details>



#### 1.1.2 FHIR Server supports the conformance interaction
<details>

<summary>Show details</summary>

The conformance 'whole system' interaction provides a method to get the CapabilityStatement for the FHIR server. This test checks that the server responds to a `GET` request at the following endpoint: ``` GET [base]/metadata ``` This test checks the following SHALL requirement: > Applications SHALL return a resource that describes the functionality of the server end-point. [http://hl7.org/fhir/R4/http.html#capabilities](http://hl7.org/fhir/R4/http.html#capabilities) It does this by checking that the server responds with an HTTP OK 200 status code and that the body of the response contains a valid [CapabilityStatement resource](http://hl7.org/fhir/R4/capabilitystatement.html). This test does not inspect the content of the CapabilityStatement to see if it contains the required information. It only checks to see if the RESTful interaction is supported and returns a valid CapabilityStatement resource.



</details>



#### 1.1.3 Server is using FHIR R4
<details>

<summary>Show details</summary>

This test inspects the CapabilityStatement returned by the server to verify that the server is using FHIR R4.



</details>



#### 1.1.4 FHIR server capability states JSON support
<details>

<summary>Show details</summary>

FHIR provides multiple [representation formats](https://www.hl7.org/fhir/formats.html) for resources, including JSON and XML. AU Core profiles require servers to use the [JSON representation](https://www.hl7.org/fhir/json.html): [```The AU Core Server **SHALL** Support json source formats for all AU Core Responder interactions.```](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html#title) The FHIR conformance interaction require servers to describe which formats are available for clients to use. The server must explicitly state that JSON is supported. This is located in the format element of the CapabilityStatement Resource. This test checks that one of the following values are located in the format field. * json * application/json * application/fhir+json



</details>



#### 1.1.5 Capability Statement lists support for required AU Core Resource Types
<details>

<summary>Show details</summary>

The AU Core Implementation Guide states: ``` The AU Core Server SHALL: 1. Support the AU Core Patient resource. 2. Support at least one additional AU Core resources. ```



</details>



## 4.2 Patient Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Patient.</summary>

# Background

The AU Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the AU Core Patient as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.2.1 (SHALL) Server returns valid results for Patient search by _id
<details>

<summary>Show details</summary>

A server SHALL support searching by
_id on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?_id={_id}
```



</details>



#### 4.2.2 (SHOULD) Server returns valid results for Patient search by family
<details>

<summary>Show details</summary>

A server SHOULD support searching by
family on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?family={family} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?family={family}
```



</details>



#### 4.2.3 (SHALL) Server returns valid results for Patient search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?identifier={identifier}
```



</details>



#### 4.2.4 (SHOULD) Server returns valid results for Patient search by name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?name={name}
```



</details>



#### 4.2.5 (SHOULD) Server returns valid results for Patient search by birthdate + family
<details>

<summary>Show details</summary>

A server SHOULD support searching by
birthdate + family on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?birthdate family={birthdate family} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate family={birthdate family}
```



</details>



#### 4.2.6 (SHOULD) Server returns valid results for Patient search by birthdate + name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
birthdate + name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?birthdate name={birthdate name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate name={birthdate name}
```



</details>



#### 4.2.7 (SHOULD) Server returns valid results for Patient search by family + gender
<details>

<summary>Show details</summary>

A server SHOULD support searching by
family + gender on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?family gender={family gender} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?family gender={family gender}
```



</details>



#### 4.2.8 (SHOULD) Server returns valid results for Patient search by gender + name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
gender + name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Patient?gender name={gender name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender name={gender name}
```



</details>



#### 4.2.9 (SHOULD) Server returns valid results for Patient search by identifier (IHI)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Patient?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?identifier={identifier}
```



</details>



#### 4.2.10 (SHOULD) Server returns valid results for Patient search by identifier (Medicare)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Patient?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?identifier={identifier}
```



</details>



#### 4.2.11 (SHOULD) Server returns valid results for Patient search by identifier (DVA)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Patient?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?identifier={identifier}
```



</details>



#### 4.2.12 (SHALL) Server returns correct Patient resource from Patient read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Patient read interaction.



</details>



#### 4.2.13 (SHALL) Server returns Provenance resources from Patient search by _id + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by _id + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Patient?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?_id={_id}
```



</details>



#### 4.2.14 Patient resources returned during previous tests conform to the AU Core Patient
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Patient](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient



</details>



#### 4.2.15 All must support elements are provided in the Patient resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.birthDate
        * Patient.birthDate.extension:accuracyIndicator
        * Patient.birthDate.extension:birthTime
        * Patient.communication
        * Patient.communication.language
        * Patient.communication.preferred
        * Patient.extension:birthPlace
        * Patient.extension:genderIdentity
        * Patient.extension:indigenousStatus
        * Patient.extension:individualPronouns
        * Patient.extension:interpreterRequired
        * Patient.gender
        * Patient.identifier
        * Patient.name
        * Patient.name.use
        * Patient.telecom



</details>



## 4.3 Observation Body Weight Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Weight.</summary>

# Background

The AU Core Observation Body Weight sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Weight as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.3.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.3.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.3.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.3.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.3.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.3.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.3.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.3.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.3.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.3.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.3.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.3.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.3.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.3.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.3.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.3.16 Observation resources returned during previous tests conform to the AU Core Body Weight
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Weight](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight



</details>



#### 4.3.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 4.3.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.4 Observation Blood Pressure Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Blood Pressure.</summary>

# Background

The AU Core Observation Blood Pressure sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Blood Pressure as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.4.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.4.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.4.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.4.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.4.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.4.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.4.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.4.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.4.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.4.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.4.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.4.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.4.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.4.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.4.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.4.16 Observation resources returned during previous tests conform to the AU Core Blood Pressure
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Blood Pressure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure



</details>



#### 4.4.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.component
        * Observation.component.code
        * Observation.component.dataAbsentReason
        * Observation.component.value[x]
        * Observation.component:DiastolicBP
        * Observation.component:DiastolicBP.code
        * Observation.component:DiastolicBP.dataAbsentReason
        * Observation.component:DiastolicBP.value[x]
        * Observation.component:DiastolicBP.value[x].code
        * Observation.component:DiastolicBP.value[x].system
        * Observation.component:DiastolicBP.value[x].unit
        * Observation.component:DiastolicBP.value[x].value
        * Observation.component:SystolicBP
        * Observation.component:SystolicBP.code
        * Observation.component:SystolicBP.dataAbsentReason
        * Observation.component:SystolicBP.value[x]
        * Observation.component:SystolicBP.value[x].code
        * Observation.component:SystolicBP.value[x].system
        * Observation.component:SystolicBP.value[x].unit
        * Observation.component:SystolicBP.value[x].value
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject



</details>



#### 4.4.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.5 Observation Body Height Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Height.</summary>

# Background

The AU Core Observation Body Height sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Height as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.5.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.5.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.5.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.5.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.5.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.5.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.5.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.5.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.5.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.5.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.5.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.5.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.5.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.5.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.5.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.5.16 Observation resources returned during previous tests conform to the AU Core Body Height
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Height](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight



</details>



#### 4.5.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 4.5.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.6 Observation Pathology Result Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Pathology Result Observation.</summary>

# Background

The AU Core Observation Pathology Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Pathology Result Observation as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + category
* patient
* patient + category + date
* patient + code
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.6.1 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.6.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.6.3 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.6.4 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.6.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.6.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.6.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.6.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.6.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.6.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.6.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.6.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.6.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.6.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.6.15 (SHALL) Server returns Provenance resources from Observation search by patient + category + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + category + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.6.16 Observation resources returned during previous tests conform to the AU Core Pathology Result Observation
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Pathology Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path



</details>



#### 4.6.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.code
        * Observation.component
        * Observation.component.code
        * Observation.component.value[x]
        * Observation.effective[x]
        * Observation.hasMember
        * Observation.identifier
        * Observation.interpretation
        * Observation.note
        * Observation.performer
        * Observation.referenceRange
        * Observation.referenceRange.high
        * Observation.referenceRange.low
        * Observation.referenceRange.text
        * Observation.referenceRange.type
        * Observation.specimen
        * Observation.status
        * Observation.subject
        * Observation.value[x]



</details>



#### 4.6.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.hasMember
        * Observation.performer
        * Observation.specimen
        * Observation.subject



</details>



## 4.7 Observation Body Temperature Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Temperature.</summary>

# Background

The AU Core Observation Body Temperature sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Temperature as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.7.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.7.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.7.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.7.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.7.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.7.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.7.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.7.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.7.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.7.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.7.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.7.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.7.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.7.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.7.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.7.16 Observation resources returned during previous tests conform to the AU Core Body Temperature
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Temperature](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp



</details>



#### 4.7.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 4.7.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.8 Observation Heart Rate Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Heart Rate.</summary>

# Background

The AU Core Observation Heart Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Heart Rate as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.8.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.8.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.8.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.8.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.8.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.8.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.8.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.8.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.8.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.8.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.8.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.8.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.8.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.8.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.8.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.8.16 Observation resources returned during previous tests conform to the AU Core Heart Rate
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Heart Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate



</details>



#### 4.8.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 4.8.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.9 Observation Waist Circumference Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Waist Circumference.</summary>

# Background

The AU Core Observation Waist Circumference sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Waist Circumference as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.9.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.9.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.9.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.9.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.9.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.9.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.9.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.9.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.9.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.9.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.9.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.9.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.9.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.9.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.9.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.9.16 Observation resources returned during previous tests conform to the AU Core Waist Circumference
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Waist Circumference](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum



</details>



#### 4.9.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity



</details>



#### 4.9.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.10 Observation Respiration Rate Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Respiration Rate.</summary>

# Background

The AU Core Observation Respiration Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Respiration Rate as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.10.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.10.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.10.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.10.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.10.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.10.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.10.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.10.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.10.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.10.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.10.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.10.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.10.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.10.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.10.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.10.16 Observation resources returned during previous tests conform to the AU Core Respiration Rate
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Respiration Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate



</details>



#### 4.10.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 4.10.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.11 Observation Diagnostic Result Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Diagnostic Result Observation.</summary>

# Background

The AU Core Observation Diagnostic Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Diagnostic Result Observation as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.11.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.11.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.11.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.11.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.11.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.11.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.11.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.11.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.11.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.11.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.11.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.11.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.11.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.11.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.11.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.11.16 Observation resources returned during previous tests conform to the AU Core Diagnostic Result Observation
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Diagnostic Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult



</details>



#### 4.11.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.bodySite
        * Observation.category
        * Observation.code
        * Observation.component
        * Observation.component.code
        * Observation.component.value[x]
        * Observation.effective[x]
        * Observation.hasMember
        * Observation.identifier
        * Observation.interpretation
        * Observation.note
        * Observation.performer
        * Observation.referenceRange
        * Observation.referenceRange.high
        * Observation.referenceRange.low
        * Observation.referenceRange.text
        * Observation.referenceRange.type
        * Observation.status
        * Observation.subject
        * Observation.value[x]



</details>



#### 4.11.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.hasMember
        * Observation.performer
        * Observation.subject



</details>



## 4.12 Observation Smoking Status Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Smoking Status.</summary>

# Background

The AU Core Observation Smoking Status sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Smoking Status as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.12.1 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.12.2 (SHALL) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}
```



</details>



#### 4.12.3 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category={patient category}
```



</details>



#### 4.12.4 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category date={patient category date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category date={patient category date}
```



</details>



#### 4.12.5 (SHALL) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient category status={patient category status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient category status={patient category status}
```



</details>



#### 4.12.6 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code date={patient code date}
```



</details>



#### 4.12.7 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?code={code}
```



</details>



#### 4.12.8 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?status={status}
```



</details>



#### 4.12.9 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?date={date}
```



</details>



#### 4.12.10 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.12.11 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.12.12 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.12.13 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Observation?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.12.14 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 4.12.15 (SHALL) Server returns Provenance resources from Observation search by patient + code + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + code + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Observation?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient code={patient code}
```



</details>



#### 4.12.16 Observation resources returned during previous tests conform to the AU Core Smoking Status
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Smoking Status](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus



</details>



#### 4.12.17 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.code.coding.code
        * Observation.effective[x]
        * Observation.encounter
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]



</details>



#### 4.12.18 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.encounter
        * Observation.performer
        * Observation.subject



</details>



## 4.13 AllergyIntolerance Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core AllergyIntolerance.</summary>

# Background

The AU Core AllergyIntolerance sequence verifies that the system under test is
able to provide correct responses for AllergyIntolerance queries. These queries
must contain resources conforming to the AU Core AllergyIntolerance as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.13.1 (SHALL) Server returns valid results for AllergyIntolerance search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient={patient}
```



</details>



#### 4.13.2 (SHOULD) Server returns valid results for AllergyIntolerance search by patient + clinical-status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + clinical-status on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient clinical-status={patient clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient clinical-status={patient clinical-status}
```



</details>



#### 4.13.3 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the AllergyIntolerance resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.13.4 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.13.5 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.13.6 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.13.7 (SHALL) Server returns correct AllergyIntolerance resource from AllergyIntolerance read interaction
<details>

<summary>Show details</summary>

A server SHALL support the AllergyIntolerance read interaction.



</details>



#### 4.13.8 (SHALL) Server returns Provenance resources from AllergyIntolerance search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient={patient}
```



</details>



#### 4.13.9 AllergyIntolerance resources returned during previous tests conform to the AU Core AllergyIntolerance
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core AllergyIntolerance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance



</details>



#### 4.13.10 All must support elements are provided in the AllergyIntolerance resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the AllergyIntolerance resources
        found previously for the following must support elements:

        * AllergyIntolerance.asserter
        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.encounter
        * AllergyIntolerance.note
        * AllergyIntolerance.onset[x]
        * AllergyIntolerance.patient
        * AllergyIntolerance.reaction
        * AllergyIntolerance.reaction.manifestation
        * AllergyIntolerance.reaction.severity
        * AllergyIntolerance.recorder
        * AllergyIntolerance.verificationStatus



</details>



#### 4.13.11 MustSupport references within AllergyIntolerance resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * AllergyIntolerance.asserter
        * AllergyIntolerance.encounter
        * AllergyIntolerance.patient
        * AllergyIntolerance.recorder



</details>



## 4.14 Condition Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Condition.</summary>

# Background

The AU Core Condition sequence verifies that the system under test is
able to provide correct responses for Condition queries. These queries
must contain resources conforming to the AU Core Condition as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + category
* patient + clinical-status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.14.1 (SHALL) Server returns valid results for Condition search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}
```



</details>



#### 4.14.2 (SHALL) Server returns valid results for Condition search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient category={patient category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient category={patient category}
```



</details>



#### 4.14.3 (SHALL) Server returns valid results for Condition search by patient + clinical-status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient clinical-status={patient clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient clinical-status={patient clinical-status}
```



</details>



#### 4.14.4 (SHOULD) Server returns valid results for Condition search by patient + category + clinical-status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient category clinical-status={patient category clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient category clinical-status={patient category clinical-status}
```



</details>



#### 4.14.5 (SHOULD) Server returns valid results for Condition search by patient + code
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient code={patient code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient code={patient code}
```



</details>



#### 4.14.6 (SHOULD) Server returns valid results for Condition search by patient + onset-date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + onset-date on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient onset-date={patient onset-date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient onset-date={patient onset-date}
```



</details>



#### 4.14.7 (SHOULD) Server returns valid results for Condition multipleAnd search by onset-date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
onset-date on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?onset-date={onset-date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?onset-date={onset-date}
```



</details>



#### 4.14.8 (SHOULD) Server returns valid results for Condition search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Condition resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Condition?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.14.9 (SHOULD) Server returns valid results for Condition search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Condition?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.14.10 (SHOULD) Server returns valid results for Condition search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Condition?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.14.11 (SHOULD) Server returns valid results for Condition search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Condition?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.14.12 (SHALL) Server returns correct Condition resource from Condition read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Condition read interaction.



</details>



#### 4.14.13 (SHALL) Server returns Provenance resources from Condition search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Condition?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}
```



</details>



#### 4.14.14 Condition resources returned during previous tests conform to the AU Core Condition
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Condition](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition



</details>



#### 4.14.15 All must support elements are provided in the Condition resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.abatement[x]
        * Condition.asserter
        * Condition.category
        * Condition.clinicalStatus
        * Condition.code
        * Condition.encounter
        * Condition.note
        * Condition.onset[x]
        * Condition.recorder
        * Condition.severity
        * Condition.subject
        * Condition.verificationStatus



</details>



#### 4.14.16 MustSupport references within Condition resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Condition.asserter
        * Condition.encounter
        * Condition.recorder
        * Condition.subject



</details>



## 4.15 Encounter Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Encounter.</summary>

# Background

The AU Core Encounter sequence verifies that the system under test is
able to provide correct responses for Encounter queries. These queries
must contain resources conforming to the AU Core Encounter as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* date + patient

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.15.1 (SHALL) Server returns valid results for Encounter search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}
```



</details>



#### 4.15.2 (SHALL) Server returns valid results for Encounter search by date + patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
date + patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?date patient={date patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?date patient={date patient}
```



</details>



#### 4.15.3 (SHOULD) Server returns valid results for Encounter search by class + patient
<details>

<summary>Show details</summary>

A server SHOULD support searching by
class + patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?class patient={class patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?class patient={class patient}
```



</details>



#### 4.15.4 (SHOULD) Server returns valid results for Encounter search by patient + discharge-disposition
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + discharge-disposition on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient discharge-disposition={patient discharge-disposition} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient discharge-disposition={patient discharge-disposition}
```



</details>



#### 4.15.5 (SHOULD) Server returns valid results for Encounter search by patient + location
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + location on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient location={patient location} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient location={patient location}
```



</details>



#### 4.15.6 (SHOULD) Server returns valid results for Encounter search by patient + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + status on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient status={patient status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient status={patient status}
```



</details>



#### 4.15.7 (SHOULD) Server returns valid results for Encounter search by patient + type
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + type on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient type={patient type} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient type={patient type}
```



</details>



#### 4.15.8 (MAY) Server returns valid results for Encounter multipleOr search by discharge-disposition
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
discharge-disposition on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?discharge-disposition={discharge-disposition} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?discharge-disposition={discharge-disposition}
```



</details>



#### 4.15.9 (SHOULD) Server returns valid results for Encounter multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?date={date}
```



</details>



#### 4.15.10 (MAY) Server returns valid results for Encounter multipleAnd search by discharge-disposition
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
discharge-disposition on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?discharge-disposition={discharge-disposition} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?discharge-disposition={discharge-disposition}
```



</details>



#### 4.15.11 (SHOULD) Server returns valid results for Encounter search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Encounter resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.15.12 (SHOULD) Server returns valid results for Encounter search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.15.13 (SHOULD) Server returns valid results for Encounter search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.15.14 (SHOULD) Server returns valid results for Encounter search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.15.15 (SHALL) Server returns correct Encounter resource from Encounter read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Encounter read interaction.



</details>



#### 4.15.16 (SHALL) Server returns Provenance resources from Encounter search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Encounter?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}
```



</details>



#### 4.15.17 Encounter resources returned during previous tests conform to the AU Core Encounter
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Encounter](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter



</details>



#### 4.15.18 All must support elements are provided in the Encounter resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Encounter resources
        found previously for the following must support elements:

        * Encounter.class
        * Encounter.hospitalization
        * Encounter.hospitalization.dischargeDisposition
        * Encounter.identifier
        * Encounter.location
        * Encounter.location.location
        * Encounter.participant
        * Encounter.participant.individual
        * Encounter.participant.type
        * Encounter.period
        * Encounter.reasonCode
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.serviceType
        * Encounter.status
        * Encounter.subject
        * Encounter.type



</details>



#### 4.15.19 MustSupport references within Encounter resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Encounter.location.location
        * Encounter.participant.individual
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.subject



</details>



## 4.16 Immunization Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Immunization.</summary>

# Background

The AU Core Immunization sequence verifies that the system under test is
able to provide correct responses for Immunization queries. These queries
must contain resources conforming to the AU Core Immunization as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.16.1 (SHALL) Server returns valid results for Immunization search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient={patient}
```



</details>



#### 4.16.2 (SHALL) Server returns valid results for Immunization search by patient + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + status on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient status={patient status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient status={patient status}
```



</details>



#### 4.16.3 (SHOULD) Server returns valid results for Immunization search by patient + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient date={patient date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient date={patient date}
```



</details>



#### 4.16.4 (SHOULD) Server returns valid results for Immunization multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Immunization?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?date={date}
```



</details>



#### 4.16.5 (SHOULD) Server returns valid results for Immunization search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Immunization resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.16.6 (SHOULD) Server returns valid results for Immunization search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.16.7 (SHOULD) Server returns valid results for Immunization search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.16.8 (SHOULD) Server returns valid results for Immunization search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.16.9 (SHALL) Server returns correct Immunization resource from Immunization read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Immunization read interaction.



</details>



#### 4.16.10 (SHALL) Server returns Provenance resources from Immunization search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient={patient}
```



</details>



#### 4.16.11 Immunization resources returned during previous tests conform to the AU Core Immunization
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Immunization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization



</details>



#### 4.16.12 All must support elements are provided in the Immunization resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Immunization resources
        found previously for the following must support elements:

        * Immunization.encounter
        * Immunization.note
        * Immunization.occurrence[x]
        * Immunization.patient
        * Immunization.performer
        * Immunization.performer.actor
        * Immunization.performer.function
        * Immunization.protocolApplied
        * Immunization.protocolApplied.doseNumber[x]
        * Immunization.protocolApplied.series
        * Immunization.protocolApplied.targetDisease
        * Immunization.reasonCode
        * Immunization.status
        * Immunization.vaccineCode
        * Immunization.vaccineCode.coding:airVaccineCode
        * Immunization.vaccineCode.coding:amtVaccineCode



</details>



#### 4.16.13 MustSupport references within Immunization resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Immunization.encounter
        * Immunization.patient
        * Immunization.performer.actor



</details>



## 4.17 MedicationRequest Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core MedicationRequest.</summary>

# Background

The AU Core MedicationRequest sequence verifies that the system under test is
able to provide correct responses for MedicationRequest queries. These queries
must contain resources conforming to the AU Core MedicationRequest as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* _id
* identifier
* patient + intent
* patient + intent + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.17.1 (SHALL) Server returns valid results for MedicationRequest search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient={patient}
```



</details>



#### 4.17.2 (SHALL) Server returns valid results for MedicationRequest search by _id
<details>

<summary>Show details</summary>

A server SHALL support searching by
_id on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?_id={_id}
```



</details>



#### 4.17.3 (SHALL) Server returns valid results for MedicationRequest search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?identifier={identifier}
```



</details>



#### 4.17.4 (SHALL) Server returns valid results for MedicationRequest search by patient + intent
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient intent={patient intent} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient intent={patient intent}
```



</details>



#### 4.17.5 (SHALL) Server returns valid results for MedicationRequest search by patient + intent + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + intent + status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient intent status={patient intent status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient intent status={patient intent status}
```



</details>



#### 4.17.6 (SHOULD) Server returns valid results for MedicationRequest search by patient + intent + authoredon
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + intent + authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient intent authoredon={patient intent authoredon} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient intent authoredon={patient intent authoredon}
```



</details>



#### 4.17.7 (SHOULD) Server returns valid results for MedicationRequest multipleOr search by intent
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?intent={intent} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?intent={intent}
```



</details>



#### 4.17.8 (SHALL) Server returns valid results for MedicationRequest multipleOr search by status
<details>

<summary>Show details</summary>

A server SHALL support searching by multipleOr
status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?status={status}
```



</details>



#### 4.17.9 (SHOULD) Server returns valid results for MedicationRequest multipleAnd search by authoredon
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?authoredon={authoredon} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?authoredon={authoredon}
```



</details>



#### 4.17.10 (SHOULD) Server returns valid results for MedicationRequest search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the MedicationRequest resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.17.11 (SHOULD) Server returns valid results for MedicationRequest search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.17.12 (SHOULD) Server returns valid results for MedicationRequest search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.17.13 (SHOULD) Server returns valid results for MedicationRequest search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.17.14 (SHALL) Server returns correct MedicationRequest resource from MedicationRequest read interaction
<details>

<summary>Show details</summary>

A server SHALL support the MedicationRequest read interaction.



</details>



#### 4.17.15 (SHALL) Server returns Provenance resources from MedicationRequest search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient={patient}
```



</details>



#### 4.17.16 MedicationRequest resources returned during previous tests conform to the AU Core MedicationRequest
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core MedicationRequest](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest



</details>



#### 4.17.17 Medication resources returned during previous tests conform to the AU Core Medication
<details>

<summary>Show details</summary>

This test verifies resources returned from previous tests conform to
the [AU Core Medication](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication



</details>



#### 4.17.18 All must support elements are provided in the MedicationRequest resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationRequest resources
        found previously for the following must support elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.category
        * MedicationRequest.dispenseRequest
        * MedicationRequest.dispenseRequest.numberOfRepeatsAllowed
        * MedicationRequest.dispenseRequest.quantity
        * MedicationRequest.dispenseRequest.validityPeriod
        * MedicationRequest.dosageInstruction
        * MedicationRequest.encounter
        * MedicationRequest.identifier
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.medication[x]:medicationCodeableConcept.coding:amt
        * MedicationRequest.medication[x]:medicationCodeableConcept.coding:pbs
        * MedicationRequest.note
        * MedicationRequest.reasonCode
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject
        * MedicationRequest.substitution
        * MedicationRequest.substitution.allowed[x]



</details>



#### 4.17.19 MustSupport references within MedicationRequest resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * MedicationRequest.encounter
        * MedicationRequest.medication[x]
        * MedicationRequest.requester
        * MedicationRequest.subject



</details>



## 4.18 MedicationStatement Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core MedicationStatement.</summary>

# Background

The AU Core MedicationStatement sequence verifies that the system under test is
able to provide correct responses for MedicationStatement queries. These queries
must contain resources conforming to the AU Core MedicationStatement as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + status

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.18.1 (SHALL) Server returns valid results for MedicationStatement search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient={patient}
```



</details>



#### 4.18.2 (SHALL) Server returns valid results for MedicationStatement search by patient + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient status={patient status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient status={patient status}
```



</details>



#### 4.18.3 (SHOULD) Server returns valid results for MedicationStatement search by patient + effective
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + effective on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient effective={patient effective} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient effective={patient effective}
```



</details>



#### 4.18.4 (SHOULD) Server returns valid results for MedicationStatement search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the MedicationStatement resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.18.5 (SHOULD) Server returns valid results for MedicationStatement search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.18.6 (SHOULD) Server returns valid results for MedicationStatement search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.18.7 (SHOULD) Server returns valid results for MedicationStatement search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.18.8 (SHALL) Server returns correct MedicationStatement resource from MedicationStatement read interaction
<details>

<summary>Show details</summary>

A server SHALL support the MedicationStatement read interaction.



</details>



#### 4.18.9 (SHALL) Server returns Provenance resources from MedicationStatement search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient={patient}
```



</details>



#### 4.18.10 MedicationStatement resources returned during previous tests conform to the AU Core MedicationStatement
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core MedicationStatement](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement



</details>



#### 4.18.11 All must support elements are provided in the MedicationStatement resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationStatement resources
        found previously for the following must support elements:

        * MedicationStatement.basedOn
        * MedicationStatement.category
        * MedicationStatement.context
        * MedicationStatement.dateAsserted
        * MedicationStatement.dosage
        * MedicationStatement.effective[x]
        * MedicationStatement.informationSource
        * MedicationStatement.medication[x]
        * MedicationStatement.medication[x]:medicationCodeableConcept.coding:amt
        * MedicationStatement.medication[x]:medicationCodeableConcept.coding:pbs
        * MedicationStatement.note
        * MedicationStatement.reasonCode
        * MedicationStatement.status
        * MedicationStatement.statusReason
        * MedicationStatement.subject



</details>



#### 4.18.12 MustSupport references within MedicationStatement resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * MedicationStatement.basedOn
        * MedicationStatement.context
        * MedicationStatement.informationSource
        * MedicationStatement.medication[x]
        * MedicationStatement.subject



</details>



## 4.19 Procedure Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Procedure.</summary>

# Background

The AU Core Procedure sequence verifies that the system under test is
able to provide correct responses for Procedure queries. These queries
must contain resources conforming to the AU Core Procedure as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 4.19.1 (SHALL) Server returns valid results for Procedure search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient={patient}
```



</details>



#### 4.19.2 (SHALL) Server returns valid results for Procedure search by patient + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient date={patient date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient date={patient date}
```



</details>



#### 4.19.3 (SHOULD) Server returns valid results for Procedure search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient code date={patient code date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient code date={patient code date}
```



</details>



#### 4.19.4 (SHOULD) Server returns valid results for Procedure search by patient + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + status on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient status={patient status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient status={patient status}
```



</details>



#### 4.19.5 (SHOULD) Server returns valid results for Procedure multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?code={code}
```



</details>



#### 4.19.6 (SHOULD) Server returns valid results for Procedure multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?status={status}
```



</details>



#### 4.19.7 (SHOULD) Server returns valid results for Procedure search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Procedure resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.19.8 (SHOULD) Server returns valid results for Procedure search by patient (IHI) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (IHI



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.19.9 (SHOULD) Server returns valid results for Procedure search by patient (Medicare) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.19.10 (SHOULD) Server returns valid results for Procedure search by patient (DVA) (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier (DVA



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient:Patient.identifier={patient:Patient.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient:Patient.identifier={patient:Patient.identifier}
```



</details>



#### 4.19.11 (SHALL) Server returns correct Procedure resource from Procedure read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Procedure read interaction.



</details>



#### 4.19.12 (SHALL) Server returns Provenance resources from Procedure search by patient + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Procedure?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient={patient}
```



</details>



#### 4.19.13 Procedure resources returned during previous tests conform to the AU Core Procedure
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Procedure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure



</details>



#### 4.19.14 All must support elements are provided in the Procedure resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.asserter
        * Procedure.bodySite
        * Procedure.category
        * Procedure.code
        * Procedure.encounter
        * Procedure.note
        * Procedure.performed[x]
        * Procedure.reasonCode
        * Procedure.reasonReference
        * Procedure.recorder
        * Procedure.status
        * Procedure.statusReason
        * Procedure.subject



</details>



#### 4.19.15 MustSupport references within Procedure resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Procedure.asserter
        * Procedure.encounter
        * Procedure.reasonReference
        * Procedure.recorder
        * Procedure.subject



</details>



## 4.20 Location Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Location.</summary>

# Background

The AU Core Location sequence verifies that the system under test is
able to provide correct responses for Location queries. These queries
must contain resources conforming to the AU Core Location as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
* name

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 4.20.1 (SHALL) Server returns correct Location resource from Location read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Location read interaction.



</details>



#### 4.20.2 (SHALL) Server returns valid results for Location search by address
<details>

<summary>Show details</summary>

A server SHALL support searching by
address on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Location?address={address} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?address={address}
```



</details>



#### 4.20.3 (SHALL) Server returns valid results for Location search by name
<details>

<summary>Show details</summary>

A server SHALL support searching by
name on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Location?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?name={name}
```



</details>



#### 4.20.4 (SHOULD) Server returns valid results for Location search by address-city
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-city on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Location?address-city={address-city} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?address-city={address-city}
```



</details>



#### 4.20.5 (SHOULD) Server returns valid results for Location search by address-state
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-state on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Location?address-state={address-state} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?address-state={address-state}
```



</details>



#### 4.20.6 (SHOULD) Server returns valid results for Location search by address-postalcode
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-postalcode on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Location?address-postalcode={address-postalcode} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?address-postalcode={address-postalcode}
```



</details>



#### 4.20.7 (SHALL) Server returns Provenance resources from Location search by address + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by address + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Location?address={address} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Location?address={address}
```



</details>



#### 4.20.8 Location resources returned during previous tests conform to the AU Core Location
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Location](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location



</details>



#### 4.20.9 All must support elements are provided in the Location resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Location resources
        found previously for the following must support elements:

        * Location.address
        * Location.description
        * Location.identifier
        * Location.managingOrganization
        * Location.mode
        * Location.name
        * Location.physicalType
        * Location.type



</details>



#### 4.20.10 MustSupport references within Location resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Location.managingOrganization



</details>



## 4.21 Organization Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Organization.</summary>

# Background

The AU Core Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the AU Core Organization as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
* identifier
* name

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 4.21.1 (SHALL) Server returns correct Organization resource from Organization read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Organization read interaction.



</details>



#### 4.21.2 (SHOULD) Server returns valid results for Organization search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Organization?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?_id={_id}
```



</details>



#### 4.21.3 (SHALL) Server returns valid results for Organization search by address
<details>

<summary>Show details</summary>

A server SHALL support searching by
address on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Organization?address={address} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?address={address}
```



</details>



#### 4.21.4 (SHALL) Server returns valid results for Organization search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Organization?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?identifier={identifier}
```



</details>



#### 4.21.5 (SHALL) Server returns valid results for Organization search by name
<details>

<summary>Show details</summary>

A server SHALL support searching by
name on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Organization?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?name={name}
```



</details>



#### 4.21.6 (SHOULD) Server returns valid results for Organization search by identifier (HPI-O)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (HPI-O



##### Requests

**HTTP GET**

```bash
GET /Organization?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?identifier={identifier}
```



</details>



#### 4.21.7 (SHOULD) Server returns valid results for Organization search by identifier (ABN)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (ABN



##### Requests

**HTTP GET**

```bash
GET /Organization?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?identifier={identifier}
```



</details>



#### 4.21.8 (SHALL) Server returns Provenance resources from Organization search by _id + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by _id + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /Organization?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Organization?_id={_id}
```



</details>



#### 4.21.9 Organization resources returned during previous tests conform to the AU Core Organization
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Organization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization



</details>



#### 4.21.10 All must support elements are provided in the Organization resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Organization resources
        found previously for the following must support elements:

        * Organization.address
        * Organization.alias
        * Organization.identifier
        * Organization.name
        * Organization.telecom
        * Organization.type



</details>



## 4.22 Practitioner Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Practitioner.</summary>

# Background

The AU Core Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the AU Core Practitioner as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 4.22.1 (SHALL) Server returns correct Practitioner resource from Practitioner read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Practitioner read interaction.



</details>



#### 4.22.2 (SHALL) Server returns valid results for Practitioner search by _id
<details>

<summary>Show details</summary>

A server SHALL support searching by
_id on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Practitioner?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Practitioner?_id={_id}
```



</details>



#### 4.22.3 (SHALL) Server returns valid results for Practitioner search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Practitioner?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Practitioner?identifier={identifier}
```



</details>



#### 4.22.4 (SHOULD) Server returns valid results for Practitioner search by name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
name on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /Practitioner?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Practitioner?name={name}
```



</details>



#### 4.22.5 (SHOULD) Server returns valid results for Practitioner search by identifier (HPI-I)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (HPI-I



##### Requests

**HTTP GET**

```bash
GET /Practitioner?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Practitioner?identifier={identifier}
```



</details>



#### 4.22.6 Practitioner resources returned during previous tests conform to the AU Core Practitioner
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Practitioner](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner



</details>



#### 4.22.7 All must support elements are provided in the Practitioner resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

        * Practitioner.address
        * Practitioner.communication
        * Practitioner.identifier
        * Practitioner.name
        * Practitioner.qualification
        * Practitioner.qualification.code
        * Practitioner.qualification.identifier
        * Practitioner.qualification.issuer
        * Practitioner.qualification.period
        * Practitioner.telecom



</details>



#### 4.22.8 MustSupport references within Practitioner resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Practitioner.qualification.issuer



</details>



## 4.23 PractitionerRole Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core PractitionerRole.</summary>

# Background

The AU Core PractitionerRole sequence verifies that the system under test is
able to provide correct responses for PractitionerRole queries. These queries
must contain resources conforming to the AU Core PractitionerRole as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier
* practitioner

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 4.23.1 (SHALL) Server returns correct PractitionerRole resource from PractitionerRole read interaction
<details>

<summary>Show details</summary>

A server SHALL support the PractitionerRole read interaction.



</details>



#### 4.23.2 (SHALL) Server returns valid results for PractitionerRole search by _id
<details>

<summary>Show details</summary>

A server SHALL support searching by
_id on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0-ballot.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?_id={_id}
```



</details>



#### 4.23.3 (SHALL) Server returns valid results for PractitionerRole search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?identifier={identifier}
```



</details>



#### 4.23.4 (SHALL) Server returns valid results for PractitionerRole search by practitioner
<details>

<summary>Show details</summary>

A server SHALL support searching by
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `practitioner=[id]` as well as `practitioner=Practitioner/[id]`. The two
different forms are expected to return the same number of results. AU
Core requires that both forms are supported by AU Core responders.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?practitioner={practitioner} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?practitioner={practitioner}
```



</details>



#### 4.23.5 (SHOULD) Server returns valid results for PractitionerRole search by specialty
<details>

<summary>Show details</summary>

A server SHOULD support searching by
specialty on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?specialty={specialty} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?specialty={specialty}
```



</details>



#### 4.23.6 (MAY) Server returns valid results for PractitionerRole multipleOr search by practitioner
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?practitioner={practitioner} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?practitioner={practitioner}
```



</details>



#### 4.23.7 (MAY) Server returns valid results for PractitionerRole multipleAnd search by practitioner
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?practitioner={practitioner} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?practitioner={practitioner}
```



</details>



#### 4.23.8 (SHOULD) Server returns valid results for PractitionerRole search by practitioner (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
practitioner:Practitioner.identifier on the PractitionerRole resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?practitioner:Practitioner.identifier={practitioner:Practitioner.identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?practitioner:Practitioner.identifier={practitioner:Practitioner.identifier}
```



</details>



#### 4.23.9 (SHOULD) Server returns valid results for PractitionerRole search by identifier (Medicare)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
identifier (Medicare



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?identifier={identifier}
```



</details>



#### 4.23.10 (SHALL) Server returns Provenance resources from PractitionerRole search by _id + revInclude:Provenance:target
<details>

<summary>Show details</summary>

A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by _id + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?_id={_id}
```



</details>



#### 4.23.11 PractitionerRole resources returned during previous tests conform to the AU Core PractitionerRole
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core PractitionerRole](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole



</details>



#### 4.23.12 All must support elements are provided in the PractitionerRole resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the PractitionerRole resources
        found previously for the following must support elements:

        * PractitionerRole.code
        * PractitionerRole.identifier
        * PractitionerRole.location
        * PractitionerRole.organization
        * PractitionerRole.practitioner
        * PractitionerRole.specialty
        * PractitionerRole.telecom



</details>



#### 4.23.13 MustSupport references within PractitionerRole resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * PractitionerRole.location
        * PractitionerRole.organization
        * PractitionerRole.practitioner



</details>



## 4.24 Provenance Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Provenance.</summary>

# Background

The AU Core Provenance sequence verifies that the system under test is
able to provide correct responses for Provenance queries. These queries
must contain resources conforming to the AU Core Provenance as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Provenance resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Provenance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance

</details>

### Tests


#### 4.24.1 (SHALL) Server returns correct Provenance resource from Provenance read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Provenance read interaction.



</details>



#### 4.24.2 Provenance resources returned during previous tests conform to the AU Core Provenance
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Provenance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance



</details>



#### 4.24.3 All must support elements are provided in the Provenance resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Provenance resources
        found previously for the following must support elements:

        * Provenance.activity
        * Provenance.agent
        * Provenance.agent.onBehalfOf
        * Provenance.agent.who
        * Provenance.occurred[x]
        * Provenance.recorded
        * Provenance.target



</details>



#### 4.24.4 MustSupport references within Provenance resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Provenance.agent.onBehalfOf
        * Provenance.agent.who
        * Provenance.target



</details>


