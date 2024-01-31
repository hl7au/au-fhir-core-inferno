module USCoreTestKit
  class SearchTestProperties
    ATTRIBUTES = [
      :resource_type,
      :search_param_names,
      :first_search,
      :fixed_value_search,
      :saves_delayed_references,
      :possible_status_search,
      :test_medication_inclusion,
      :token_search_params,
      :test_reference_variants,
      :params_with_comparators,
      :multiple_or_search_params,
      :test_post_search
    ].freeze

    ATTRIBUTES.each { |name| attr_reader name }

    def initialize(**properties)
      properties.each do |key, value|
        raise StandardError, "Unkown search test property: #{key}" unless ATTRIBUTES.include?(key)

        instance_variable_set(:"@#{key}", value)
      end
    end

    def first_search?
      !!first_search
    end

    def fixed_value_search?
      !!fixed_value_search
    end

    def saves_delayed_references?
      !!saves_delayed_references
    end

    def possible_status_search?
      !!possible_status_search
    end

    def test_medication_inclusion?
      !!test_medication_inclusion
    end

    def test_reference_variants?
      !!test_reference_variants
    end

    def test_post_search?
      !!test_post_search
    end
  end
end
