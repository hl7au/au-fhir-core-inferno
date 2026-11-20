# AU FHIR Core Inferno 🔥 [![Gem Version](https://badge.fury.io/rb/au_core_test_kit.svg)](https://badge.fury.io/rb/au_core_test_kit)

This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit for the [AU Core Implementation Guide](http://hl7.org.au/fhir/core/)

**Currently available versions:**
1. [v1.0.0](https://hl7.org.au/fhir/core/1.0.0)
2. [v2.0.0](https://hl7.org.au/fhir/core/2.0.0)

## Use Inferno as a service
You can test your FHIR server using this link [https://inferno.hl7.org.au/test-kits/au-core](https://inferno.hl7.org.au/test-kits/au-core/)

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
When you change the source code of the generator and create a pull request, you SHALL NOT add generated tests in this pull request.
Once the code review is done, a person who merged the changes SHALL run the generator and update generated tests.
It may be a direct commit to the master branch. 

## Tests

`make tests` runs every spec in Docker. The specs check the kit in three layers.

| Layer | What it checks | Run it on its own |
|---|---|---|
| Suite Rules | Each generated suite against its IG package and config: a group for every CapabilityStatement resource with an interaction, a read and search test for every interaction and search parameter, the validator's IG version, and the FHIRPath Lab wiring. | `docker compose run --rm -e APP_ENV=test inferno bundle exec rspec spec/au_core` |
| Regeneration drift | The committed suites under `lib/au_core_test_kit/generated` equal a fresh `make generate`. | `make generate`, then `git status lib/au_core_test_kit/generated` must show no change |
| Scenarios | Each shipped suite runs against [fhir_stub_server](https://github.com/projkov/fhir_stub_server), which stands in for both the FHIR server and the validator. Every test must get its expected result. | `docker compose run --rm -e APP_ENV=test inferno bundle exec rspec spec/integration/scenarios_spec.rb` |

### Scenarios

A Scenario is one `spec/fixtures/stub_server/<name>/scenario.yml`. `spec/integration/scenarios_spec.rb` runs each Scenario twice, in the rspec process and through `inferno execute`. Each run fails when:

- the Stub gets a request it has no answer for;
- the validator is called with a different context than `expected_context`;
- any test's result differs from `expected`;
- the two runs disagree.

The file has these keys:

| Key | Meaning |
|---|---|
| `suite_id` | The suite to run, e.g. `au_core_v300_ballot1`. |
| `groups` | Ids of the suite's groups to run, in order. They run as one test run, so a later group sees what earlier ones saved, as in a whole-suite run. List the Patient group before groups whose chained searches use its patients. |
| `inputs` | Suite inputs other than `url`, which each run sets to the Stub. |
| `expected` | Every test's short id (its id without the group prefix) with `pass`, `fail`, `skip`, `omit` or `error`. Each suite's Scenario has at least one expected `fail`, so the Scenario proves it can catch one. |
| `server` | The Stub's config: Demo Data `sources` (the kit's `lib/au_core_test_kit/igs/*.tgz`), FHIR `pairs`, validator `pairs` and `expected_context`. The format is in the gem's [README](https://github.com/projkov/fhir_stub_server#config). Its "Working with LLM agents" section covers the update loop. |

`.env.test` points the validator at the Stub (`FHIR_RESOURCE_VALIDATOR_URL`). It also turns the TLS test off (`INFERNO_DISABLE_TLS_TEST`), because that test opens a real TLS connection, which no Stub can answer. The TLS test is therefore expected to `omit`.

### When a generator or kit change alters a request

An unmatched request fails the run on purpose: that is how a changed request gets noticed. The failure lists one line per request the Stub could not answer, with the nearest Pair, how the request differs from it, and the request to paste:

```text
Unmatched fhir GET /Patient?family=Wang; nearest fhir.pairs[6]: birthdate expected ["gt1975-05-02"], got nil; request: {"path":"/Patient","query":{"family":"Wang"}}
```

1. Decide whether the kit meant to send that request. If it didn't, fix the kit, not the Scenario.
2. If it did, paste the JSON after `request:` into `server.fhir.pairs` as a new Pair. Then write a response that states the search's criterion in FHIRPath over the IG examples, rather than naming one resource:

   ```yaml
   - request: {"path":"/Patient","query":{"family":"Wang"}}
     response: { select: "Bundle.entry.resource.ofType(Patient).where(name.where(family.lower().startsWith('wang')).exists())" }
   ```

   Quote dates and numbers in the YAML (`birthdate: '1975-05-03'`). A validator miss ends with `pair: {...}` instead: paste it into `server.validator.pairs` and add `issues`.
3. Rerun until every request is answered. Then update `expected` for any test whose result changed on purpose.

To point Inferno's UI at one Scenario while debugging:

```bash
bundle exec fhir-stub-server spec/fixtures/stub_server/<name>/scenario.yml
```

It prints the FHIR and validator base URLs and logs every request it can't answer. Start Inferno with `FHIR_RESOURCE_VALIDATOR_URL` set to the validator URL if the Stub should answer validation too.

## Release management
When we would like to issue a new release, you need to update the application version in this file https://github.com/hl7au/au-fhir-core-inferno/blob/master/lib/au_core_test_kit/version.rb
Then you need to create a tag for this version. The tag name should start with `v` and then contain a numeric version like this `v0.0.1`
Once a tag is created, you need to create a GitHub release for this newly published version.
The release creation triggers the pipeline that deploys a new version to the cloud environment.

## Contributing to Inferno and Reporting Issues

1. Discuss an issue in chat.fhir.org
If you have a question, feature request, or proposed change, the best place to start is Zulip i.e. the https://chat.fhir.org/#narrow/stream/179173-australia/topic/Inferno.20Test.20Kit.20feedback.20and.20queries

If you're unable to find an open request, please create a GitHub to:
contribute Test suites or Code to the repository: state your details and the nature of the changes to be contributed
suggest improvements or enhancements to the project

We appreciate your contributions to improving this test suite. **If you encounter any issues or have suggestions for enhancements, please follow the steps below to report them**:

For feedback about a specific hosted test run, use the
[Inferno feedback form](https://inferno.hl7.org.au/feedback/), which can publish
a reviewed report without GitHub sign-in. For kit bugs and test requests, choose
the matching [repository issue form](https://github.com/hl7au/au-fhir-core-inferno/issues/new/choose).

1. **Search for Existing Issues**:
Before submitting a new issue, please check the [Issues section](https://github.com/hl7au/au-fhir-core-inferno/issues) to see if the problem or suggestion has already been reported. If you find an existing issue, you can add your comments or additional information to it.
2. **Open a New Issue:**
If you do not find a similar issue, you can open a [new one](https://github.com/hl7au/au-fhir-core-inferno/issues/new). Click on the New Issue button and provide details, e.g., for a bug report:
```
Title: A brief and descriptive title for the issue.
Description: A detailed description of the issue, including:
1. Steps to reproduce the issue.
2. Expected and actual behavior.
3. Screenshots or another related information (if applicable).
```
3. **Labeling:**
Help us categorize the issue by adding relevant labels (e.g., bug, enhancement, question). This helps us prioritize and address the issues more efficiently.

#### Resolving Issues
To support effective issue resolution, reporters may be engaged in the review process to help confirm that resolutions address their concerns. This can involve notifying the reporter when a fix is implemented and inviting them to validate the solution or provide feedback before the issue is formally closed.

#### Questions?
In addition to reporting issues on GitHub, you can also ask questions or report issues on Zulip (chat.fhir.org).
- Specific topic for HL7 AU Inferno Test Kit feedback and queries: [australia > Inferno Test Kit feedback and queries](https://chat.fhir.org/#narrow/channel/179173-australia/topic/Inferno.20Test.20Kit.20feedback.20and.20queries)
- General: [Inferno channel](https://chat.fhir.org/#narrow/channel/179309-inferno)

## How to Contribute to the HL7 AU Inferno AU Core Test Kit
If you would like to contribute to **hl7au/au-fhir-core-inferno**, here’s how:

### 1. Communicate Before You Start
- Open a [GitHub issue](https://github.com/hl7au/au-fhir-core-inferno/issues) to discuss your plans to help avoid duplication of effort, align and prioritise your contributions.
- Join the fortnightly HL7 AU Infrastructure and Tooling Community Meetings ([register here](https://confluence.hl7.org/display/HAFWG/Infrastructure+and+Tooling+Contact+List)) where we discuss and triage issues. Feel free to add your issue to the [meeting agenda](https://confluence.hl7.org/pages/viewpage.action?pageId=265492851#CommunityMeetingAgendaandMinutes-MeetingDetails) and we'll aim to discuss your issue/ proposed contribution when you are present at the meeting.
- Use Zulip to connect with the team and community asynchronously: 
  - Specific topic for HL7 AU Inferno Test Kit feedback and queries: [australia > Inferno Test Kit feedback and queries](https://chat.fhir.org/#narrow/channel/179173-australia/topic/Inferno.20Test.20Kit.20feedback.20and.20queries)
  - General: [Inferno channel](https://chat.fhir.org/#narrow/channel/179309-inferno)

### 2. Contribute Code
1. Fork this repository.
2. Create a branch and use the GitHub issue number followed by a meaningful description as the branch name for your contribution.
3. Make your contributions/ changes. Please DO NOT add generated tests as instructed in the [Development Workflow](https://github.com/hl7au/au-fhir-core-inferno?tab=readme-ov-file#development-workflow) section of this README.
4. Submit a pull request (PR) for review.
5. Once the PR has been reviewed, feedback addressed collaboratively, and approved (by the designated HL7 AU project facilitator or their delegate - refer to the [HL7 AU Project Registry](https://confluence.hl7.org/display/HA/HL7+Australia+Project+Registry)), it may be merged into the main branch.

## Additional information
1. [Pre-requisites](/docs/pre-requisites.md)
2. [Validator instructions](/docs/validator_instructions.md)
3. [Changelog](CHANGELOG.md)
4. [AU Inferno Test Coverage](https://github.com/beda-software/au-inferno-test-coverage): A work-in-progress repository containing text, code, and resources focused on addressing the challenge of achieving IG coverage through Inferno tests. 
