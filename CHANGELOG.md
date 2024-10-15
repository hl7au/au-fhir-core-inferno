# 0.0.15
* Add conditional/basic skip with a message by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/209
* Update _include tests by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/212
* Add separate _include tests by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/217

# 0.0.14
## AU Core Test Kit changes
* Update target_profile modification for au-specimen by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/194
* Add missing data tests by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/195
* Add validator messages filter by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/202
## Documentation
* Update us_core_diffs.md by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/198
## Other
* remove old manifest implementation and update ngnix dependency by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/188

# 0.0.13
## AU Core Test Kit changes
* AU Core 1.0.0-preview

# 0.0.12
## AU Core Test Kit changes
* Add auto _count search parameter by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/184
* Add an ability to activate read for first _id search automatically by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/183
* Update description for the CapabilityStatement group by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/182
* Update group description for Practitioner, PractitionerRole, Location, and Organization by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/181

# 0.0.11
## AU Core Test Kit changes
* Update 0.4.0-preview to 0.4.1-preview by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/171
* Use gem as validation test suite by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/168
* Add an ability to run the first search for Patient as read test by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/174
* Add optional _count search parameter by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/176
* Update test suite sources by @projkov https://github.com/hl7au/au-fhir-core-inferno/pull/162, https://github.com/hl7au/au-fhir-core-inferno/pull/175, https://github.com/hl7au/au-fhir-core-inferno/pull/177
## Documentation
* Update prerequisites by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/169
## Other
* Allow direct manifests to use rds during db migration by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/173
* Implement Helm Chart for AU FHIR Inferno with Optional NGINX Ingress and Bitnami PostgreSQL by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/167

# 0.0.10
* Add new default patient id by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/146
* Update read tests to use Practitioner, PractitionerRole, Location, Organization by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/157
* Add test group to validate any resource by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/156
* Add default values for diagnostic result Observation by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/160
* Ingress update: remove validator path, update validatorapi path by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/145
* Convert postgres deployment to statefulset, add liveness and readiness probe by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/149

# 0.0.9
* Fix search for the extension value by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/139
* Fix multiple date search by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/141
* Migrate to the HL7 official validator by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/118

# 0.0.8
* AU Core 0.4.0-preview 
* Minor changes

# 0.0.7
* Add search by practitioner id for PractitionerRole test by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/132
* Generate test kit source files @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/133

# 0.0.6
* Update narrative for validation tests by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/122
* Update narrative for the Capability Statement group by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/123
* Add check for support XML by Capability Statement by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/124
* Change the default URL by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/127
* Handle special case for combo searches by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/128
* Add prefix with information about expectaction by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/130
* Generate test kit source files @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/131, https://github.com/hl7au/au-fhir-core-inferno/pull/119, https://github.com/hl7au/au-fhir-core-inferno/pull/129, https://github.com/hl7au/au-fhir-core-inferno/pull/125

# 0.0.5
* Add reporting issues section to the README by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/109
* Update search-params file to fix problems with searchDefinitions by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/111
* Generate test kit source files @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/112

# 0.0.4
* Regenerate test kit source files after updating the IG in https://github.com/hl7au/au-fhir-core-inferno/pull/107

# 0.0.3
* 62 add multiple and by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/75
* 48 add missing comparators by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/76
* WIP: Add chained search for patient:Patient.identifier by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/82
* Change tx server from test to dev by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/68
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/83
* Fix optional? method by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/84
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/85
* 80 ihi dva chained by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/86
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/87
* Add search for Practitioner IHI-I by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/88
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/89
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/90
* Fix search by identifier by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/104
* Merge new auto generated tests by @github-actions in https://github.com/hl7au/au-fhir-core-inferno/pull/105

# 0.0.2
* Spec tests by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/31
* Summary generator update by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/32
* Add generate-tests action by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/37
* Add rubocop as CI step by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/39
* Update files by rubocop except generated by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/51
* Update test files by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/53
* Add build and release pipeline by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/55
* CICD: Implement Terraform Workflow for EKS Deployment by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/41
* Add auth header and value inputs by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/66
* Remove Location and PractitionerRole from special cases by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/67

# 0.0.1
* Tests are available for the AU Core 0.3.0-ballot.
* Searching tests
* Reading tests
* Resource validation

* Update summary generator by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/10
* Use terminology server url from the ENV by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/11
* EKS-Specific Terraform Implementation for Inferno App Deployment by @KyleOps in https://github.com/hl7au/au-fhir-core-inferno/pull/13
* 0.3.0 ballot march by @ir4y in https://github.com/hl7au/au-fhir-core-inferno/pull/17
* Add may search params and combo search params by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/27
* Fix descr urls by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/23
* Add PSQL as docker compose service by @projkov in https://github.com/hl7au/au-fhir-core-inferno/pull/26

