# Pre-requisites
## Test data
To pass tests demo data on the server should be consistent and valid according to the specification.

### Patient ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-patient.html))
1. Patients whose IDs are used as input should exist on the FHIR server.
2. At least one Provenance resource should exist there target is a patient.
3. Must support elements (MS) according to the specification should be filled.

### Observation
#### Body Weight Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodyweight.html))
1. At least one Provenance resource should exist there target is a body weight test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Blood Pressure Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bloodpressure.html))
1. At least one Provenance resource should exist there target is a blood pressure test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Body Height Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodyheight.html))
1. At least one Provenance resource should exist there target is a body height test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Pathology Result Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-diagnosticresult-path.html))
1. At least one Provenance resource should exist there target is a pathology result test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Body Temperature Test ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-bodytemp.html))
1. At least one Provenance resource should exist there target is a body temperature test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Heart Rate Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-heartrate.html))
1. At least one Provenance resource should exist there target is a heart rate test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Waist Circumference Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-waistcircum.html))
1. At least one Provenance resource should exist there target is a waist circumference test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Respiration Rate Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-resprate.html))
1. At least one Provenance resource should exist there target is a respiration rate test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Diagnostic Result Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-diagnosticresult.html))
1. At least one Provenance resource should exist there target is a smoking status test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
#### Smoking Status Tests ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-smokingstatus.html))
1. At least one Provenance resource should exist there target is a smoking status test that is related to the patient from the patient_ids input.
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### AllergyIntolerance ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-allergyintolerance.html))
1. At least one Provenance resource should exist there target is a allergy intolerance that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### Condition ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-condition.html))
1. At least one Provenance resource should exist there target is a allergy intolerance that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
4. Please use reference to the practitioner resource in the asserter attribute at least in one resource. It is necessary for the Practitioner test group.

### Encounter ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-encounter.html))
1. At least one Provenance resource should exist there target is a encounter that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
4. Please use reference to the organization resource in the serviceProvider attribute at least in one resource. It is necessary for the Organization test group.
### Immunization ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-immunization.html))
1. At least one Provenance resource should exist there target is a immunization that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### MedicationRequest ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-medicationrequest.html))
1. At least one Provenance resource should exist there target is a practitioner that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### MedicationStatement ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-medicationstatement.html))
1. At least one Provenance resource should exist there target is a medication statement that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### Procedure ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-procedure.html))
1. At least one Provenance resource should exist there target is a procedure that is related to the patient from the patient_ids input
2. Must support elements (MS) according to the specification should be filled.
3. All must-support references in the resource should be valid.
### Organization ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-organization.html))
1. At least one Provenance resource should exist there target.
2. Must support elements (MS) according to the specification should be filled.
3. The test group for this resource is not independent. It means that the test group can't run by itself and it depends on the data from another test group. (see Encounter description)
### Practitioner ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-practitioner.html))
1. Must support elements (MS) according to the specification should be filled.
2. All must-support references in the resource should be valid.
3. The test group for this resource is not independent. It means that the test group can't run by itself and it depends on the data from another test group. (See conditions description)
### Provenance ([StructureDefinition](https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-provenance.html))
1. Must support elements (MS) according to the specification should be filled.
2. All must-support references in the resource should be valid.
3. The test group for this resource is not independent. It means that the test group can't run by itself and it depends on the data from another test group.