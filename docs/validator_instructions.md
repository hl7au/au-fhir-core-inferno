# Step-by-Step Guide to Using the FHIR Resources Validator

This is a special Test Kit that provides a comfortable user experience for FHIR resource validation.

The implementation guide, version, and terminology server are already configured; you just need to paste your FHIR resource in JSON format and run the Test Kit.

* The implementation guide is **hl7.fhir.au.core**
* The implementation guide version is **1.0.0-ballot**
* The TX server is **https://tx.dev.hl7.org.au/fhir**
* The official HL7 validator fhirCore version is: **6.3.11**

1. In the suites list, select the **Validation Test Suite**.
![In the suites list, select the Validation Test Suite](/docs/assets/1_select_test_suite.png "In the suites list, select the Validation Test Suite")
2. To run the validation, click the **RUN ALL TESTS** button.
![To run the validation, click the RUN ALL TESTS button](/docs/assets/2_click_run_all_tests.png "To run the validation, click the RUN ALL TESTS button")
3. A modal window will appear with an empty field for the resource data.
![A modal window will appear with an empty field for the resource data](/docs/assets/3_empty_modal_window.png "A modal window will appear with an empty field for the resource data")
4. Paste the resource data in JSON format, then click the **SUBMIT** button.
![Paste the resource data in JSON format, then click the SUBMIT button](/docs/assets/4_paste_resource.png "Paste the resource data in JSON format, then click the SUBMIT button")
5. The modal window will close, and a progress bar will appear at the bottom right corner of the application.
![The modal window will close, and a progress bar will appear at the bottom right corner of the application](/docs/assets/5_wait_for_the_result.png "The modal window will close, and a progress bar will appear at the bottom right corner of the application")
6. When the validation is complete, the progress bar will disappear, and a success icon will be displayed.
![When the validation is complete, the progress bar will disappear, and a success icon will be displayed](/docs/assets/6_result.png "When the validation is complete, the progress bar will disappear, and a success icon will be displayed")
7. By clicking on the test, you can view all the information about the resource validation.
![By clicking on the test, you can view all the information about the resource validation](/docs/assets/7_check_details.png "By clicking on the test, you can view all the information about the resource validation")
