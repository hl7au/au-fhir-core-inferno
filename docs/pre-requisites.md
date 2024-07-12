# Pre-requisites
## Test data
To pass tests demo data on the server should be consistent and valid according to the specification.
### 1. CapabilityStatement
### 2. Patient ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-patient.html))
* Patients whose IDs are used as input should exist on the FHIR server.
* Must support elements (MS) according to the specification should be filled.
### Observation
#### 3. Body Weight ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodyweight.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 4. Blood Pressure ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bloodpressure.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 5. Body Height ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodyheight.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 6. Pathology Result ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-diagnosticresult-path.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 7. Body Temperature  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodytemp.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 8. Heart Rate  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-heartrate.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 9. Waist Circumference  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-waistcircum.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 10. Respiration Rate  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-resprate.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 11. Diagnostic Result  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-diagnosticresult.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
#### 12. Smoking Status  ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-smokingstatus.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
### 13. AllergyIntolerance ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-allergyintolerance.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
### 14. Condition ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-condition.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
* Please use reference to the practitioner resource in the asserter attribute at least in one resource. It is necessary for the Practitioner test group.

### 15. Encounter ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-encounter.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
* Please use reference to the organization resource in the serviceProvider attribute at least in one resource. It is necessary for the Organization test group.
* Please use reference to the Location resource in the location attribute at least in one resource. It is necessary for the Location test group.
### 16. Immunization ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-immunization.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
### 17. MedicationRequest ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-medicationrequest.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
* Please use reference to the PractitionerRole resource in the requester attribute at least in one resource. It is necessary for the PractitionerRole test group.
### 18. Procedure ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-procedure.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
### 19. Location ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-location.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
* You can test a specific resource with this test group by running it separately and using the ID's input field.
* If you run all test groups, the result for this group will depend on the data from the previous test groups. (see Encounter description)
### 20. Organization ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-organization.html))
* Must support elements (MS) according to the specification should be filled.
* If you run all test groups, the result for this group will depend on the data from the previous test groups. (see Encounter description)
* You can test a specific resource with this test group by running it separately and using the ID's input field.
### 21. Practitioner ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-practitioner.html))
* All must-support references in the resource should be valid.
* If you run all test groups, the result for this group will depend on the data from the previous test groups. (See conditions description)
* You can test a specific resource with this test group by running it separately and using the ID's input field.
### 22. PractitionerRole ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-practitionerrole.html))
* Must support elements (MS) according to the specification should be filled.
* All must-support references in the resource should be valid.
* You can test a specific resource with this test group by running it separately and using the ID's input field.
* If you run all test groups, the result for this group will depend on the data from the previous test groups. (See MedicationRequest description)

