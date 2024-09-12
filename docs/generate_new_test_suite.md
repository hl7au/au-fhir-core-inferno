# How to Generate New Test Suites

## Steps

If you visit http://hl7.org.au/fhir/core/history.html and notice that there is a new release, you can initiate the generation of test suites yourself. To accomplish this, you will need to take several steps:

1. Follow the link to the Generate Tests workflow (https://github.com/hl7au/au-fhir-core-inferno/actions/workflows/generate-tests.yaml).
2. A list of already completed pipelines will open. In the upper right corner, you will see the "Run Workflow" button. Click on it and confirm the launch.
3. The pipeline launch will be initiated. When it completes, a new Pull Request will be created with the changes. You can accept or reject it (https://github.com/hl7au/au-fhir-core-inferno/pulls)

## The algorithm of the pipeline is as follows:

1. The script will visit the releases history page;
2. It will download all archives and store them in the igs folder;
3. The generator will generate test groups for each IG archive;
4. If there are any new test groups, they will be added to the project automatically;
5. If there are any changes, the action will create a pull request.

## Required FHIR IG artifacts
The generator will extract the .zip file of the IG and attempt to upload all JSON files that are FHIR entries. Given the current state of the test suite, the required files are:

* CapabilityStatement responder
* All StructureDefinition files
* SearchParam

In some cases, the required resources may be missing from the IG. To address this, the following static files have been added:

* au-base-resources.json
* search-params.json

Content from these files will only be used when the corresponding content is not available in the IG files.

## Additional documentation

* [Pre-requisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md)
* [US Core diffs](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/us_core_diffs.md)
* [Validator instructions](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/validator_instructions.md)


## Validation of test suites

* Manual functional testing to verify:
    1. Generated tests accurately reflect the conformance requirements of the Implementation Guide (IG), and
    2. Inferno tests behave as expected by validating test data inputs, outputs (comparing actual (reported) results against the expected results), and evaluating the interactions with different components (FHIR validator, Terminology Server, and target FHIR Server) to confirm the test is fit-for-purpose.
* Regression testing: run tests to detect any regressions or unintended changes in functionality after updates.
