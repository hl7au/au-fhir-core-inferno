# Capabilities by Resource/Profile


# 1 Patient

## Profiles


### [Patient ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)
#### Background

The AU Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the AU Core Patient as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 1.1 Search: _id (SHALL)

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

### 1.2 Search: family (SHOULD)

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

### 1.3 Search: identifier (SHALL)

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

### 1.4 Search: name (SHOULD)

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

### 1.5 Search: birthdate+family (SHOULD)

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

### 1.6 Search: birthdate+name (SHOULD)

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

### 1.7 Search: family+gender (SHOULD)

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

### 1.8 Search: gender+name (SHOULD)

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


# 2 Observation

## Profiles


### [Observation BMI ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi)
#### Background

The AU Core Observation BMI sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core BMI as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core BMI](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Body Weight ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight)
#### Background

The AU Core Observation Body Weight sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Weight as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Oxygen Saturation ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat)
#### Background

The AU Core Observation Oxygen Saturation sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Oxygen Saturation as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Oxygen Saturation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Blood Pressure ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure)
#### Background

The AU Core Observation Blood Pressure sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Blood Pressure as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Body Height ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight)
#### Background

The AU Core Observation Body Height sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Height as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Pathology Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path)
#### Background

The AU Core Observation Pathology Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Pathology Result Observation as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Lipid Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result)
#### Background

The AU Core Observation Lipid Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Lipid Result as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Lipid Result](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Head Circumference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum)
#### Background

The AU Core Observation Head Circumference sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Head Circumference as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Head Circumference](http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Body Temperature ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp)
#### Background

The AU Core Observation Body Temperature sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Body Temperature as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Heart Rate ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate)
#### Background

The AU Core Observation Heart Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Heart Rate as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Waist Circumference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum)
#### Background

The AU Core Observation Waist Circumference sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Waist Circumference as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Vitals Panel ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel)
#### Background

The AU Core Observation Vitals Panel sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Vitals Panel as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Vitals Panel](http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Respiration Rate ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate)
#### Background

The AU Core Observation Respiration Rate sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Respiration Rate as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Diagnostic Imaging Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag)
#### Background

The AU Core Observation Diagnostic Imaging Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Diagnostic Imaging Result Observation as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Diagnostic Imaging Result Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Diagnostic Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult)
#### Background

The AU Core Observation Diagnostic Result sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Diagnostic Result Observation as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation Biological Sex Assigned at Birth ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth)
#### Background

The AU Core Observation Biological Sex Assigned at Birth sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Biological Sex Assigned at Birth as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Biological Sex Assigned at Birth](http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

##### Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.


### [Observation Smoking Status ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus)
#### Background

The AU Core Observation Smoking Status sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Smoking Status as
specified in the AU Core v0.3.0 Implementation Guide.

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


### [Observation ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation)
#### Background

The AU Core Observation sequence verifies that the system under test is
able to provide correct responses for Observation queries. These queries
must contain resources conforming to the AU Core Observation as
specified in the AU Core v0.3.0 Implementation Guide.

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
the [AU Core Observation](http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation). Each element is checked against
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


## Test scenarios


### 2.1 Search: patient+code (SHALL)

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

### 2.2 Search: patient (SHALL)

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

### 2.3 Search: patient+category (SHALL)

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

### 2.4 Search: patient+category+date (SHALL)

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

### 2.5 Search: patient+category+status (SHALL)

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

### 2.6 Search: patient+code+date (SHOULD)

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

### 2.1 Search: patient+category (SHALL)

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

### 2.3 Search: patient+category+date (SHALL)

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

### 2.4 Search: patient+code (SHALL)

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

### 2.1 Search: patient (SHALL)

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

### 2.2 Search: patient+category (SHALL)

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


# 3 MedicationRequest

## Profiles


### [MedicationRequest ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest)
#### Background

The AU Core MedicationRequest sequence verifies that the system under test is
able to provide correct responses for MedicationRequest queries. These queries
must contain resources conforming to the AU Core MedicationRequest as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 3.1 Search: patient (SHALL)

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

### 3.2 Search: _id (SHALL)

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

### 3.3 Search: identifier (SHALL)

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

### 3.4 Search: patient+intent (SHALL)

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

### 3.5 Search: patient+intent+status (SHALL)

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

### 3.6 Search: patient+intent+authoredon (SHALL)

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


# 4 Encounter

## Profiles


### [Encounter ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter)
#### Background

The AU Core Encounter sequence verifies that the system under test is
able to provide correct responses for Encounter queries. These queries
must contain resources conforming to the AU Core Encounter as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 4.1 Search: patient (SHALL)

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

### 4.2 Search: date+patient (SHALL)

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

### 4.3 Search: class+patient (SHOULD)

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

### 4.4 Search: patient+discharge-disposition (SHOULD)

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

### 4.5 Search: patient+location (SHOULD)

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

### 4.6 Search: patient+status (SHOULD)

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

### 4.7 Search: patient+type (SHOULD)

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


# 5 Condition

## Profiles


### [Condition ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition)
#### Background

The AU Core Condition sequence verifies that the system under test is
able to provide correct responses for Condition queries. These queries
must contain resources conforming to the AU Core Condition as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 5.1 Search: patient (SHALL)

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

### 5.2 Search: patient+category (SHALL)

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

### 5.3 Search: patient+clinical-status (SHALL)

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

### 5.4 Search: patient+category+clinical-status (SHOULD)

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

### 5.5 Search: patient+code (SHOULD)

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

### 5.6 Search: patient+onset-date (SHOULD)

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


# 6 Procedure

## Profiles


### [Procedure ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure)
#### Background

The AU Core Procedure sequence verifies that the system under test is
able to provide correct responses for Procedure queries. These queries
must contain resources conforming to the AU Core Procedure as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 6.1 Search: patient (SHALL)

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

### 6.2 Search: patient+date (SHALL)

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

### 6.3 Search: patient+code+date (SHOULD)

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

### 6.4 Search: patient+status (SHOULD)

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


# 7 DiagnosticReport

## Profiles


### [DiagnosticReport ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport)
#### Background

The AU Core DiagnosticReport sequence verifies that the system under test is
able to provide correct responses for DiagnosticReport queries. These queries
must contain resources conforming to the AU Core DiagnosticReport as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* _id
* identifier
* patient + category
* patient + category + date

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
DiagnosticReport resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the DiagnosticReport resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core DiagnosticReport](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport). Each element is checked against
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


## Test scenarios


### 7.1 Search: patient (SHALL)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}
```

### 7.2 Search: _id (SHALL)

**HTTP GET**

```bash
GET /DiagnosticReport?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?_id={_id}
```

### 7.3 Search: identifier (SHALL)

**HTTP GET**

```bash
GET /DiagnosticReport?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?identifier={identifier}
```

### 7.4 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&category={category}
```

### 7.5 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&category={category}&date={date}
```

### 7.6 Search: patient+category+status (SHOULD)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&category={category}&status={status}
```

### 7.7 Search: patient+code (SHOULD)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&code={code}
```

### 7.8 Search: patient+code+date (SHOULD)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&code={code}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&code={code}&date={date}
```

### 7.9 Search: patient+status (SHOULD)

**HTTP GET**

```bash
GET /DiagnosticReport?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DiagnosticReport?patient={patient}&status={status}
```


# 8 Immunization

## Profiles


### [Immunization ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization)
#### Background

The AU Core Immunization sequence verifies that the system under test is
able to provide correct responses for Immunization queries. These queries
must contain resources conforming to the AU Core Immunization as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 8.1 Search: patient (SHALL)

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

### 8.2 Search: patient+status (SHALL)

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

### 8.3 Search: patient+date (SHOULD)

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


# 9 AllergyIntolerance

## Profiles


### [AllergyIntolerance ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance)
#### Background

The AU Core AllergyIntolerance sequence verifies that the system under test is
able to provide correct responses for AllergyIntolerance queries. These queries
must contain resources conforming to the AU Core AllergyIntolerance as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 9.1 Search: patient (SHALL)

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

### 9.2 Search: patient+clinical-status (SHOULD)

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


# 10 Medication

## Profiles


### [Medication ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication)
#### Background

The AU Core Medication sequence verifies that the system under test is
able to provide correct responses for Medication queries. These queries
must contain resources conforming to the AU Core Medication as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Medication resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Medication](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication). Each element is checked against
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


## Test scenarios



# 11 MedicationStatement

## Profiles


### [MedicationStatement ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement)
#### Background

The AU Core MedicationStatement sequence verifies that the system under test is
able to provide correct responses for MedicationStatement queries. These queries
must contain resources conforming to the AU Core MedicationStatement as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 11.1 Search: patient (SHALL)

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

### 11.2 Search: patient+status (SHALL)

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

### 11.3 Search: patient+effective (SHOULD)

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


# 12 Practitioner

## Profiles


### [Practitioner ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner)
#### Background

The AU Core Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the AU Core Practitioner as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 12.1 Search: _id (SHALL)

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

### 12.2 Search: identifier (SHALL)

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

### 12.3 Search: name (SHOULD)

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


# 13 Organization

## Profiles


### [Organization ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization)
#### Background

The AU Core Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the AU Core Organization as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios


### 13.1 Search: _id (SHOULD)

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

### 13.2 Search: address (SHALL)

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

### 13.3 Search: identifier (SHALL)

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

### 13.4 Search: name (SHALL)

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


# 14 PractitionerRole

## Profiles


### [PractitionerRole ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole)
#### Background

The AU Core PractitionerRole sequence verifies that the system under test is
able to provide correct responses for PractitionerRole queries. These queries
must contain resources conforming to the AU Core PractitionerRole as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier
* practitioner

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
PractitionerRole resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the PractitionerRole resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core PractitionerRole](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole). Each element is checked against
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


## Test scenarios


### 14.1 Search: _id (SHALL)

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

### 14.2 Search: identifier (SHALL)

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

### 14.3 Search: practitioner (SHALL)

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

### 14.4 Search: specialty (SHOULD)

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


# 15 HealthcareService

## Profiles


### [HealthcareService ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice)
#### Background

The AU Core HealthcareService sequence verifies that the system under test is
able to provide correct responses for HealthcareService queries. These queries
must contain resources conforming to the AU Core HealthcareService as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

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
HealthcareService resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the HealthcareService resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core HealthcareService](http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice). Each element is checked against
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


## Test scenarios


### 15.1 Search: name (SHALL)

**HTTP GET**

```bash
GET /HealthcareService?name={name} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?name={name}
```

### 15.2 Search: service-category (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?service-category={service-category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?service-category={service-category}
```

### 15.3 Search: identifier (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?identifier={identifier}
```

### 15.4 Search: location (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?location={location} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?location={location}
```

### 15.5 Search: organization (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?organization={organization} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?organization={organization}
```

### 15.6 Search: specialty (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?specialty={specialty} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?specialty={specialty}
```

### 15.7 Search: service-type (SHOULD)

**HTTP GET**

```bash
GET /HealthcareService?service-type={service-type} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/HealthcareService?service-type={service-type}
```


# 16 Location

## Profiles


### [Location ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location)
#### Background

The AU Core Location sequence verifies that the system under test is
able to provide correct responses for Location queries. These queries
must contain resources conforming to the AU Core Location as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
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
Location resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Location resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Location](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location). Each element is checked against
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


## Test scenarios


### 16.1 Search: address (SHALL)

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

### 16.2 Search: name (SHALL)

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

### 16.3 Search: address-city (SHOULD)

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

### 16.4 Search: address-state (SHOULD)

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

### 16.5 Search: address-postalcode (SHOULD)

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


# 17 DocumentReference

## Profiles


### [DocumentReference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference)
#### Background

The AU Core DocumentReference sequence verifies that the system under test is
able to provide correct responses for DocumentReference queries. These queries
must contain resources conforming to the AU Core DocumentReference as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* _id
* identifier
* patient + category
* patient + category + date

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
DocumentReference resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the DocumentReference resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core DocumentReference](http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference). Each element is checked against
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


## Test scenarios


### 17.1 Search: patient (SHALL)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}
```

### 17.2 Search: _id (SHALL)

**HTTP GET**

```bash
GET /DocumentReference?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?_id={_id}
```

### 17.3 Search: identifier (SHALL)

**HTTP GET**

```bash
GET /DocumentReference?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?identifier={identifier}
```

### 17.4 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&category={category}
```

### 17.5 Search: patient+category+date (SHALL)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&category={category}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&category={category}&date={date}
```

### 17.6 Search: patient+category+status (SHOULD)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&category={category}&status={status}
```

### 17.7 Search: patient+contenttype (SHOULD)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&contenttype={contenttype} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&contenttype={contenttype}
```

### 17.8 Search: patient+status (SHOULD)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&status={status}
```

### 17.9 Search: patient+type (SHOULD)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&type={type} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&type={type}
```

### 17.10 Search: patient+type+date (SHOULD)

**HTTP GET**

```bash
GET /DocumentReference?patient={patient}&type={type}&date={date} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/DocumentReference?patient={patient}&type={type}&date={date}
```


# 18 ServiceRequest

## Profiles


### [ServiceRequest ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest)
#### Background

The AU Core ServiceRequest sequence verifies that the system under test is
able to provide correct responses for ServiceRequest queries. These queries
must contain resources conforming to the AU Core ServiceRequest as
specified in the AU Core v0.3.0 Implementation Guide.

#### Testing Methodology
##### Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* _id
* identifier
* patient + category
* patient + category + authored
* patient + code

###### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

###### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
ServiceRequest resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the ServiceRequest resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core ServiceRequest](http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest). Each element is checked against
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


## Test scenarios


### 18.1 Search: patient (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}
```

### 18.2 Search: _id (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?_id={_id} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?_id={_id}
```

### 18.3 Search: identifier (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?identifier={identifier}
```

### 18.4 Search: patient+category (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&category={category} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&category={category}
```

### 18.5 Search: patient+category+authored (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&category={category}&authored={authored} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&category={category}&authored={authored}
```

### 18.6 Search: patient+code (SHALL)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&code={code} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&code={code}
```

### 18.7 Search: patient+category+status (SHOULD)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&category={category}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&category={category}&status={status}
```

### 18.8 Search: patient+code+authored (SHOULD)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&code={code}&authored={authored} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&code={code}&authored={authored}
```

### 18.9 Search: patient+status (SHOULD)

**HTTP GET**

```bash
GET /ServiceRequest?patient={patient}&status={status} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/ServiceRequest?patient={patient}&status={status}
```


# 19 Provenance

## Profiles


### [Provenance ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance)
#### Background

The AU Core Provenance sequence verifies that the system under test is
able to provide correct responses for Provenance queries. These queries
must contain resources conforming to the AU Core Provenance as
specified in the AU Core v0.3.0 Implementation Guide.

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


## Test scenarios



# 20 RelatedPerson

## Profiles


### [AU Base Related Person ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-relatedperson)
#### Background

The AU Core AU Base Related Person sequence verifies that the system under test is
able to provide correct responses for RelatedPerson queries. These queries
must contain resources conforming to the AU Base Related Person as
specified in the AU Core v0.3.0 Implementation Guide.

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
RelatedPerson resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


##### Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the RelatedPerson resources found in the first test for these
elements.

##### Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Base Related Person](http://hl7.org.au/fhir/core/StructureDefinition/au-core-relatedperson). Each element is checked against
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


## Test scenarios


### 20.1 Search: patient (SHALL)

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

### 20.2 Search: _id (SHOULD)

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

### 20.3 Search: identifier (SHOULD)

**HTTP GET**

```bash
GET /RelatedPerson?identifier={identifier} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?identifier={identifier}
```

### 20.4 Search: name (SHOULD)

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

### 20.5 Search: patient+relationship (SHOULD)

**HTTP GET**

```bash
GET /RelatedPerson?patient={patient}&relationship={relationship} HTTP/1.1
User-Agent: {agent}
Host: {host}
Accept: application/fhir+json
```

**For browser based calls:**

```bash
{test endpoint}/RelatedPerson?patient={patient}&relationship={relationship}
```

