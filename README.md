# AU FHIR Core Inferno 🔥
This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit for the [AU Core Implementation Guide](http://hl7.org.au/fhir/core/)

**Currently available versions:**
1. [v0.3.0-ballot](http://hl7.org.au/fhir/core/0.3.0-ballot/)
2. [v0.4.0-preview](http://hl7.org.au/fhir/core/0.4.0-preview/)

## Use Inferno as a service
You can test your FHIR server using this link https://inferno.hl7.org.au/

## Run Inferno locally via Docker
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

### The algorithm of the pipeline is as follows:

1. The script will visit the releases history page;
2. It will download all archives and store them in the igs folder;
3. The generator will generate test groups for each IG archive;
4. If there are any new test groups, they will be added to the project automatically;
5. If there are any changes, the action will create a pull request.

## Development workflow
This repository contains both the source code of the tests generator and the generated tests themselves.
Even a small change in the generator source causes a huge amount of changes in the generated tests.
As a result, when a pull request contains both changes in the generator and changes in the generated files,
it is almost impossible to review. 
Furthermore, there is no sense in reviewing the generated files at all, they are just artifacts that this repo produces.
They are placed in the same repo under source control just for simplicity reasons.
So, the development process should look like this.
When you change the source code of the generator and create a pull request, you SHALL not add generated tests in this pull request.
Once the code review is done a person who merged the changes SHALL run the generator and update generated tests.
It may be a direct commit to the master branch. 

## Release management
When we would like to issue a new release, you need to update the application version in this file https://github.com/hl7au/au-fhir-core-inferno/blob/master/lib/au_core_test_kit/version.rb
Then you need to create a tag for this version. The tag name should start with `v` and then contain a numeric version like this `v0.0.1`
Once a tag is created, you need to create a GitHub release for this newly published version.
The release creation triggers the pipeline that deploys a new version to the cloud environment.

## Reporting Issues

We appreciate your contributions to improving this test suite. **If you encounter any issues or have suggestions for enhancements, please follow the steps below to report them**:

1. **Search for Existing Issues**:
Before submitting a new issue, please check the [Issues section](https://github.com/hl7au/au-fhir-core-inferno/issues) to see if the problem or suggestion has already been reported. If you find an existing issue, you can add your comments or additional information to it.
2. **Open a New Issue:**
If you do not find a similar issue, you can open a [new one](https://github.com/hl7au/au-fhir-core-inferno/issues/new). Click on the New Issue button and provide the following details:
```
Title: A brief and descriptive title for the issue.
Description: A detailed description of the issue, including:
1. Steps to reproduce the issue.
2. Expected and actual behavior.
3. Screenshots or another related information (if applicable).
```
3. **Labeling:**
Help us categorize the issue by adding relevant labels (e.g., bug, enhancement, question). This helps us prioritize and address the issues more efficiently.

In addition to reporting issues on GitHub, you can also ask questions or report problems through our Zulip channel. Join the conversation [here](https://chat.fhir.org/#narrow/stream/179173-australia/topic/AU.20Core.20Testing).

## Additional information
1. [Pre-requisites](/docs/pre-requisites.md)
2. [Validator instructions](/docs/validator_instructions.md)
3. [Changelog](CHANGELOG.md)
