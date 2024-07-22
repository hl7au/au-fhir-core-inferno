# Pre-requisites and Test Suite dependencies
## Test Data Pre-requisites

**For ALL test groups/suites on Profiles:**
* Each *Must Support* element/reference is populated in at least one resource from the set of resources being tested. In other words, the set of resources being tested has coverage of the *Must Support* elements; otherwise the test will be skipped.

## Additional Pre-requisites and Test Suite Dependencies

**If running all tests, please note the following additional pre-requisites due to dependecies between test suites:**

* ### Condition
    * Use a reference to the **Practitioner** resource in the **asserter** attribute in at least one resource. This is necessary for the **Practitioner** test group.

* ### Encounter
    * Use a reference to the **Organization** resource in the **serviceProvider** attribute in at least one resource. This is necessary for the **Organization** test group.
    * Use a reference to the **Location** resource in the **location** attribute in at least one resource. This is necessary for the **Location** test group.

* ### MedicationRequest
    * Use a reference to the **PractitionerRole** resource in the **requester** attribute in at least one resource. This is necessary for the **PractitionerRole** test group.

***

**Test groups/suites you can run independently to avoid the dependencies:**

  You can run the following test groups separately and provide the resource IDs in the input field:
* Patient
* Location
* Organization
* Practitioner
* PractitionerRole
