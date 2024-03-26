# AU FHIR Core Inferno 🔥
This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit for the AU Core Implementation Guide [v0.3.0-ballot](http://hl7.org.au/fhir/core/0.3.0-ballot/)

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

## Additional information
1. [Pre-requisites](/docs/pre-requisites.md)
2. [Validator instructions](/docs/validator_instructions.md)