# 2 AU Core v1.1.0-preview


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



## 2.2 Patient Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Patient.</summary>

# Background

The AU Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the AU Core Patient as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.2.1 (SHALL) Server returns valid results for Patient search by _id
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.2 (MAY) Server returns valid results for Patient search by birthdate
<details>

<summary>Show details</summary>

A server MAY support searching by
birthdate on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?birthdate={birthdate} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate={birthdate}
```



</details>



#### 2.2.3 (SHOULD) Server returns valid results for Patient search by family
<details>

<summary>Show details</summary>

A server SHOULD support searching by
family on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.4 (MAY) Server returns valid results for Patient search by gender
<details>

<summary>Show details</summary>

A server MAY support searching by
gender on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?gender={gender} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender={gender}
```



</details>



#### 2.2.5 (MAY) Server returns valid results for Patient search by indigenous-status
<details>

<summary>Show details</summary>

A server MAY support searching by
indigenous-status on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?indigenous-status={indigenous-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?indigenous-status={indigenous-status}
```



</details>



#### 2.2.6 (SHALL) Server returns valid results for Patient search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.7 (SHOULD) Server returns valid results for Patient search by name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.8 (MAY) Server returns valid results for Patient search by gender-identity
<details>

<summary>Show details</summary>

A server MAY support searching by
gender-identity on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?gender-identity={gender-identity} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender-identity={gender-identity}
```



</details>



#### 2.2.9 (SHOULD) Server returns valid results for Patient search by birthdate + family
<details>

<summary>Show details</summary>

A server SHOULD support searching by
birthdate + family on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.10 (SHOULD) Server returns valid results for Patient search by birthdate + name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
birthdate + name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.11 (SHOULD) Server returns valid results for Patient search by family + gender
<details>

<summary>Show details</summary>

A server SHOULD support searching by
family + gender on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.12 (SHOULD) Server returns valid results for Patient search by gender + name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
gender + name on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.2.13 (MAY) Server returns valid results for Patient multipleOr search by indigenous-status
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
indigenous-status on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?indigenous-status={indigenous-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?indigenous-status={indigenous-status}
```



</details>



#### 2.2.14 (MAY) Server returns valid results for Patient multipleOr search by gender-identity
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
gender-identity on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?gender-identity={gender-identity} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender-identity={gender-identity}
```



</details>



#### 2.2.15 (MAY) Server returns valid results for Patient multipleAnd search by birthdate
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
birthdate on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?birthdate={birthdate} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate={birthdate}
```



</details>



#### 2.2.16 (MAY) Server returns valid results for Patient multipleAnd search by indigenous-status
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
indigenous-status on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?indigenous-status={indigenous-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?indigenous-status={indigenous-status}
```



</details>



#### 2.2.17 (MAY) Server returns valid results for Patient multipleAnd search by gender-identity
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
gender-identity on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Patient?gender-identity={gender-identity} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender-identity={gender-identity}
```



</details>



#### 2.2.18 (SHOULD) Server returns valid results for Patient search by identifier (IHI)
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



#### 2.2.19 (SHOULD) Server returns valid results for Patient search by identifier (Medicare)
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



#### 2.2.20 (SHOULD) Server returns valid results for Patient search by identifier (DVA)
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



#### 2.2.21 (SHALL) Server returns correct Patient resource from Patient read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Patient read interaction.



</details>



#### 2.2.22 Patient resources returned during previous tests conform to the AU Core Patient
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Patient](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient



</details>



#### 2.2.23 All must support elements are provided in the Patient resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.birthDate
        * Patient.communication
        * Patient.communication.language
        * Patient.communication.preferred
        * Patient.extension:genderIdentity
        * Patient.extension:indigenousStatus
        * Patient.extension:individualPronouns
        * Patient.gender
        * Patient.identifier
        * Patient.name
        * Patient.name.family
        * Patient.name.given
        * Patient.name.text
        * Patient.name.use
        * Patient.telecom



</details>



## 2.3 Observation Body Weight Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Weight.</summary>

# Background

The AU Core Observation Body Weight sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Weight as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.3.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.3.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.3.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.3.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.3.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.3.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.3.19 Observation resources returned during previous tests conform to the AU Core Body Weight
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Weight](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight



</details>



#### 2.3.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 2.3.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.4 Observation Blood Pressure Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Blood Pressure.</summary>

# Background

The AU Core Observation Blood Pressure sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Blood Pressure as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.4.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.4.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.4.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.4.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.4.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.4.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.4.19 Observation resources returned during previous tests conform to the AU Core Blood Pressure
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Blood Pressure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure



</details>



#### 2.4.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject



</details>



#### 2.4.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.5 Observation Body Height Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Height.</summary>

# Background

The AU Core Observation Body Height sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Height as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.5.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.5.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.5.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.5.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.5.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.5.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.5.19 Observation resources returned during previous tests conform to the AU Core Body Height
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Height](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight



</details>



#### 2.5.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 2.5.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.6 Observation Pathology Result Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Pathology Result Observation.</summary>

# Background

The AU Core Observation Pathology Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Pathology Result Observation as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + category
* patient + category + date
* patient + code

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.6.1 (SHALL) Server returns valid results for Observation search by patient + category
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.6.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.7 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.8 (SHALL) Server returns valid results for Observation search by patient + code
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.6.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.6.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.6.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.6.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.6.19 Observation resources returned during previous tests conform to the AU Core Pathology Result Observation
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Pathology Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path



</details>



#### 2.6.20 All must support elements are provided in the Observation resources returned
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
        * Observation.interpretation
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



#### 2.6.21 MustSupport references within Observation resources are valid
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



## 2.7 Observation Body Temperature Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Body Temperature.</summary>

# Background

The AU Core Observation Body Temperature sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Temperature as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.7.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.7.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.7.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.7.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.7.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.7.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.7.19 Observation resources returned during previous tests conform to the AU Core Body Temperature
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Body Temperature](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp



</details>



#### 2.7.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 2.7.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.8 Observation Heart Rate Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Heart Rate.</summary>

# Background

The AU Core Observation Heart Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Heart Rate as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.8.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.8.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.8.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.8.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.8.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.8.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.8.19 Observation resources returned during previous tests conform to the AU Core Heart Rate
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Heart Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate



</details>



#### 2.8.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 2.8.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.9 Observation Waist Circumference Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Waist Circumference.</summary>

# Background

The AU Core Observation Waist Circumference sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Waist Circumference as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.9.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.9.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.9.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.9.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.9.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.9.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.9.19 Observation resources returned during previous tests conform to the AU Core Waist Circumference
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Waist Circumference](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum



</details>



#### 2.9.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity



</details>



#### 2.9.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.10 Observation Respiration Rate Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Respiration Rate.</summary>

# Background

The AU Core Observation Respiration Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Respiration Rate as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.10.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.10.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.10.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.10.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.10.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.10.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.10.19 Observation resources returned during previous tests conform to the AU Core Respiration Rate
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Respiration Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate



</details>



#### 2.10.20 All must support elements are provided in the Observation resources returned
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
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value



</details>



#### 2.10.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.11 Observation Diagnostic Result Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Diagnostic Result Observation.</summary>

# Background

The AU Core Observation Diagnostic Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Diagnostic Result Observation as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.11.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.11.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.11.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.11.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.11.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.11.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.11.19 Observation resources returned during previous tests conform to the AU Core Diagnostic Result Observation
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Diagnostic Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult



</details>



#### 2.11.20 All must support elements are provided in the Observation resources returned
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
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]



</details>



#### 2.11.21 MustSupport references within Observation resources are valid
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



## 2.12 Observation Smoking Status Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Smoking Status.</summary>

# Background

The AU Core Observation Smoking Status sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Smoking Status as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient + category
* patient + category + date

### Search Parameters
The first search uses the selected patient(s

</details>

### Tests


#### 2.12.1 (SHALL) Server returns valid results for Observation search by patient + code
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.2 (MAY) Server returns valid results for Observation search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Observation?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?category={category}
```



</details>



#### 2.12.3 (MAY) Server returns valid results for Observation search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.4 (MAY) Server returns valid results for Observation search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.5 (MAY) Server returns valid results for Observation search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.6 (MAY) Server returns valid results for Observation search by patient
<details>

<summary>Show details</summary>

A server MAY support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.7 (SHALL) Server returns valid results for Observation search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.8 (SHALL) Server returns valid results for Observation search by patient + category + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.9 (SHOULD) Server returns valid results for Observation search by patient + category + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.10 (SHOULD) Server returns valid results for Observation search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.11 (SHOULD) Server returns valid results for Observation multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.12 (SHOULD) Server returns valid results for Observation multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.13 (SHOULD) Server returns valid results for Observation multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.14 (SHOULD) Server returns valid results for Observation search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Observation resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.12.15 (SHOULD) Server returns valid results for Observation search by patient (IHI) (chained parameters)
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



#### 2.12.16 (SHOULD) Server returns valid results for Observation search by patient (Medicare) (chained parameters)
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



#### 2.12.17 (SHOULD) Server returns valid results for Observation search by patient (DVA) (chained parameters)
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



#### 2.12.18 (SHALL) Server returns correct Observation resource from Observation read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Observation read interaction.



</details>



#### 2.12.19 Observation resources returned during previous tests conform to the AU Core Smoking Status
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Smoking Status](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus



</details>



#### 2.12.20 All must support elements are provided in the Observation resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.code.coding.code
        * Observation.effective[x]
        * Observation.status
        * Observation.subject
        * Observation.value[x]



</details>



#### 2.12.21 MustSupport references within Observation resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.subject



</details>



## 2.13 AllergyIntolerance Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core AllergyIntolerance.</summary>

# Background

The AU Core AllergyIntolerance sequence verifies that the system under test is
able to provide correct responses for AllergyIntolerance queries. These queries
must contain resources conforming to the AU Core AllergyIntolerance as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.13.1 (SHALL) Server returns valid results for AllergyIntolerance search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.13.2 (MAY) Server returns valid results for AllergyIntolerance search by clinical-status
<details>

<summary>Show details</summary>

A server MAY support searching by
clinical-status on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /AllergyIntolerance?clinical-status={clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?clinical-status={clinical-status}
```



</details>



#### 2.13.3 (SHOULD) Server returns valid results for AllergyIntolerance search by patient + clinical-status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + clinical-status on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.13.4 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the AllergyIntolerance resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.13.5 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (IHI) (chained parameters)
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



#### 2.13.6 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (Medicare) (chained parameters)
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



#### 2.13.7 (SHOULD) Server returns valid results for AllergyIntolerance search by patient (DVA) (chained parameters)
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



#### 2.13.8 (SHALL) Server returns correct AllergyIntolerance resource from AllergyIntolerance read interaction
<details>

<summary>Show details</summary>

A server SHALL support the AllergyIntolerance read interaction.



</details>



#### 2.13.9 AllergyIntolerance resources returned during previous tests conform to the AU Core AllergyIntolerance
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core AllergyIntolerance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance



</details>



#### 2.13.10 All must support elements are provided in the AllergyIntolerance resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the AllergyIntolerance resources
        found previously for the following must support elements:

        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.onset[x]
        * AllergyIntolerance.patient
        * AllergyIntolerance.reaction
        * AllergyIntolerance.reaction.manifestation
        * AllergyIntolerance.reaction.severity
        * AllergyIntolerance.verificationStatus



</details>



#### 2.13.11 MustSupport references within AllergyIntolerance resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * AllergyIntolerance.patient



</details>



## 2.14 Condition Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Condition.</summary>

# Background

The AU Core Condition sequence verifies that the system under test is
able to provide correct responses for Condition queries. These queries
must contain resources conforming to the AU Core Condition as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.14.1 (SHALL) Server returns valid results for Condition search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.2 (MAY) Server returns valid results for Condition search by category
<details>

<summary>Show details</summary>

A server MAY support searching by
category on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Condition?category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?category={category}
```



</details>



#### 2.14.3 (MAY) Server returns valid results for Condition search by clinical-status
<details>

<summary>Show details</summary>

A server MAY support searching by
clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Condition?clinical-status={clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?clinical-status={clinical-status}
```



</details>



#### 2.14.4 (MAY) Server returns valid results for Condition search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Condition?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?code={code}
```



</details>



#### 2.14.5 (MAY) Server returns valid results for Condition search by onset-date
<details>

<summary>Show details</summary>

A server MAY support searching by
onset-date on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.6 (SHALL) Server returns valid results for Condition search by patient + category
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + category on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.7 (SHALL) Server returns valid results for Condition search by patient + clinical-status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.8 (SHOULD) Server returns valid results for Condition search by patient + category + clinical-status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + category + clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.9 (SHOULD) Server returns valid results for Condition search by patient + code
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.10 (SHOULD) Server returns valid results for Condition search by patient + onset-date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + onset-date on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.11 (MAY) Server returns valid results for Condition multipleOr search by code
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
code on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Condition?code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?code={code}
```



</details>



#### 2.14.12 (SHOULD) Server returns valid results for Condition multipleAnd search by onset-date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
onset-date on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.13 (SHOULD) Server returns valid results for Condition search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Condition resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.14.14 (SHOULD) Server returns valid results for Condition search by patient (IHI) (chained parameters)
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



#### 2.14.15 (SHOULD) Server returns valid results for Condition search by patient (Medicare) (chained parameters)
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



#### 2.14.16 (SHOULD) Server returns valid results for Condition search by patient (DVA) (chained parameters)
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



#### 2.14.17 (SHALL) Server returns correct Condition resource from Condition read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Condition read interaction.



</details>



#### 2.14.18 Condition resources returned during previous tests conform to the AU Core Condition
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Condition](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition



</details>



#### 2.14.19 All must support elements are provided in the Condition resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.abatement[x]
        * Condition.category
        * Condition.clinicalStatus
        * Condition.code
        * Condition.note
        * Condition.onset[x]
        * Condition.severity
        * Condition.subject
        * Condition.verificationStatus



</details>



#### 2.14.20 MustSupport references within Condition resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Condition.subject



</details>



## 2.15 Encounter Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Encounter.</summary>

# Background

The AU Core Encounter sequence verifies that the system under test is
able to provide correct responses for Encounter queries. These queries
must contain resources conforming to the AU Core Encounter as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.15.1 (SHALL) Server returns valid results for Encounter search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.2 (MAY) Server returns valid results for Encounter search by class
<details>

<summary>Show details</summary>

A server MAY support searching by
class on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Encounter?class={class} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?class={class}
```



</details>



#### 2.15.3 (MAY) Server returns valid results for Encounter search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.4 (MAY) Server returns valid results for Encounter search by location
<details>

<summary>Show details</summary>

A server MAY support searching by
location on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Encounter?location={location} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?location={location}
```



</details>



#### 2.15.5 (MAY) Server returns valid results for Encounter search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Encounter?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?status={status}
```



</details>



#### 2.15.6 (SHALL) Server returns valid results for Encounter search by date + patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
date + patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.7 (SHOULD) Server returns valid results for Encounter search by class + patient
<details>

<summary>Show details</summary>

A server SHOULD support searching by
class + patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.8 (SHOULD) Server returns valid results for Encounter search by patient + location
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + location on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.9 (SHOULD) Server returns valid results for Encounter search by patient + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + status on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.10 (MAY) Server returns valid results for Encounter multipleOr search by status
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
status on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Encounter?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?status={status}
```



</details>



#### 2.15.11 (SHOULD) Server returns valid results for Encounter multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.12 (SHOULD) Server returns valid results for Encounter search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Encounter resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.15.13 (SHOULD) Server returns valid results for Encounter search by patient (IHI) (chained parameters)
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



#### 2.15.14 (SHOULD) Server returns valid results for Encounter search by patient (Medicare) (chained parameters)
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



#### 2.15.15 (SHOULD) Server returns valid results for Encounter search by patient (DVA) (chained parameters)
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



#### 2.15.16 (SHALL) Server returns correct Encounter resource from Encounter read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Encounter read interaction.



</details>



#### 2.15.17 Encounter resources returned during previous tests conform to the AU Core Encounter
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Encounter](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter



</details>



#### 2.15.18 All must support elements are provided in the Encounter resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Encounter resources
        found previously for the following must support elements:

        * Encounter.class
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



</details>



#### 2.15.19 MustSupport references within Encounter resources are valid
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



## 2.16 Immunization Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Immunization.</summary>

# Background

The AU Core Immunization sequence verifies that the system under test is
able to provide correct responses for Immunization queries. These queries
must contain resources conforming to the AU Core Immunization as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.16.1 (SHALL) Server returns valid results for Immunization search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.2 (MAY) Server returns valid results for Immunization search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.3 (MAY) Server returns valid results for Immunization search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Immunization?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?status={status}
```



</details>



#### 2.16.4 (MAY) Server returns valid results for Immunization search by vaccine-code
<details>

<summary>Show details</summary>

A server MAY support searching by
vaccine-code on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Immunization?vaccine-code={vaccine-code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?vaccine-code={vaccine-code}
```



</details>



#### 2.16.5 (SHALL) Server returns valid results for Immunization search by patient + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + status on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.6 (SHOULD) Server returns valid results for Immunization search by patient + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.7 (MAY) Server returns valid results for Immunization search by patient + vaccine-code
<details>

<summary>Show details</summary>

A server MAY support searching by
patient + vaccine-code on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Immunization?patient vaccine-code={patient vaccine-code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient vaccine-code={patient vaccine-code}
```



</details>



#### 2.16.8 (SHOULD) Server returns valid results for Immunization multipleOr search by vaccine-code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
vaccine-code on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Immunization?vaccine-code={vaccine-code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?vaccine-code={vaccine-code}
```



</details>



#### 2.16.9 (SHOULD) Server returns valid results for Immunization multipleAnd search by date
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.10 (SHOULD) Server returns valid results for Immunization search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Immunization resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.16.11 (SHOULD) Server returns valid results for Immunization search by patient (IHI) (chained parameters)
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



#### 2.16.12 (SHOULD) Server returns valid results for Immunization search by patient (Medicare) (chained parameters)
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



#### 2.16.13 (SHOULD) Server returns valid results for Immunization search by patient (DVA) (chained parameters)
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



#### 2.16.14 (SHALL) Server returns correct Immunization resource from Immunization read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Immunization read interaction.



</details>



#### 2.16.15 Immunization resources returned during previous tests conform to the AU Core Immunization
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Immunization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization



</details>



#### 2.16.16 All must support elements are provided in the Immunization resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Immunization resources
        found previously for the following must support elements:

        * Immunization.note
        * Immunization.occurrence[x]
        * Immunization.patient
        * Immunization.primarySource
        * Immunization.status
        * Immunization.vaccineCode



</details>



#### 2.16.17 MustSupport references within Immunization resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Immunization.patient



</details>



## 2.17 MedicationRequest Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core MedicationRequest.</summary>

# Background

The AU Core MedicationRequest sequence verifies that the system under test is
able to provide correct responses for MedicationRequest queries. These queries
must contain resources conforming to the AU Core MedicationRequest as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.17.1 (SHALL) Server returns valid results for MedicationRequest search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.2 (SHOULD) Server returns valid results for MedicationRequest search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.3 (MAY) Server returns valid results for MedicationRequest search by authoredon
<details>

<summary>Show details</summary>

A server MAY support searching by
authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.4 (MAY) Server returns valid results for MedicationRequest search by intent
<details>

<summary>Show details</summary>

A server MAY support searching by
intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.5 (MAY) Server returns valid results for MedicationRequest search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.6 (SHOULD) Server returns valid results for MedicationRequest search by patient + intent
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.7 (SHOULD) Server returns valid results for MedicationRequest search by patient + intent + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + intent + status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.8 (SHALL) Server returns valid results for MedicationRequest search by patient + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /MedicationRequest?patient status={patient status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient status={patient status}
```



</details>



#### 2.17.9 (SHOULD) Server returns valid results for MedicationRequest search by patient + intent + authoredon
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + intent + authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.10 (SHOULD) Server returns valid results for MedicationRequest multipleOr search by intent
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.11 (SHALL) Server returns valid results for MedicationRequest multipleOr search by status
<details>

<summary>Show details</summary>

A server SHALL support searching by multipleOr
status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.12 (SHOULD) Server returns valid results for MedicationRequest multipleAnd search by authoredon
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleAnd
authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.13 (SHOULD) Server returns valid results for MedicationRequest search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the MedicationRequest resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.17.14 (SHOULD) Server returns valid results for MedicationRequest search by patient (IHI) (chained parameters)
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



#### 2.17.15 (SHOULD) Server returns valid results for MedicationRequest search by patient (Medicare) (chained parameters)
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



#### 2.17.16 (SHOULD) Server returns valid results for MedicationRequest search by patient (DVA) (chained parameters)
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



#### 2.17.17 (SHALL) Server returns correct MedicationRequest resource from MedicationRequest read interaction
<details>

<summary>Show details</summary>

A server SHALL support the MedicationRequest read interaction.



</details>



#### 2.17.18 Server returns Medication resources from MedicationRequest search by patient and MedicationRequest:medication
<details>

<summary>Show details</summary>

This test will perform a search by patient and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.



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



#### 2.17.19 Server returns Medication resources from MedicationRequest search by _id and MedicationRequest:medication
<details>

<summary>Show details</summary>

This test will perform a search by _id and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.



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



#### 2.17.20 Server returns Medication resources from MedicationRequest search by patient, intent and MedicationRequest:medication
<details>

<summary>Show details</summary>

This test will perform a search by patient, intent and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.



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



#### 2.17.21 Server returns Medication resources from MedicationRequest search by patient, intent, status and MedicationRequest:medication
<details>

<summary>Show details</summary>

This test will perform a search by patient, intent, status and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.



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



#### 2.17.22 Server returns Medication resources from MedicationRequest search by patient, intent, authoredon and MedicationRequest:medication
<details>

<summary>Show details</summary>

This test will perform a search by patient, intent, authoredon and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.



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



#### 2.17.23 MedicationRequest resources returned during previous tests conform to the AU Core MedicationRequest
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core MedicationRequest](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest



</details>



#### 2.17.24 Medication resources returned during previous tests conform to the AU Core Medication
<details>

<summary>Show details</summary>

This test verifies resources returned from previous tests conform to
the [AU Core Medication](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication



</details>



#### 2.17.25 All must support elements are provided in the MedicationRequest resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationRequest resources
        found previously for the following must support elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.dosageInstruction
        * MedicationRequest.encounter
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.reasonCode
        * MedicationRequest.reasonReference
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject



</details>



#### 2.17.26 MustSupport references within MedicationRequest resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * MedicationRequest.encounter
        * MedicationRequest.medication[x]
        * MedicationRequest.reasonReference
        * MedicationRequest.requester
        * MedicationRequest.subject



</details>



## 2.18 MedicationStatement Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core MedicationStatement.</summary>

# Background

The AU Core MedicationStatement sequence verifies that the system under test is
able to provide correct responses for MedicationStatement queries. These queries
must contain resources conforming to the AU Core MedicationStatement as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.18.1 (SHALL) Server returns valid results for MedicationStatement search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.18.2 (SHOULD) Server returns valid results for MedicationStatement search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?_id={_id}
```



</details>



#### 2.18.3 (MAY) Server returns valid results for MedicationStatement search by effective
<details>

<summary>Show details</summary>

A server MAY support searching by
effective on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?effective={effective} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?effective={effective}
```



</details>



#### 2.18.4 (MAY) Server returns valid results for MedicationStatement search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /MedicationStatement?status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?status={status}
```



</details>



#### 2.18.5 (SHALL) Server returns valid results for MedicationStatement search by patient + status
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.18.6 (SHOULD) Server returns valid results for MedicationStatement search by patient + effective
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + effective on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.18.7 (SHOULD) Server returns valid results for MedicationStatement search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the MedicationStatement resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.18.8 (SHOULD) Server returns valid results for MedicationStatement search by patient (IHI) (chained parameters)
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



#### 2.18.9 (SHOULD) Server returns valid results for MedicationStatement search by patient (Medicare) (chained parameters)
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



#### 2.18.10 (SHOULD) Server returns valid results for MedicationStatement search by patient (DVA) (chained parameters)
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



#### 2.18.11 (SHALL) Server returns correct MedicationStatement resource from MedicationStatement read interaction
<details>

<summary>Show details</summary>

A server SHALL support the MedicationStatement read interaction.



</details>



#### 2.18.12 MedicationStatement resources returned during previous tests conform to the AU Core MedicationStatement
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core MedicationStatement](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement



</details>



#### 2.18.13 All must support elements are provided in the MedicationStatement resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationStatement resources
        found previously for the following must support elements:

        * MedicationStatement.dateAsserted
        * MedicationStatement.dosage
        * MedicationStatement.effective[x]
        * MedicationStatement.medication[x]
        * MedicationStatement.reasonCode
        * MedicationStatement.reasonReference
        * MedicationStatement.status
        * MedicationStatement.subject



</details>



#### 2.18.14 MustSupport references within MedicationStatement resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * MedicationStatement.medication[x]
        * MedicationStatement.reasonReference
        * MedicationStatement.subject



</details>



## 2.19 Procedure Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Procedure.</summary>

# Background

The AU Core Procedure sequence verifies that the system under test is
able to provide correct responses for Procedure queries. These queries
must contain resources conforming to the AU Core Procedure as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.19.1 (SHALL) Server returns valid results for Procedure search by patient
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.2 (MAY) Server returns valid results for Procedure search by code
<details>

<summary>Show details</summary>

A server MAY support searching by
code on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.3 (MAY) Server returns valid results for Procedure search by date
<details>

<summary>Show details</summary>

A server MAY support searching by
date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Procedure?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?date={date}
```



</details>



#### 2.19.4 (MAY) Server returns valid results for Procedure search by status
<details>

<summary>Show details</summary>

A server MAY support searching by
status on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.5 (SHALL) Server returns valid results for Procedure search by patient + date
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient + date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.6 (SHOULD) Server returns valid results for Procedure search by patient + code + date
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + code + date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.7 (SHOULD) Server returns valid results for Procedure search by patient + status
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + status on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.8 (SHOULD) Server returns valid results for Procedure multipleOr search by code
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
code on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.9 (SHOULD) Server returns valid results for Procedure multipleOr search by status
<details>

<summary>Show details</summary>

A server SHOULD support searching by multipleOr
status on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.10 (MAY) Server returns valid results for Procedure multipleAnd search by date
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
date on the Procedure resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /Procedure?date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?date={date}
```



</details>



#### 2.19.11 (SHOULD) Server returns valid results for Procedure search by patient (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient:Patient.identifier on the Procedure resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.19.12 (SHOULD) Server returns valid results for Procedure search by patient (IHI) (chained parameters)
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



#### 2.19.13 (SHOULD) Server returns valid results for Procedure search by patient (Medicare) (chained parameters)
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



#### 2.19.14 (SHOULD) Server returns valid results for Procedure search by patient (DVA) (chained parameters)
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



#### 2.19.15 (SHALL) Server returns correct Procedure resource from Procedure read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Procedure read interaction.



</details>



#### 2.19.16 Procedure resources returned during previous tests conform to the AU Core Procedure
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Procedure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure



</details>



#### 2.19.17 All must support elements are provided in the Procedure resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.code
        * Procedure.encounter
        * Procedure.performed[x]
        * Procedure.reasonCode
        * Procedure.reasonReference
        * Procedure.status
        * Procedure.subject



</details>



#### 2.19.18 MustSupport references within Procedure resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Procedure.encounter
        * Procedure.reasonReference
        * Procedure.subject



</details>



## 2.20 RelatedPerson Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core RelatedPerson.</summary>

# Background

The AU Core RelatedPerson sequence verifies that the system under test is
able to provide correct responses for RelatedPerson queries. These queries
must contain resources conforming to the AU Core RelatedPerson as
specified in the AU Core v1.1.0-preview Implementation Guide.

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


#### 2.20.1 (SHALL) Server returns valid results for RelatedPerson search by patient
<details>

<summary>Show details</summary>

A server SHALL support searching by
patient on the RelatedPerson resource. This test
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?patient={patient}
```



</details>



#### 2.20.2 (SHOULD) Server returns valid results for RelatedPerson search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?_id={_id}
```



</details>



#### 2.20.3 (MAY) Server returns valid results for RelatedPerson search by name
<details>

<summary>Show details</summary>

A server MAY support searching by
name on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?name={name}
```



</details>



#### 2.20.4 (MAY) Server returns valid results for RelatedPerson search by relationship
<details>

<summary>Show details</summary>

A server MAY support searching by
relationship on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?relationship={relationship} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?relationship={relationship}
```



</details>



#### 2.20.5 (SHOULD) Server returns valid results for RelatedPerson search by patient + relationship
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + relationship on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?patient relationship={patient relationship} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?patient relationship={patient relationship}
```



</details>



#### 2.20.6 (SHOULD) Server returns valid results for RelatedPerson search by patient + name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
patient + name on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /RelatedPerson?patient name={patient name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?patient name={patient name}
```



</details>



#### 2.20.7 (SHALL) Server returns correct RelatedPerson resource from RelatedPerson read interaction
<details>

<summary>Show details</summary>

A server SHALL support the RelatedPerson read interaction.



</details>



#### 2.20.8 RelatedPerson resources returned during previous tests conform to the AU Core RelatedPerson
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core RelatedPerson](http://hl7.org.au/fhir/core/StructureDefinition/au-core-relatedperson



</details>



#### 2.20.9 All must support elements are provided in the RelatedPerson resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the RelatedPerson resources
        found previously for the following must support elements:

        * RelatedPerson.address
        * RelatedPerson.name
        * RelatedPerson.name.family
        * RelatedPerson.name.given
        * RelatedPerson.name.text
        * RelatedPerson.name.use
        * RelatedPerson.patient
        * RelatedPerson.relationship
        * RelatedPerson.telecom



</details>



#### 2.20.10 MustSupport references within RelatedPerson resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * RelatedPerson.patient



</details>



## 2.21 Location Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Location.</summary>

# Background

The AU Core Location sequence verifies that the system under test is
able to provide correct responses for Location queries. These queries
must contain resources conforming to the AU Core Location as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* name

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 2.21.1 (SHALL) Server returns correct Location resource from Location read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Location read interaction.



</details>



#### 2.21.2 (SHOULD) Server returns valid results for Location search by address
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.21.3 (SHALL) Server returns valid results for Location search by name
<details>

<summary>Show details</summary>

A server SHALL support searching by
name on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.21.4 (SHOULD) Server returns valid results for Location search by address-city
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-city on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.21.5 (SHOULD) Server returns valid results for Location search by address-state
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-state on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.21.6 (SHOULD) Server returns valid results for Location search by address-postalcode
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address-postalcode on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.21.7 Location resources returned during previous tests conform to the AU Core Location
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Location](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location



</details>



#### 2.21.8 All must support elements are provided in the Location resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Location resources
        found previously for the following must support elements:

        * Location.address
        * Location.managingOrganization
        * Location.name
        * Location.physicalType
        * Location.type



</details>



#### 2.21.9 MustSupport references within Location resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Location.managingOrganization



</details>



## 2.22 Organization Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Organization.</summary>

# Background

The AU Core Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the AU Core Organization as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* identifier
* name

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 2.22.1 (SHALL) Server returns correct Organization resource from Organization read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Organization read interaction.



</details>



#### 2.22.2 (SHOULD) Server returns valid results for Organization search by _id
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
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.22.3 (SHOULD) Server returns valid results for Organization search by address
<details>

<summary>Show details</summary>

A server SHOULD support searching by
address on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.22.4 (SHALL) Server returns valid results for Organization search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.22.5 (SHALL) Server returns valid results for Organization search by name
<details>

<summary>Show details</summary>

A server SHALL support searching by
name on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.22.6 (SHOULD) Server returns valid results for Organization search by identifier (HPI-O)
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



#### 2.22.7 (SHOULD) Server returns valid results for Organization search by identifier (ABN)
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



#### 2.22.8 Organization resources returned during previous tests conform to the AU Core Organization
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Organization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization



</details>



#### 2.22.9 All must support elements are provided in the Organization resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Organization resources
        found previously for the following must support elements:

        * Organization.address
        * Organization.identifier
        * Organization.name
        * Organization.telecom
        * Organization.type



</details>



## 2.23 Practitioner Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core Practitioner.</summary>

# Background

The AU Core Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the AU Core Practitioner as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* identifier

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 2.23.1 (SHALL) Server returns correct Practitioner resource from Practitioner read interaction
<details>

<summary>Show details</summary>

A server SHALL support the Practitioner read interaction.



</details>



#### 2.23.2 (SHOULD) Server returns valid results for Practitioner search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.23.3 (SHALL) Server returns valid results for Practitioner search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.23.4 (SHOULD) Server returns valid results for Practitioner search by name
<details>

<summary>Show details</summary>

A server SHOULD support searching by
name on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.23.5 (SHOULD) Server returns valid results for Practitioner search by identifier (HPI-I)
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



#### 2.23.6 Practitioner resources returned during previous tests conform to the AU Core Practitioner
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core Practitioner](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner



</details>



#### 2.23.7 All must support elements are provided in the Practitioner resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

        * Practitioner.identifier
        * Practitioner.name
        * Practitioner.name.family
        * Practitioner.name.given



</details>



## 2.24 PractitionerRole Tests

<details>

<summary>Verify support for the server capabilities required by the AU Core PractitionerRole.</summary>

# Background

The AU Core PractitionerRole sequence verifies that the system under test is
able to provide correct responses for PractitionerRole queries. These queries
must contain resources conforming to the AU Core PractitionerRole as
specified in the AU Core v1.1.0-preview Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* identifier
* practitioner

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md

</details>

### Tests


#### 2.24.1 (SHALL) Server returns correct PractitionerRole resource from PractitionerRole read interaction
<details>

<summary>Show details</summary>

A server SHALL support the PractitionerRole read interaction.



</details>



#### 2.24.2 (SHOULD) Server returns valid results for PractitionerRole search by _id
<details>

<summary>Show details</summary>

A server SHOULD support searching by
_id on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v1.1.0-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.3 (SHALL) Server returns valid results for PractitionerRole search by identifier
<details>

<summary>Show details</summary>

A server SHALL support searching by
identifier on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.4 (SHALL) Server returns valid results for PractitionerRole search by practitioner
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

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.5 (SHOULD) Server returns valid results for PractitionerRole search by specialty
<details>

<summary>Show details</summary>

A server SHOULD support searching by
specialty on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.6 (SHOULD) Server returns valid results for PractitionerRole search by role
<details>

<summary>Show details</summary>

A server SHOULD support searching by
role on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?role={role} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?role={role}
```



</details>



#### 2.24.7 (MAY) Server returns valid results for PractitionerRole search by organization
<details>

<summary>Show details</summary>

A server MAY support searching by
organization on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



##### Requests

**HTTP GET**

```bash
GET /PractitionerRole?organization={organization} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/PractitionerRole?organization={organization}
```



</details>



#### 2.24.8 (MAY) Server returns valid results for PractitionerRole multipleOr search by practitioner
<details>

<summary>Show details</summary>

A server MAY support searching by multipleOr
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.9 (MAY) Server returns valid results for PractitionerRole multipleAnd search by practitioner
<details>

<summary>Show details</summary>

A server MAY support searching by multipleAnd
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.10 (SHOULD) Server returns valid results for PractitionerRole search by practitioner (chained parameters)
<details>

<summary>Show details</summary>

A server SHOULD support searching by
practitioner:Practitioner.identifier on the PractitionerRole resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html



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



#### 2.24.11 (SHOULD) Server returns valid results for PractitionerRole search by identifier (Medicare)
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



#### 2.24.12 Server returns Practitioner resources from PractitionerRole search by _id and PractitionerRole:practitioner
<details>

<summary>Show details</summary>

This test will perform a search by _id and the _include=PractitionerRole:practitioner

Test will pass if a Practitioner resources are found in the response.



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



#### 2.24.13 Server returns Practitioner resources from PractitionerRole search by identifier and PractitionerRole:practitioner
<details>

<summary>Show details</summary>

This test will perform a search by identifier and the _include=PractitionerRole:practitioner

Test will pass if a Practitioner resources are found in the response.



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



#### 2.24.14 Server returns Practitioner resources from PractitionerRole search by practitioner and PractitionerRole:practitioner
<details>

<summary>Show details</summary>

This test will perform a search by practitioner and the _include=PractitionerRole:practitioner

Test will pass if a Practitioner resources are found in the response.



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



#### 2.24.15 Server returns Practitioner resources from PractitionerRole search by specialty and PractitionerRole:practitioner
<details>

<summary>Show details</summary>

This test will perform a search by specialty and the _include=PractitionerRole:practitioner

Test will pass if a Practitioner resources are found in the response.



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



#### 2.24.16 PractitionerRole resources returned during previous tests conform to the AU Core PractitionerRole
<details>

<summary>Show details</summary>

This test verifies resources returned from the first search conform to
the [AU Core PractitionerRole](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole



</details>



#### 2.24.17 All must support elements are provided in the PractitionerRole resources returned
<details>

<summary>Show details</summary>

AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the PractitionerRole resources
        found previously for the following must support elements:

        * PractitionerRole.code
        * PractitionerRole.identifier
        * PractitionerRole.organization
        * PractitionerRole.practitioner
        * PractitionerRole.specialty
        * PractitionerRole.telecom



</details>



#### 2.24.18 MustSupport references within PractitionerRole resources are valid
<details>

<summary>Show details</summary>

This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * PractitionerRole.organization
        * PractitionerRole.practitioner



</details>


