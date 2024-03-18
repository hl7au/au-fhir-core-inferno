# 1 AU Core FHIR API


# 1.1 CapabilityStatement

#### Background
The Capability Statement Sequence tests a FHIR server's ability to formally describe
features supported by the API by using the [Capability
Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
The features described in the Capability Statement must be consistent with
the required capabilities of a AU Core server. The Capability Statement
must also advertise the location of the required SMART on FHIR endpoints
that enable authenticated access to the FHIR server resources.

The Capability Statement resource allows clients to determine which
resources are supported by a FHIR Server. Not all servers are expected to
implement all possible queries and data elements described in the AU Core
API. For example, the AU Core Implementation Guide requires that the
Patient resource and only one additional resource profile from the AU Core
Profiles.

#### Testing Methodology

This test sequence accesses the server endpoint at `/metadata` using a
`GET` request. It parses the Capability Statement and verifies that:

* The endpoint is secured by an appropriate cryptographic protocol
* The resource matches the expected FHIR version defined by the tests
* The resource is a valid FHIR resource
* The server claims support for JSON encoding of resources
* The server claims support for the Patient resource and one other
  resource

It collects the following information that is saved in the testing session
for use by later tests:

* List of resources supported
* List of queries parameters supported






# 1.2 Patient

#### Background

The AU Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the AU Core Patient as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Patient resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Patient resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Patient](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.2.1 Search: _id (SHALL)

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

### 1.2.2 Search: family (SHOULD)

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

### 1.2.3 Search: identifier (SHALL)

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

### 1.2.4 Search: name (SHOULD)

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

### 1.2.5 Search: birthdate+family (SHOULD)

**HTTP GET**

```bash
GET /Patient?birthdate={birthdate}&family={family} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate={birthdate}&family={family}
```

### 1.2.6 Search: birthdate+name (SHOULD)

**HTTP GET**

```bash
GET /Patient?birthdate={birthdate}&name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?birthdate={birthdate}&name={name}
```

### 1.2.7 Search: family+gender (SHOULD)

**HTTP GET**

```bash
GET /Patient?family={family}&gender={gender} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?family={family}&gender={gender}
```

### 1.2.8 Search: gender+name (SHOULD)

**HTTP GET**

```bash
GET /Patient?gender={gender}&name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Patient?gender={gender}&name={name}
```



# 1.3 Observation Body Weight

#### Background

The AU Core Observation Body Weight sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Weight as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Body Weight](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.3.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.3.2 Search: patient (SHALL)

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

### 1.3.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.3.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.3.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.3.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.4 Observation Blood Pressure

#### Background

The AU Core Observation Blood Pressure sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Blood Pressure as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Blood Pressure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.4.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.4.2 Search: patient (SHALL)

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

### 1.4.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.4.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.4.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.4.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.5 Observation Body Height

#### Background

The AU Core Observation Body Height sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Height as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Body Height](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.5.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.5.2 Search: patient (SHALL)

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

### 1.5.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.5.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.5.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.5.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.6 Observation Pathology Result

#### Background

The AU Core Observation Pathology Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Pathology Result Observation as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + category
* patient
* patient + category + date
* patient + code
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Pathology Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.6.1 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.6.2 Search: patient (SHALL)

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

### 1.6.3 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.6.4 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.6.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.6.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.7 Observation Body Temperature

#### Background

The AU Core Observation Body Temperature sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Temperature as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Body Temperature](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.7.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.7.2 Search: patient (SHALL)

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

### 1.7.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.7.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.7.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.7.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.8 Observation Heart Rate

#### Background

The AU Core Observation Heart Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Heart Rate as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Heart Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.8.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.8.2 Search: patient (SHALL)

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

### 1.8.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.8.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.8.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.8.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.9 Observation Waist Circumference

#### Background

The AU Core Observation Waist Circumference sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Waist Circumference as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Waist Circumference](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.9.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.9.2 Search: patient (SHALL)

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

### 1.9.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.9.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.9.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.9.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.10 Observation Respiration Rate

#### Background

The AU Core Observation Respiration Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Respiration Rate as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Respiration Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.10.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.10.2 Search: patient (SHALL)

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

### 1.10.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.10.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.10.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.10.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.11 Observation Diagnostic Result

#### Background

The AU Core Observation Diagnostic Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Diagnostic Result Observation as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + category
* patient + category + date
* patient + code
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Diagnostic Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.11.1 Search: patient (SHALL)

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

### 1.11.2 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.11.3 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.11.4 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.11.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.11.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.12 Observation Smoking Status

#### Background

The AU Core Observation Smoking Status sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Smoking Status as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient + code
* patient
* patient + category
* patient + category + date
* patient + category + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Observation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Observation resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Smoking Status](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.12.1 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}
```

### 1.12.2 Search: patient (SHALL)

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

### 1.12.3 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}
```

### 1.12.4 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&date={date}
```

### 1.12.5 Search: patient+category+status (SHALL)

**HTTP GET**

```bash
GET /Observation?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&category={category}&status={status}
```

### 1.12.6 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Observation?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Observation?patient={patient}&code={code}&date={date}
```



# 1.13 AllergyIntolerance

#### Background

The AU Core AllergyIntolerance sequence verifies that the system under test is
able to provide correct responses for AllergyIntolerance queries. These queries
must contain resources conforming to the AU Core AllergyIntolerance as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
AllergyIntolerance resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the AllergyIntolerance resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core AllergyIntolerance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.13.1 Search: patient (SHALL)

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

### 1.13.2 Search: patient+clinical-status (SHOULD)

**HTTP GET**

```bash
GET /AllergyIntolerance?patient={patient}&clinical-status={clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/AllergyIntolerance?patient={patient}&clinical-status={clinical-status}
```



# 1.14 Condition

#### Background

The AU Core Condition sequence verifies that the system under test is
able to provide correct responses for Condition queries. These queries
must contain resources conforming to the AU Core Condition as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + category
* patient + clinical-status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Condition resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Condition resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Condition](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.14.1 Search: patient (SHALL)

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

### 1.14.2 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /Condition?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}&category={category}
```

### 1.14.3 Search: patient+clinical-status (SHALL)

**HTTP GET**

```bash
GET /Condition?patient={patient}&clinical-status={clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}&clinical-status={clinical-status}
```

### 1.14.4 Search: patient+category+clinical-status (SHOULD)

**HTTP GET**

```bash
GET /Condition?patient={patient}&category={category}&clinical-status={clinical-status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}&category={category}&clinical-status={clinical-status}
```

### 1.14.5 Search: patient+code (SHOULD)

**HTTP GET**

```bash
GET /Condition?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}&code={code}
```

### 1.14.6 Search: patient+onset-date (SHOULD)

**HTTP GET**

```bash
GET /Condition?patient={patient}&onset-date={onset-date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Condition?patient={patient}&onset-date={onset-date}
```



# 1.15 Encounter

#### Background

The AU Core Encounter sequence verifies that the system under test is
able to provide correct responses for Encounter queries. These queries
must contain resources conforming to the AU Core Encounter as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* date + patient

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Encounter resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Encounter resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Encounter](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.15.1 Search: patient (SHALL)

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

### 1.15.2 Search: date+patient (SHALL)

**HTTP GET**

```bash
GET /Encounter?date={date}&patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?date={date}&patient={patient}
```

### 1.15.3 Search: class+patient (SHOULD)

**HTTP GET**

```bash
GET /Encounter?class={class}&patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?class={class}&patient={patient}
```

### 1.15.4 Search: patient+discharge-disposition (SHOULD)

**HTTP GET**

```bash
GET /Encounter?patient={patient}&discharge-disposition={discharge-disposition} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}&discharge-disposition={discharge-disposition}
```

### 1.15.5 Search: patient+location (SHOULD)

**HTTP GET**

```bash
GET /Encounter?patient={patient}&location={location} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}&location={location}
```

### 1.15.6 Search: patient+status (SHOULD)

**HTTP GET**

```bash
GET /Encounter?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}&status={status}
```

### 1.15.7 Search: patient+type (SHOULD)

**HTTP GET**

```bash
GET /Encounter?patient={patient}&type={type} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Encounter?patient={patient}&type={type}
```



# 1.16 Immunization

#### Background

The AU Core Immunization sequence verifies that the system under test is
able to provide correct responses for Immunization queries. These queries
must contain resources conforming to the AU Core Immunization as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Immunization resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Immunization resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Immunization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.16.1 Search: patient (SHALL)

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

### 1.16.2 Search: patient+status (SHALL)

**HTTP GET**

```bash
GET /Immunization?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient={patient}&status={status}
```

### 1.16.3 Search: patient+date (SHOULD)

**HTTP GET**

```bash
GET /Immunization?patient={patient}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Immunization?patient={patient}&date={date}
```



# 1.17 MedicationRequest

#### Background

The AU Core MedicationRequest sequence verifies that the system under test is
able to provide correct responses for MedicationRequest queries. These queries
must contain resources conforming to the AU Core MedicationRequest as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* _id
* identifier
* patient + intent
* patient + intent + status
* patient + intent + authoredon

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
MedicationRequest resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the MedicationRequest resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core MedicationRequest](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.17.1 Search: patient (SHALL)

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

### 1.17.2 Search: _id (SHALL)

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

### 1.17.3 Search: identifier (SHALL)

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

### 1.17.4 Search: patient+intent (SHALL)

**HTTP GET**

```bash
GET /MedicationRequest?patient={patient}&intent={intent} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient={patient}&intent={intent}
```

### 1.17.5 Search: patient+intent+status (SHALL)

**HTTP GET**

```bash
GET /MedicationRequest?patient={patient}&intent={intent}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient={patient}&intent={intent}&status={status}
```

### 1.17.6 Search: patient+intent+authoredon (SHALL)

**HTTP GET**

```bash
GET /MedicationRequest?patient={patient}&intent={intent}&authoredon={authoredon} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationRequest?patient={patient}&intent={intent}&authoredon={authoredon}
```



# 1.18 MedicationStatement

#### Background

The AU Core MedicationStatement sequence verifies that the system under test is
able to provide correct responses for MedicationStatement queries. These queries
must contain resources conforming to the AU Core MedicationStatement as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + status

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
MedicationStatement resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the MedicationStatement resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core MedicationStatement](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.18.1 Search: patient (SHALL)

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

### 1.18.2 Search: patient+status (SHALL)

**HTTP GET**

```bash
GET /MedicationStatement?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient={patient}&status={status}
```

### 1.18.3 Search: patient+effective (SHOULD)

**HTTP GET**

```bash
GET /MedicationStatement?patient={patient}&effective={effective} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/MedicationStatement?patient={patient}&effective={effective}
```



# 1.19 Procedure

#### Background

The AU Core Procedure sequence verifies that the system under test is
able to provide correct responses for Procedure queries. These queries
must contain resources conforming to the AU Core Procedure as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* patient + date

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Procedure resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Procedure resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Procedure](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.19.1 Search: patient (SHALL)

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

### 1.19.2 Search: patient+date (SHALL)

**HTTP GET**

```bash
GET /Procedure?patient={patient}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient={patient}&date={date}
```

### 1.19.3 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /Procedure?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient={patient}&code={code}&date={date}
```

### 1.19.4 Search: patient+status (SHOULD)

**HTTP GET**

```bash
GET /Procedure?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/Procedure?patient={patient}&status={status}
```



# 1.20 Organization

#### Background

The AU Core Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the AU Core Organization as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
* identifier
* name

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Organization resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Organization resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Organization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.20.1 Search: _id (SHOULD)

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

### 1.20.2 Search: address (SHALL)

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

### 1.20.3 Search: identifier (SHALL)

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

### 1.20.4 Search: name (SHALL)

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



# 1.21 Practitioner

#### Background

The AU Core Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the AU Core Practitioner as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Practitioner resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Practitioner resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Practitioner](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (SHALL)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




## Test scenarios


### 1.21.1 Search: _id (SHALL)

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

### 1.21.2 Search: identifier (SHALL)

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

### 1.21.3 Search: name (SHOULD)

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



# 1.22 Provenance

#### Background

The AU Core Provenance sequence verifies that the system under test is
able to provide correct responses for Provenance queries. These queries
must contain resources conforming to the AU Core Provenance as
specified in the AU Core v0.3.0-ballot Implementation Guide.

#### Testing Methodology


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Provenance resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Provenance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.



## Interactions


* read (SHALL)

* search-type (MAY)

* create (MAY)

* update (MAY)

* delete (MAY)

* vread (MAY)

* patch (MAY)

* history-instance (MAY)




