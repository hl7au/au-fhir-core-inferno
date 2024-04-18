# AU FHIR Core Inferno 🔥
This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit for the [AU Core Implementation Guide](http://hl7.org.au/fhir/core/)

**Currently available versions:**
1. [v0.3.0-ballot](http://hl7.org.au/fhir/core/0.3.0-ballot/)

## Use inferno as a service
You can test your FHIR server using this link https://inferno.hl7.org.au/

## Run inferno locally via Docker
It is highly recommended that you use Docker to run these tests. This test kit requires at least 10 GB of memory are available to Docker.
1. Clone this repo.
2. Run the setup script to initialize the database
```bash
make setup
```
3. Run project
```bash
make run
```
4. Navigate to http://localhost. The AU Core test suite will be available.

## How to Generate New Test Suites

If you visit http://hl7.org.au/fhir/core/history.html and notice that there is a new release, you can initiate the generation of test suites yourself. To accomplish this, you will need to take several steps:

1. Follow the link to the Generate Tests workflow (https://github.com/hl7au/au-fhir-core-inferno/actions/workflows/generate-tests.yaml).
2. A list of already completed pipelines will open. In the upper right corner, you will see the "Run Workflow" button. Click on it and confirm the launch.
3. The pipeline launch will be initiated. When it completes, a new Pull Request will be created with the changes. You can accept or reject it (https://github.com/hl7au/au-fhir-core-inferno/pulls)

## Additional information
1. [Pre-requisites](/docs/pre-requisites.md)
2. [Validator instructions](/docs/validator_instructions.md)
3. [Changelog](CHANGELOG.md)
