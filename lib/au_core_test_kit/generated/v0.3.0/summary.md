# Capabilities by Resource/Profile


## 1.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi)

**Description:** Verify support for the server capabilities required by the AU Core BMI.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 1.1 Search: patient+code (SHALL)

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

#### 1.2 Search: patient (SHALL)

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

#### 1.3 Search: patient+category (SHALL)

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

#### 1.4 Search: patient+category+date (SHALL)

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

#### 1.5 Search: patient+category+status (SHALL)

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

#### 1.6 Search: patient+code+date (SHOULD)

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


## 2.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight)

**Description:** Verify support for the server capabilities required by the AU Core Body Weight.

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


## 3.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat)

**Description:** Verify support for the server capabilities required by the AU Core Oxygen Saturation.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 3.1 Search: patient+code (SHALL)

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

#### 3.2 Search: patient (SHALL)

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

#### 3.3 Search: patient+category (SHALL)

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

#### 3.4 Search: patient+category+date (SHALL)

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

#### 3.5 Search: patient+category+status (SHALL)

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

#### 3.6 Search: patient+code+date (SHOULD)

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


## 4.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure)

**Description:** Verify support for the server capabilities required by the AU Core Blood Pressure.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 4.1 Search: patient+code (SHALL)

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

#### 4.2 Search: patient (SHALL)

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

#### 4.3 Search: patient+category (SHALL)

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

#### 4.4 Search: patient+category+date (SHALL)

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

#### 4.5 Search: patient+category+status (SHALL)

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

#### 4.6 Search: patient+code+date (SHOULD)

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


## 5.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight)

**Description:** Verify support for the server capabilities required by the AU Core Body Height.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 5.1 Search: patient+code (SHALL)

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

#### 5.2 Search: patient (SHALL)

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

#### 5.3 Search: patient+category (SHALL)

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

#### 5.4 Search: patient+category+date (SHALL)

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

#### 5.5 Search: patient+category+status (SHALL)

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

#### 5.6 Search: patient+code+date (SHOULD)

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


## 6.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path)

**Description:** Verify support for the server capabilities required by the AU Core Pathology Result Observation.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 6.1 Search: patient+code (SHALL)

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

#### 6.2 Search: patient (SHALL)

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

#### 6.3 Search: patient+category (SHALL)

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

#### 6.4 Search: patient+category+date (SHALL)

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

#### 6.5 Search: patient+category+status (SHALL)

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

#### 6.6 Search: patient+code+date (SHOULD)

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


## 7.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result)

**Description:** Verify support for the server capabilities required by the AU Core Lipid Result.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 7.1 Search: patient+code (SHALL)

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

#### 7.2 Search: patient (SHALL)

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

#### 7.3 Search: patient+category (SHALL)

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

#### 7.4 Search: patient+category+date (SHALL)

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

#### 7.5 Search: patient+category+status (SHALL)

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

#### 7.6 Search: patient+code+date (SHOULD)

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


## 8.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum)

**Description:** Verify support for the server capabilities required by the AU Core Head Circumference.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 8.1 Search: patient+code (SHALL)

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

#### 8.2 Search: patient (SHALL)

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

#### 8.3 Search: patient+category (SHALL)

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

#### 8.4 Search: patient+category+date (SHALL)

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

#### 8.5 Search: patient+category+status (SHALL)

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

#### 8.6 Search: patient+code+date (SHOULD)

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


## 9.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp)

**Description:** Verify support for the server capabilities required by the AU Core Body Temperature.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 9.1 Search: patient+code (SHALL)

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

#### 9.2 Search: patient (SHALL)

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

#### 9.3 Search: patient+category (SHALL)

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

#### 9.4 Search: patient+category+date (SHALL)

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

#### 9.5 Search: patient+category+status (SHALL)

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

#### 9.6 Search: patient+code+date (SHOULD)

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


## 10.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate)

**Description:** Verify support for the server capabilities required by the AU Core Heart Rate.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 10.1 Search: patient+code (SHALL)

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

#### 10.2 Search: patient (SHALL)

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

#### 10.3 Search: patient+category (SHALL)

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

#### 10.4 Search: patient+category+date (SHALL)

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

#### 10.5 Search: patient+category+status (SHALL)

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

#### 10.6 Search: patient+code+date (SHOULD)

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


## 11.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum)

**Description:** Verify support for the server capabilities required by the AU Core Waist Circumference.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 11.1 Search: patient+code (SHALL)

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

#### 11.2 Search: patient (SHALL)

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

#### 11.3 Search: patient+category (SHALL)

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

#### 11.4 Search: patient+category+date (SHALL)

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

#### 11.5 Search: patient+category+status (SHALL)

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

#### 11.6 Search: patient+code+date (SHOULD)

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


## 12.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel)

**Description:** Verify support for the server capabilities required by the AU Core Vitals Panel.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 12.1 Search: patient+code (SHALL)

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

#### 12.2 Search: patient (SHALL)

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

#### 12.3 Search: patient+category (SHALL)

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

#### 12.4 Search: patient+category+date (SHALL)

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

#### 12.5 Search: patient+category+status (SHALL)

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

#### 12.6 Search: patient+code+date (SHOULD)

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


## 13.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate)

**Description:** Verify support for the server capabilities required by the AU Core Respiration Rate.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 13.1 Search: patient+code (SHALL)

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

#### 13.2 Search: patient (SHALL)

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

#### 13.3 Search: patient+category (SHALL)

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

#### 13.4 Search: patient+category+date (SHALL)

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

#### 13.5 Search: patient+category+status (SHALL)

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

#### 13.6 Search: patient+code+date (SHOULD)

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


## 14.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag)

**Description:** Verify support for the server capabilities required by the AU Core Diagnostic Imaging Result Observation.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 14.1 Search: patient+code (SHALL)

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

#### 14.2 Search: patient (SHALL)

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

#### 14.3 Search: patient+category (SHALL)

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

#### 14.4 Search: patient+category+date (SHALL)

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

#### 14.5 Search: patient+category+status (SHALL)

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

#### 14.6 Search: patient+code+date (SHOULD)

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


## 15.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult)

**Description:** Verify support for the server capabilities required by the AU Core Diagnostic Result Observation.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 15.1 Search: patient+code (SHALL)

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

#### 15.2 Search: patient (SHALL)

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

#### 15.3 Search: patient+category (SHALL)

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

#### 15.4 Search: patient+category+date (SHALL)

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

#### 15.5 Search: patient+category+status (SHALL)

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

#### 15.6 Search: patient+code+date (SHOULD)

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


## 16.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth)

**Description:** Verify support for the server capabilities required by the AU Core Biological Sex Assigned at Birth.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 16.1 Search: patient+code (SHALL)

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

#### 16.2 Search: patient (SHALL)

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

#### 16.3 Search: patient+category (SHALL)

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

#### 16.4 Search: patient+category+date (SHALL)

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

#### 16.5 Search: patient+category+status (SHALL)

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

#### 16.6 Search: patient+code+date (SHOULD)

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


## 17.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus)

**Description:** Verify support for the server capabilities required by the AU Core Smoking Status.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 17.1 Search: patient+code (SHALL)

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

#### 17.2 Search: patient (SHALL)

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

#### 17.3 Search: patient+category (SHALL)

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

#### 17.4 Search: patient+category+date (SHALL)

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

#### 17.5 Search: patient+category+status (SHALL)

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

#### 17.6 Search: patient+code+date (SHOULD)

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


## 18.Patient

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)

**Description:** Verify support for the server capabilities required by the AU Core Patient.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 18.1 Search: _id (SHALL)

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

#### 18.2 Search: family (SHOULD)

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

#### 18.3 Search: identifier (SHALL)

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

#### 18.4 Search: name (SHOULD)

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

#### 18.5 Search: birthdate+family (SHOULD)

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

#### 18.6 Search: birthdate+name (SHOULD)

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

#### 18.7 Search: family+gender (SHOULD)

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

#### 18.8 Search: gender+name (SHOULD)

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


## 19.AllergyIntolerance

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance)

**Description:** Verify support for the server capabilities required by the AU Core AllergyIntolerance.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 19.1 Search: patient (SHALL)

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

#### 19.2 Search: patient+clinical-status (SHOULD)

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


## 20.Condition

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition)

**Description:** Verify support for the server capabilities required by the AU Core Condition.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 20.1 Search: patient (SHALL)

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

#### 20.2 Search: patient+category (SHALL)

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

#### 20.3 Search: patient+clinical-status (SHALL)

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

#### 20.4 Search: patient+category+clinical-status (SHOULD)

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

#### 20.5 Search: patient+code (SHOULD)

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

#### 20.6 Search: patient+onset-date (SHOULD)

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


## 21.DiagnosticReport

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport)

**Description:** Verify support for the server capabilities required by the AU Core DiagnosticReport.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 21.1 Search: patient (SHALL)

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

#### 21.2 Search: _id (SHALL)

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

#### 21.3 Search: identifier (SHALL)

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

#### 21.4 Search: patient+category (SHALL)

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

#### 21.5 Search: patient+category+date (SHALL)

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

#### 21.6 Search: patient+category+status (SHOULD)

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

#### 21.7 Search: patient+code (SHOULD)

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

#### 21.8 Search: patient+code+date (SHOULD)

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

#### 21.9 Search: patient+status (SHOULD)

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


## 22.DocumentReference

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference)

**Description:** Verify support for the server capabilities required by the AU Core DocumentReference.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 22.1 Search: patient (SHALL)

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

#### 22.2 Search: _id (SHALL)

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

#### 22.3 Search: identifier (SHALL)

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

#### 22.4 Search: patient+category (SHALL)

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

#### 22.5 Search: patient+category+date (SHALL)

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

#### 22.6 Search: patient+category+status (SHOULD)

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

#### 22.7 Search: patient+contenttype (SHOULD)

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

#### 22.8 Search: patient+status (SHOULD)

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

#### 22.9 Search: patient+type (SHOULD)

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

#### 22.10 Search: patient+type+date (SHOULD)

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


## 23.Encounter

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter)

**Description:** Verify support for the server capabilities required by the AU Core Encounter.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 23.1 Search: patient (SHALL)

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

#### 23.2 Search: date+patient (SHALL)

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

#### 23.3 Search: class+patient (SHOULD)

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

#### 23.4 Search: patient+location (SHOULD)

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

#### 23.5 Search: patient+status (SHOULD)

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

#### 23.6 Search: patient+type (SHOULD)

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


## 24.HealthcareService

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice)

**Description:** Verify support for the server capabilities required by the AU Core HealthcareService.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 24.1 Search: name (SHALL)

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

#### 24.2 Search: service-category (SHOULD)

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

#### 24.3 Search: identifier (SHOULD)

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

#### 24.4 Search: location (SHOULD)

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

#### 24.5 Search: organization (SHOULD)

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

#### 24.6 Search: specialty (SHOULD)

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

#### 24.7 Search: service-type (SHOULD)

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


## 25.Immunization

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization)

**Description:** Verify support for the server capabilities required by the AU Core Immunization.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 25.1 Search: patient (SHALL)

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

#### 25.2 Search: patient+status (SHALL)

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

#### 25.3 Search: patient+date (SHOULD)

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


## 26.Location

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location)

**Description:** Verify support for the server capabilities required by the AU Core Location.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 26.1 Search: address (SHALL)

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

#### 26.2 Search: name (SHALL)

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

#### 26.3 Search: address-city (SHOULD)

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

#### 26.4 Search: address-state (SHOULD)

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

#### 26.5 Search: address-postalcode (SHOULD)

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


## 27.Medication

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication)

**Description:** Verify support for the server capabilities required by the AU Core Medication.

### Interactions


* read (SHALL)

* search-type (MAY)


### Test scenarios



## 28.MedicationRequest

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest)

**Description:** Verify support for the server capabilities required by the AU Core MedicationRequest.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 28.1 Search: patient+intent (SHALL)

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

#### 28.2 Search: _id (SHALL)

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

#### 28.3 Search: identifier (SHALL)

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

#### 28.4 Search: patient (SHALL)

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

#### 28.5 Search: patient+intent+status (SHALL)

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

#### 28.6 Search: patient+intent+authoredon (SHALL)

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


## 29.MedicationStatement

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement)

**Description:** Verify support for the server capabilities required by the AU Core MedicationStatement.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 29.1 Search: patient (SHALL)

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

#### 29.2 Search: patient+status (SHALL)

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

#### 29.3 Search: patient+effective (SHOULD)

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


## 30.Observation

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation)

**Description:** Verify support for the server capabilities required by the AU Core Observation.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 30.1 Search: patient+code (SHALL)

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

#### 30.2 Search: patient (SHALL)

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

#### 30.3 Search: patient+category (SHALL)

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

#### 30.4 Search: patient+category+date (SHALL)

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

#### 30.5 Search: patient+category+status (SHALL)

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

#### 30.6 Search: patient+code+date (SHOULD)

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


## 31.Organization

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization)

**Description:** Verify support for the server capabilities required by the AU Core Organization.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 31.1 Search: address (SHALL)

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

#### 31.2 Search: identifier (SHALL)

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

#### 31.3 Search: name (SHALL)

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

#### 31.4 Search: _id (SHOULD)

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


## 32.Patient

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)

**Description:** Verify support for the server capabilities required by the AU Core Patient.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 32.1 Search: _id (SHALL)

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

#### 32.2 Search: family (SHOULD)

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

#### 32.3 Search: identifier (SHALL)

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

#### 32.4 Search: name (SHOULD)

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

#### 32.5 Search: birthdate+family (SHOULD)

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

#### 32.6 Search: birthdate+name (SHOULD)

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

#### 32.7 Search: family+gender (SHOULD)

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

#### 32.8 Search: gender+name (SHOULD)

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


## 33.Practitioner

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner)

**Description:** Verify support for the server capabilities required by the AU Core Practitioner.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 33.1 Search: _id (SHALL)

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

#### 33.2 Search: identifier (SHALL)

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

#### 33.3 Search: name (SHOULD)

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


## 34.PractitionerRole

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole)

**Description:** Verify support for the server capabilities required by the AU Core PractitionerRole.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 34.1 Search: _id (SHALL)

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

#### 34.2 Search: identifier (SHALL)

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

#### 34.3 Search: practitioner (SHALL)

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

#### 34.4 Search: specialty (SHOULD)

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


## 35.Procedure

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure)

**Description:** Verify support for the server capabilities required by the AU Core Procedure.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 35.1 Search: patient (SHALL)

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

#### 35.2 Search: patient+date (SHALL)

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

#### 35.3 Search: patient+code+date (SHOULD)

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

#### 35.4 Search: patient+status (SHOULD)

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


## 36.Provenance

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance)

**Description:** Verify support for the server capabilities required by the AU Core Provenance.

### Interactions


* read (SHALL)

* search-type (MAY)


### Test scenarios



## 37.ServiceRequest

[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest)

**Description:** Verify support for the server capabilities required by the AU Core ServiceRequest.

### Interactions


* read (SHALL)

* search-type (SHALL)


### Test scenarios


#### 37.1 Search: patient (SHALL)

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

#### 37.2 Search: _id (SHALL)

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

#### 37.3 Search: identifier (SHALL)

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

#### 37.4 Search: patient+category (SHALL)

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

#### 37.5 Search: patient+category+authored (SHALL)

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

#### 37.6 Search: patient+code (SHALL)

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

#### 37.7 Search: patient+category+status (SHOULD)

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

#### 37.8 Search: patient+code+authored (SHOULD)

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

#### 37.9 Search: patient+status (SHOULD)

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

