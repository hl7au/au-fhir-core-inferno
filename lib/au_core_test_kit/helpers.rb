# frozen_string_literal: true

module Helpers
  DAR_CODE_SYSTEM_URL = 'http://terminology.hl7.org/CodeSystem/data-absent-reason'
  DAR_EXTENSION_URL = 'http://hl7.org/fhir/StructureDefinition/data-absent-reason'

  def self.multiple_test_description(multiple_type, conformance_expectation, search_param_name_string, resource_type, url_version)
    multiple_type_str = multiple_type == 'OR' ? 'multipleOr' : 'multipleAnd' 
    <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
    A server #{conformance_expectation} support searching by #{multiple_type_str}
    #{search_param_name_string} on the #{resource_type} resource. This test
    will pass if resources are returned and match the search criteria. If
    none are returned, the test is skipped.

    [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
    DESCRIPTION
  end
  def self.get_http_header(header_name, header_value)
    (header_name && header_value) ? {header_name => header_value} : {}
  end

  def self.extract_extensions_from_resource(resource, extensions = [])
    resource_hash = convert_resource_to_hash(resource)
    process_resource_element(resource_hash, extensions)
    extensions
  end

  def self.get_capability_statement_group_description_text(title, for_group_description = true)
    background_title = for_group_description ? '# Background' : '#### Background'
    testing_methodology_title = for_group_description ? '# Testing Methodology' : '#### Testing Methodology'

    <<~DESCRIPTION
      #{background_title}
      The #{title} Sequence tests a FHIR server's ability to formally describe
      features supported by the API by using the [Capability
      Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
      The features described in the Capability Statement must be consistent with
      the required capabilities of a AU Core **Responder**.

      The Capability Statement resource allows clients to determine which
      resources are supported by a FHIR Server. Not all servers are expected to
      implement all possible queries and data elements described in the AU Core
      API. The **AU Core Responder Capability Statement** requires that
      the Patient resource and **at least** one additional resource profile from the AU Core profiles.

      #{testing_methodology_title}

      This test sequence accesses the server endpoint at `/metadata` using a
      `GET` request. It parses the Capability Statement and verifies that:

      * The endpoint is secured by an appropriate cryptographic protocol
      * The resource matches the expected FHIR version defined by the tests
      * The resource is a valid FHIR resource
      * The server claims support for JSON encoding of resources
      * The server claims support for the Patient resource and one other
        resource

      It collects the following information that is saved in the testing session
      for use by later tests:

      * List of resources supported
      * List of queries parameters supported
    DESCRIPTION
  end

  def self.get_group_description_text(title, resource_type, profile_name, group_version, profile_url,
                                      required_searches, search_param_name_string, search_validation_resource_type,
                                      for_group_description = true)
    background_title = for_group_description ? '# Background' : '#### Background'
    testing_methodology_title = for_group_description ? '# Testing Methodology' : '#### Testing Methodology'
    must_support_title = for_group_description ? '## Must Support' : '##### Must Support'
    profile_validation_title = for_group_description ? '## Profile Validation' : '##### Profile Validation'
    reference_validation_title = for_group_description ? '## Reference Validation' : '##### Reference Validation'

    <<~DESCRIPTION
      #{background_title}

      The AU Core #{title} sequence verifies that the system under test is
      able to provide correct responses for #{resource_type} queries. These queries
      must contain resources conforming to the #{profile_name} as
      specified in the AU Core #{group_version} Implementation Guide.

      #{testing_methodology_title}
      #{search_description(required_searches, search_param_name_string, search_validation_resource_type, for_group_description, resource_type)}

      #{must_support_title}
      Each profile contains elements marked as "must support". This test
      sequence expects to see each of these elements at least once. If at
      least one cannot be found, the test will fail. The test will look
      through the #{resource_type} resources found in the first test for these
      elements.

      #{profile_validation_title}
      Each resource returned from the first search is expected to conform to
      the [#{profile_name}](#{profile_url}). Each element is checked against
      teminology binding and cardinality requirements.

      Elements with a required binding are validated against their bound
      ValueSet. If the code/system in the element is not part of the ValueSet,
      then the test will fail.

      #{reference_validation_title}
      At least one instance of each external reference in elements marked as
      "must support" within the resources provided by the system must resolve.
      The test will attempt to read each reference found and will fail if no
      read succeeds.
    DESCRIPTION
  end

  def self.search_description(required_searches, search_param_name_string, search_validation_resource_type, for_group_description, resource_type)
    return '' if required_searches.blank?

    is_independant_group = ['Practitioner', 'PractitionerRole', 'Location', 'Organization'].include? resource_type
    basic_search_parameters_text = 'The first search uses the selected patient(s) from the prior launch sequence. Any subsequent searches will look for its parameter values from the results of the first search. For example, the `identifier` search in the patient sequence is performed by looking for an existing `Patient.identifier` from any of the resources returned in the `_id` search. If a value cannot be found this way, the search is skipped.'
    independant_search_parameters_text = 'Resources for this test group can\'t be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md). Additionally, you can run this test group separately by using specific resource IDs.'
    search_parameters_text = is_independant_group ? independant_search_parameters_text : basic_search_parameters_text

    searching_title = for_group_description ? '## Searching' : '##### Searching'
    search_parameters_title = for_group_description ? '### Search Parameters' : '###### Search Parameters'
    search_validation_title = for_group_description ? '### Search Validation' : '###### Search Validation'

    <<~SEARCH_DESCRIPTION
      #{searching_title}
      This test sequence will first perform each required search associated
      with this resource. This sequence will perform searches with the
      following parameters:

      #{search_param_name_string}

      #{search_parameters_title}
      #{search_parameters_text}

      #{search_validation_title}
      Inferno will retrieve up to the first 20 bundle pages of the reply for
      #{search_validation_resource_type} and save them for subsequent tests. Each of
      these resources is then checked to see if it matches the searched
      parameters in accordance with [FHIR search
      guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
      for example, if a Patient search for `gender=male` returns a `female`
      patient.
    SEARCH_DESCRIPTION
  end

  def self.convert_resource_to_hash(resource)
    if defined?(FHIR) && resource.is_a?(FHIR::Model)
      resource.source_hash.deep_stringify_keys
    else
      resource
    end
  end

  def self.process_resource_element(element, extensions)
    case element
    when Hash
      extensions.concat(element['extension']) if element['extension'].is_a?(Array)
      element.each_value do |value|
        process_resource_element(value, extensions)
      end
    when Array
      element.each { |item| process_resource_element(item, extensions) }
    end
  end

  def self.custom_validation_group_title_text
    'Custom Validation Group'
  end

  def self.custom_validation_group_description_text
    %(
      This test group is designed to validate the conformity of FHIR resources against specified profiles.
      Leveraging the dynamic capabilities of FHIR, this validation ensures that the resources adhere to the standards and guidelines established within the relevant AU Core.
    )
  end

  def self.custom_validation_test_title_text
    'Custom validation of the resource'
  end

  def self.custom_validation_test_input_text
    'FHIR resource in JSON format (custom validation)'
  end

  def self.custom_validation_test_description_text
    %(
      This test automatically identifies and validates any provided FHIR resource.
      Users are required to input the FHIR resource in JSON format, referred to as 'resource_json'.
      The test extracts the applicable profile for validation from the first element in the 'meta.profile' array, located at the path: resource.meta.profile.0.
      This profile serves as the benchmark for the validation process.

      Given the optional nature of this test, its results do not influence the final outcome of the test report.
    )
  end

  def self.custom_validation_test_info_resource_type_text(resource_type)
    "Resource type to validate is #{resource_type}"
  end

  def self.custom_validation_test_info_profile_text(fhir_resource_profile)
    "Resource profile to validate is #{fhir_resource_profile}"
  end

  def self.custom_validation_test_info_ig_text(ig_version)
    "IG version to validate is #{ig_version}"
  end

  def self.default_patient_ids_string
    'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'
  end

  def self.check_for_dar(resource)
    resource.each_element do |element, _meta, path|
      next unless element.is_a?(FHIR::Coding)

      return true if (element.code == 'masked' || element.code == 'unknown') && element.system == DAR_CODE_SYSTEM_URL
    end

    false
  end

  def self.check_for_dar_extension(resource)
    return resource.source_contents&.include? DAR_EXTENSION_URL
  end

  def self.return_uniq_list_resources(resource_list)
    return resource_list.uniq
  end

  def self.is_message_exist_in_list(message_list, message)
    message_list.any? { |list_message| message.include? list_message }
  end
end
