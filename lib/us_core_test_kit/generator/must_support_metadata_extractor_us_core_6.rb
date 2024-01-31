require_relative 'must_support_metadata_extractor_us_core_5'

module USCoreTestKit
  class Generator
    class MustSupportMetadataExtractorUsCore6
      attr_accessor :profile, :must_supports

      US_CORE_CATEGORY = ['sdoh', 'functional-status', 'disability-status', 'cognitive-status']

      def initialize(profile, must_supports)
        self.profile = profile
        self.must_supports = must_supports
      end

      def us_core_4_extractor
        @us_core_4_extractor ||= MustSupportMetadataExtractorUsCore4.new(profile, must_supports)
      end

      def us_core_5_extractor
        @us_core_5_extractor ||= MustSupportMetadataExtractorUsCore5.new(profile, must_supports)
      end

      def handle_special_cases
        add_must_support_choices
        add_patient_uscdi_elements
      end

      def add_must_support_choices
        us_core_5_extractor.add_must_support_choices

        more_choices = []

        case profile.type
        when 'Goal'
          more_choices << {
            paths: ['startDate', 'target.dueDate']
          }
        when 'MedicationRequest'
          more_choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_only: true
          }
        when 'ServiceRequest'
          more_choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_only: true
          }
        end

        if profile.id == 'us-core-observation-screening-assessment'
          more_choices << {
            target_profiles: [
              'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-screening-assessment',
              'http://hl7.org/fhir/us/core/StructureDefinition/us-core-questionnaireresponse'
            ]
          }
        end

        if more_choices.present?
          must_supports[:choices] ||= []
          must_supports[:choices].concat(more_choices)
        end
      end

      def add_patient_uscdi_elements
        return unless profile.type == 'Patient'

        us_core_4_extractor.add_patient_telecom_communication_uscdi

        must_supports[:elements].each do |element|
          case element[:path]
          when 'address.use', 'name.use'
            element[:fixed_value] = 'old'
          when 'deceased[x]'
            element[:original_path] = element[:path]
            element[:path] = 'deceasedDateTime'
          end
        end


      end
    end
  end
end