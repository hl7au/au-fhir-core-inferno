# Capabilities by Resource/Profile

## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi)
**Description:** Verify support for the server capabilities required by the AU Core BMI.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight)
**Description:** Verify support for the server capabilities required by the AU Core Body Weight.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat)
**Description:** Verify support for the server capabilities required by the AU Core Oxygen Saturation.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure)
**Description:** Verify support for the server capabilities required by the AU Core Blood Pressure.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight)
**Description:** Verify support for the server capabilities required by the AU Core Body Height.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path)
**Description:** Verify support for the server capabilities required by the AU Core Pathology Result Observation.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result)
**Description:** Verify support for the server capabilities required by the AU Core Lipid Result.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum)
**Description:** Verify support for the server capabilities required by the AU Core Head Circumference.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp)
**Description:** Verify support for the server capabilities required by the AU Core Body Temperature.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate)
**Description:** Verify support for the server capabilities required by the AU Core Heart Rate.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum)
**Description:** Verify support for the server capabilities required by the AU Core Waist Circumference.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel)
**Description:** Verify support for the server capabilities required by the AU Core Vitals Panel.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate)
**Description:** Verify support for the server capabilities required by the AU Core Respiration Rate.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag)
**Description:** Verify support for the server capabilities required by the AU Core Diagnostic Imaging Result Observation.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult)
**Description:** Verify support for the server capabilities required by the AU Core Diagnostic Result Observation.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth)
**Description:** Verify support for the server capabilities required by the AU Core Biological Sex Assigned at Birth.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus)
**Description:** Verify support for the server capabilities required by the AU Core Smoking Status.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Patient
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)
**Description:** Verify support for the server capabilities required by the AU Core Patient.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* _id (SHALL)
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

* family (SHOULD)
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

* identifier (SHALL)
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

* name (SHOULD)
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

* birthdate+family (SHOULD)
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

* birthdate+name (SHOULD)
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

* family+gender (SHOULD)
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

* gender+name (SHOULD)
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


## AllergyIntolerance
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance)
**Description:** Verify support for the server capabilities required by the AU Core AllergyIntolerance.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* patient+clinical-status (SHOULD)
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


## Condition
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition)
**Description:** Verify support for the server capabilities required by the AU Core Condition.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+clinical-status (SHALL)
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

* patient+category+clinical-status (SHOULD)
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

* patient+code (SHOULD)
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

* patient+onset-date (SHOULD)
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


## DiagnosticReport
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport)
**Description:** Verify support for the server capabilities required by the AU Core DiagnosticReport.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* _id (SHALL)
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

* identifier (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHOULD)
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

* patient+code (SHOULD)
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

* patient+code+date (SHOULD)
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

* patient+status (SHOULD)
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


## DocumentReference
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference)
**Description:** Verify support for the server capabilities required by the AU Core DocumentReference.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* _id (SHALL)
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

* identifier (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHOULD)
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

* patient+contenttype (SHOULD)
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

* patient+status (SHOULD)
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

* patient+type (SHOULD)
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

* patient+type+date (SHOULD)
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


## Encounter
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter)
**Description:** Verify support for the server capabilities required by the AU Core Encounter.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* date+patient (SHALL)
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

* class+patient (SHOULD)
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

* patient+location (SHOULD)
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

* patient+status (SHOULD)
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

* patient+type (SHOULD)
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


## HealthcareService
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice)
**Description:** Verify support for the server capabilities required by the AU Core HealthcareService.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* name (SHALL)
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

* service-category (SHOULD)
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

* identifier (SHOULD)
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

* location (SHOULD)
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

* organization (SHOULD)
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

* specialty (SHOULD)
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

* service-type (SHOULD)
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


## Immunization
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization)
**Description:** Verify support for the server capabilities required by the AU Core Immunization.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* patient+status (SHALL)
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

* patient+date (SHOULD)
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


## Location
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location)
**Description:** Verify support for the server capabilities required by the AU Core Location.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* address (SHALL)
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

* name (SHALL)
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

* address-city (SHOULD)
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

* address-state (SHOULD)
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

* address-postalcode (SHOULD)
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


## Medication
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication)
**Description:** Verify support for the server capabilities required by the AU Core Medication.
### Interactions

* read (SHALL)

* search-type (MAY)

### Test scenarios


## MedicationRequest
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest)
**Description:** Verify support for the server capabilities required by the AU Core MedicationRequest.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+intent (SHALL)
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

* _id (SHALL)
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

* identifier (SHALL)
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

* patient (SHALL)
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

* patient+intent+status (SHALL)
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

* patient+intent+authoredon (SHALL)
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


## MedicationStatement
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement)
**Description:** Verify support for the server capabilities required by the AU Core MedicationStatement.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* patient+status (SHALL)
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

* patient+effective (SHOULD)
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


## Observation
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation)
**Description:** Verify support for the server capabilities required by the AU Core Observation.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient+code (SHALL)
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

* patient (SHALL)
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

* patient+category (SHALL)
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

* patient+category+date (SHALL)
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

* patient+category+status (SHALL)
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

* patient+code+date (SHOULD)
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


## Organization
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization)
**Description:** Verify support for the server capabilities required by the AU Core Organization.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* address (SHALL)
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

* identifier (SHALL)
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

* name (SHALL)
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

* _id (SHOULD)
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


## Patient
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient)
**Description:** Verify support for the server capabilities required by the AU Core Patient.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* _id (SHALL)
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

* family (SHOULD)
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

* identifier (SHALL)
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

* name (SHOULD)
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

* birthdate+family (SHOULD)
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

* birthdate+name (SHOULD)
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

* family+gender (SHOULD)
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

* gender+name (SHOULD)
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


## Practitioner
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner)
**Description:** Verify support for the server capabilities required by the AU Core Practitioner.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* _id (SHALL)
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

* identifier (SHALL)
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

* name (SHOULD)
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


## PractitionerRole
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole)
**Description:** Verify support for the server capabilities required by the AU Core PractitionerRole.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* _id (SHALL)
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

* identifier (SHALL)
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

* practitioner (SHALL)
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

* specialty (SHOULD)
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


## Procedure
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure)
**Description:** Verify support for the server capabilities required by the AU Core Procedure.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* patient+date (SHALL)
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

* patient+code+date (SHOULD)
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

* patient+status (SHOULD)
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


## Provenance
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance)
**Description:** Verify support for the server capabilities required by the AU Core Provenance.
### Interactions

* read (SHALL)

* search-type (MAY)

### Test scenarios


## ServiceRequest
[Profile](http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest)
**Description:** Verify support for the server capabilities required by the AU Core ServiceRequest.
### Interactions

* read (SHALL)

* search-type (SHALL)

### Test scenarios

* patient (SHALL)
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

* _id (SHALL)
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

* identifier (SHALL)
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

* patient+category (SHALL)
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

* patient+category+authored (SHALL)
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

* patient+code (SHALL)
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

* patient+category+status (SHOULD)
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

* patient+code+authored (SHOULD)
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

* patient+status (SHOULD)
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

