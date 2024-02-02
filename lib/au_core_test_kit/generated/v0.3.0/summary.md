# Capabilities by Resource/Profile


## 1 Patient

**Resource:** Patient

### Profiles


* [AU Core Patient ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)

* [AU Core Patient ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 1.1 Search: _id (SHALL)

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

#### 1.2 Search: family (SHOULD)

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

#### 1.3 Search: identifier (SHALL)

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

#### 1.4 Search: name (SHOULD)

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

#### 1.5 Search: birthdate+family (SHOULD)

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

#### 1.6 Search: birthdate+name (SHOULD)

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

#### 1.7 Search: family+gender (SHOULD)

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

#### 1.8 Search: gender+name (SHOULD)

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


## 2 Observation

**Resource:** Observation

### Profiles


* [Observation AU Core BMI ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi)

* [Observation AU Core Body Weight ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight)

* [Observation AU Core Oxygen Saturation ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat)

* [Observation AU Core Blood Pressure ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure)

* [Observation AU Core Body Height ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight)

* [Observation AU Core Pathology Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path)

* [Observation AU Core Lipid Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result)

* [Observation AU Core Head Circumference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum)

* [Observation AU Core Body Temperature ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp)

* [Observation AU Core Heart Rate ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate)

* [Observation AU Core Waist Circumference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum)

* [Observation AU Core Vitals Panel ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel)

* [Observation AU Core Respiration Rate ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate)

* [Observation AU Core Diagnostic Imaging Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag)

* [Observation AU Core Diagnostic Result ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult)

* [Observation AU Core Biological Sex Assigned at Birth ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth)

* [Observation AU Core Smoking Status ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus)

* [Observation AU Core ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 2.1 Search: patient+code (SHALL)

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

#### 2.2 Search: patient (SHALL)

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

#### 2.3 Search: patient+category (SHALL)

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

#### 2.4 Search: patient+category+date (SHALL)

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

#### 2.5 Search: patient+category+status (SHALL)

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

#### 2.6 Search: patient+code+date (SHOULD)

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


## 3 MedicationRequest

**Resource:** MedicationRequest

### Profiles


* [AU Core MedicationRequest ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 3.1 Search: patient+intent (SHALL)

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

#### 3.2 Search: _id (SHALL)

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

#### 3.3 Search: identifier (SHALL)

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

#### 3.4 Search: patient (SHALL)

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

#### 3.5 Search: patient+intent+status (SHALL)

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

#### 3.6 Search: patient+intent+authoredon (SHALL)

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


## 4 Encounter

**Resource:** Encounter

### Profiles


* [AU Core Encounter ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 4.1 Search: patient (SHALL)

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

#### 4.2 Search: date+patient (SHALL)

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

#### 4.3 Search: class+patient (SHOULD)

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

#### 4.4 Search: patient+location (SHOULD)

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

#### 4.5 Search: patient+status (SHOULD)

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

#### 4.6 Search: patient+type (SHOULD)

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


## 5 Condition

**Resource:** Condition

### Profiles


* [Condition AU Core ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 5.1 Search: patient (SHALL)

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

#### 5.2 Search: patient+category (SHALL)

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

#### 5.3 Search: patient+clinical-status (SHALL)

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

#### 5.4 Search: patient+category+clinical-status (SHOULD)

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

#### 5.5 Search: patient+code (SHOULD)

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

#### 5.6 Search: patient+onset-date (SHOULD)

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


## 6 Procedure

**Resource:** Procedure

### Profiles


* [AU Core Procedure ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 6.1 Search: patient (SHALL)

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

#### 6.2 Search: patient+date (SHALL)

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

#### 6.3 Search: patient+code+date (SHOULD)

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

#### 6.4 Search: patient+status (SHOULD)

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


## 7 DiagnosticReport

**Resource:** DiagnosticReport

### Profiles


* [DiagnosticReport AU Core ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 7.1 Search: patient (SHALL)

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

#### 7.2 Search: _id (SHALL)

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

#### 7.3 Search: identifier (SHALL)

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

#### 7.4 Search: patient+category (SHALL)

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

#### 7.5 Search: patient+category+date (SHALL)

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

#### 7.6 Search: patient+category+status (SHOULD)

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

#### 7.7 Search: patient+code (SHOULD)

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

#### 7.8 Search: patient+code+date (SHOULD)

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

#### 7.9 Search: patient+status (SHOULD)

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


## 8 Immunization

**Resource:** Immunization

### Profiles


* [AU Core Immunization ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 8.1 Search: patient (SHALL)

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

#### 8.2 Search: patient+status (SHALL)

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

#### 8.3 Search: patient+date (SHOULD)

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


## 9 AllergyIntolerance

**Resource:** AllergyIntolerance

### Profiles


* [AU Core AllergyIntolerance ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 9.1 Search: patient (SHALL)

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

#### 9.2 Search: patient+clinical-status (SHOULD)

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


## 10 Medication

**Resource:** Medication

### Profiles


* [AU Core Medication ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication)



### Interactions


* read (SHALL)

* search-type (MAY)


### Test scenarios



## 11 MedicationStatement

**Resource:** MedicationStatement

### Profiles


* [AU Core MedicationStatement ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 11.1 Search: patient (SHALL)

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

#### 11.2 Search: patient+status (SHALL)

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

#### 11.3 Search: patient+effective (SHOULD)

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


## 12 Practitioner

**Resource:** Practitioner

### Profiles


* [AU Core Practitioner ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 12.1 Search: _id (SHALL)

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

#### 12.2 Search: identifier (SHALL)

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

#### 12.3 Search: name (SHOULD)

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


## 13 Organization

**Resource:** Organization

### Profiles


* [AU Core Organization ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 13.1 Search: address (SHALL)

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

#### 13.2 Search: identifier (SHALL)

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

#### 13.3 Search: name (SHALL)

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

#### 13.4 Search: _id (SHOULD)

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


## 14 PractitionerRole

**Resource:** PractitionerRole

### Profiles


* [AU Core PractitionerRole ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 14.1 Search: _id (SHALL)

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

#### 14.2 Search: identifier (SHALL)

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

#### 14.3 Search: practitioner (SHALL)

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

#### 14.4 Search: specialty (SHOULD)

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


## 15 HealthcareService

**Resource:** HealthcareService

### Profiles


* [AU Core HealthcareService ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 15.1 Search: name (SHALL)

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

#### 15.2 Search: service-category (SHOULD)

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

#### 15.3 Search: identifier (SHOULD)

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

#### 15.4 Search: location (SHOULD)

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

#### 15.5 Search: organization (SHOULD)

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

#### 15.6 Search: specialty (SHOULD)

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

#### 15.7 Search: service-type (SHOULD)

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


## 16 Location

**Resource:** Location

### Profiles


* [AU Core Location ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 16.1 Search: address (SHALL)

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

#### 16.2 Search: name (SHALL)

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

#### 16.3 Search: address-city (SHOULD)

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

#### 16.4 Search: address-state (SHOULD)

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

#### 16.5 Search: address-postalcode (SHOULD)

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


## 17 DocumentReference

**Resource:** DocumentReference

### Profiles


* [AU Core DocumentReference ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 17.1 Search: patient (SHALL)

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

#### 17.2 Search: _id (SHALL)

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

#### 17.3 Search: identifier (SHALL)

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

#### 17.4 Search: patient+category (SHALL)

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

#### 17.5 Search: patient+category+date (SHALL)

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

#### 17.6 Search: patient+category+status (SHOULD)

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

#### 17.7 Search: patient+contenttype (SHOULD)

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

#### 17.8 Search: patient+status (SHOULD)

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

#### 17.9 Search: patient+type (SHOULD)

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

#### 17.10 Search: patient+type+date (SHOULD)

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


## 18 ServiceRequest

**Resource:** ServiceRequest

### Profiles


* [AU Core ServiceRequest ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest)



### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 18.1 Search: patient (SHALL)

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

#### 18.2 Search: _id (SHALL)

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

#### 18.3 Search: identifier (SHALL)

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

#### 18.4 Search: patient+category (SHALL)

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

#### 18.5 Search: patient+category+authored (SHALL)

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

#### 18.6 Search: patient+code (SHALL)

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

#### 18.7 Search: patient+category+status (SHOULD)

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

#### 18.8 Search: patient+code+authored (SHOULD)

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

#### 18.9 Search: patient+status (SHOULD)

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


## 19 Provenance

**Resource:** Provenance

### Profiles


* [AU Core Provenance ](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance)



### Interactions


* read (SHALL)

* search-type (MAY)


### Test scenarios


