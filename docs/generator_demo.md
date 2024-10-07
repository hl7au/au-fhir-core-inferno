# The AU Core Inferno Generator demo
## The step-by-step guide

* Create a new folder for the demo.
```bash
mkdir au-core-demo
```

* Navigate to the new folder.
```bash
cd au-core-demo
```

* Clone the AU Core IG repository via Git.
```bash
git clone git@github.com:hl7au/au-fhir-core.git
```
* Clone the AU FHIR Core Inferno repository via Git.
```bash
git clone git@github.com:hl7au/au-fhir-core-inferno.git
```
* Download the latest release of the IG Publisher software.
```bash
curl -L -o publisher.jar https://github.com/HL7/fhir-ig-publisher/releases/download/1.6.28/publisher.jar
```
* Generate the original IG archive using the IG Publisher software.
```bash
java -jar publisher.jar au-fhir-core/ig.ini
```
* Remove all previously generated test suites and existing IG files from the AU FHIR Core Inferno folder.
```bash
rm -rf au-fhir-core-inferno/lib/au_core_test_kit/generated/
rm au-fhir-core-inferno/lib/au_core_test_kit/igs/*.tgz
```
* Move the generated package.tgz file to the AU FHIR Core Inferno folder.
```bash
cp au-fhir-core/output/package.tgz au-fhir-core-inferno/lib/au_core_test_kit/igs/
```
* Now, you can generate a test suite.
```bash
cd au-fhir-core-inferno/
make setup
make generate
```
* In file lib/au-core-test-kit.rb you need to comment **require_relative 'au_core_test_kit/generated/v1.0.0-ballot/au_core_test_suite'** and uncomment **require_relative 'au_core_test_kit/generated/v1.0.0-ci-build/au_core_test_suite'**
* Run the project.
```bash
make run
```
* Go to the http://localhost and check the result
* Make changes to the IG using the prepared file.
    * Let's change expectation for family parameter for Patient resource from SHOULD to SHALL.
    * Let's change expectation for combo parameter birthdate + name for Patient resource from SHOULD to MAY.
* Generate a new IG package.tgz file.
* Move the files to the AU FHIR Core Inferno folder.
* Run the project.