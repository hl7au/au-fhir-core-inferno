# Pre-requisites
## Test Data
To pass tests, the demo data on the server should be consistent and valid according to the specifications.

**For all test groups/suites on Profiles:**
* Each *Must Support* element/reference is populated in at least one resource from the set of resources being tested. In other words, the set of resources being tested has coverage of the Must Support elements; otherwise the test will be failed.

**You can test a specific resource with these test groups by running them separately and using the ID's input field:**
* Patient
* Location
* Organization
* Practitioner
* PractitionerRole

### Patient
* Patients whose IDs are used as input shall exist on the FHIR server.

### Condition
* Use a reference to the **Practitioner** resource in the **asserter** attribute in at least one resource. This is necessary for the **Practitioner** test group.

### Encounter
* Use a reference to the **Organization** resource in the **serviceProvider** attribute in at least one resource. This is necessary for the **Organization** test group.
* Use a reference to the **Location** resource in the **location** attribute in at least one resource. This is necessary for the **Location** test group.

### MedicationRequest
* Use a reference to the **PractitionerRole** resource in the **requester** attribute in at least one resource. This is necessary for the **PractitionerRole** test group.
