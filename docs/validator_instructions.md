# Step-by-Step Guide to Using the FHIR Resources Validator

The validator is available at this [link](https://validator.fhir.org/).

1. Open the Validator UI.
![Open the Validator UI](/docs/assets/1_empty_validator.png "Open the Validator UI")
2. Paste the FHIR resource into the validator window.
![Paste the FHIR resource into the validator window](/docs/assets/2_validator_with_resource.png "Paste the FHIR resource into the validator window")
3. In the Options tab, select the Implementation Guide.
![In the Options tab, select the Implementation Guide](/docs/assets/3_select_ig.png "In the Options tab, select the Implementation Guide")
4. Choose the specific version of the Implementation Guide.
![Choose the specific version of the Implementation Guide](/docs/assets/4_select_ig_version.png "Choose the specific version of the Implementation Guide")
5. Click the "Add" button.
![Click the "Add" button](/docs/assets/5_select_ig_click_add.png "Click the 'Add' button")
6. The Implementation Guide with the selected version should now be active.
![The Implementation Guide with the selected version should now be active](/docs/assets/6_selected_ig.png "The Implementation Guide with the selected version should now be active")
7. Set up the terminology server. You can use https://tx.dev.hl7.org.au/fhir. Then click "Verify."
![Set up the terminology server. You can use https://tx.dev.hl7.org.au/fhir. Then click "Verify"](/docs/assets/7_set_terminology_server.png "Set up the terminology server. You can use https://tx.dev.hl7.org.au/fhir. Then click 'Verify'")
8. The terminology server should now be verified.
![The terminology server should now be verified](/docs/assets/8_terminology_server_verified.png "The terminology server should now be verified")
9. Return to the Validate tab and click the "Validate" button.
![Return to the Validate tab and click the "Validate" button](/docs/assets/9_validator_validate.png "Return to the Validate tab and click the 'Validate' button")
10. The validation results will be displayed.
![The validation results will be displayed](/docs/assets/10_validator_result.png "The validation results will be displayed")
