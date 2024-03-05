module AUCoreTestKit
  class Generator
    class GroupMetadata
      ATTRIBUTES = [
        :name,
        :class_name,
        :version,
        :reformatted_version,
        :resource,
        :profile_url,
        :profile_name,
        :profile_version,
        :title,
        :short_description,
        :interactions,
        :operations,
        :searches,
        :search_definitions,
        :include_params,
        :revincludes,
        :required_concepts,
        :must_supports,
        :mandatory_elements,
        :bindings,
        :references,
        :tests,
        :id,
        :file_name,
        :delayed_references
      ].freeze

      NON_USCDI_RESOURCES = {
        'Encounter' => ['v311', 'v400'],
        'Location' => ['v311', 'v400', 'v501', 'v610'],
        'Organization' => ['v311', 'v400', 'v501', 'v610'],
        'Practitioner' => ['v311', 'v400', 'v501', 'v610'],
        'PractitionerRole' => ['v311', 'v400', 'v501', 'v610'],
        'Provenance' => ['v311', 'v400', 'v501', 'v610'],
        'RelatedPerson' => ['v501', 'v610'],
        'Specimen' => ['v610']
      }.freeze


      ATTRIBUTES.each { |name| attr_accessor name }

      def initialize(metadata)
        metadata.each do |key, value|
          raise "Unknown attribute #{key}" unless ATTRIBUTES.include? key

          instance_variable_set(:"@#{key}", value)
        end
      end

      def delayed?
        return false if resource == 'Patient'

        no_patient_searches? || non_uscdi_resource?
      end

      def no_patient_searches?
        searches.none? { |search| search[:names].include? 'patient' }
      end

      def non_uscdi_resource?
        NON_USCDI_RESOURCES.key?(resource) && NON_USCDI_RESOURCES[resource].include?(reformatted_version)
      end

      def add_test(id:, file_name:)
        self.tests ||= []

        test_metadata = {
          id: id,
          file_name: file_name
        }

        if delayed? && id.include?('read')
          self.tests.unshift(test_metadata)
        else
          self.tests << test_metadata
        end
      end

      def to_hash
        ATTRIBUTES.each_with_object({}) { |key, hash| hash[key] = send(key) unless send(key).nil? }
      end

      def add_delayed_references(delayed_profiles, ig_resources)
        self.delayed_references =
          references
            .select { |reference| (reference[:profiles] & delayed_profiles).present? }
            .map do |reference|
              profile_urls = (reference[:profiles] & delayed_profiles)
              delayed_resources = profile_urls.map { |url| ig_resources.resource_for_profile(url) }
              {
                path: reference[:path].gsub("#{resource}.", ''),
                resources: delayed_resources
              }
            end
      end
    end
  end
end
