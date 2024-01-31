require_relative 'must_support_metadata_extractor_us_core_3'

module USCoreTestKit
  class Generator
    class MustSupportMetadataExtractorUsCore4
      attr_accessor :profile, :must_supports

      def initialize(profile, must_supports)
        self.profile = profile
        self.must_supports = must_supports
      end

      def us_core_3_extractor
        @us_core_3_extractor ||= MustSupportMetadataExtractorUsCore3.new(profile, must_supports)
      end

      def handle_special_cases
        add_must_support_choices
        remove_patient_address_period
        add_device_distinct_identifier
        add_patient_uscdi_elements
      end

      def add_must_support_choices
        choices = []

        case profile.type
        when 'DocumentReference'
          choices << { paths: ['content.attachment.data', 'content.attachment.url'] }
        when 'Encounter'
          choices << { paths: ['reasonCode', 'reasonReference'] }
          choices << { paths: ['location.location', 'serviceProvider'] }
        when 'MedicationRequest'
          choices << { paths: ['reportedBoolean', 'reportedReference'] }
        when 'Patient'
          # FHIR-40299 adds USCDI MustSupport choices for:
          # * address.period.end and address.use,
          # * name.period.end and name.use
          choices << {
            paths: ['address.period.end', 'address.use'],
            uscdi_only: true
          }

          choices << {
            paths: ['name.period.end', 'name.use'],
            uscdi_only: true
          }
        end

        must_supports[:choices] = choices if choices.present?
      end

      def remove_patient_address_period
        us_core_3_extractor.remove_patient_address_period
      end

      def add_device_distinct_identifier
        if profile.type == 'Device'
          # FHIR-36303 US Core 4.0.0 mistakenly removed MS from Device.distinctIdentifier
          # This will be fixed in US Core 5.0.0
          must_supports[:elements] << {
            path: 'distinctIdentifier'
          }
        end
      end

      def add_patient_uscdi_elements
        return unless profile.type == 'Patient'

        #US Core 4.0.0 Section 10.112.1.1 Additional USCDI v1 Requirement:
        must_supports[:extensions] << {
          id: 'Patient.extension:race',
          url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-race',
          uscdi_only: true
        }
        must_supports[:extensions] << {
          id: 'Patient.extension:ethnicity',
          url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity',
          uscdi_only: true
        }
        must_supports[:extensions] << {
          id: 'Patient.extension:birthsex',
          url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex',
          uscdi_only: true
        }
        must_supports[:elements] << {
          path: 'name.suffix',
          uscdi_only: true
        }
        must_supports[:elements] << {
          path: 'telecom',
          uscdi_only: true
        }
        must_supports[:elements] << {
          path: 'communication',
          uscdi_only: true
        }

        add_patient_telecom_communication_uscdi
      end

      def add_patient_telecom_communication_uscdi
        return unless profile.type == 'Patient'

        # Though telecom.system, telecom.value, telecom.use, and communication.language are marked as MustSupport since US Core v4.0.0,
        # their parent elements telecom, and communication are not MustSupport but listed under "Additional USCDI requirements"
        # According to the updated FHIR spec that "When a child element is defined as Must Support and the parent element isn't,
        # a system must support the child if it support the parent, but there's no expectation that the system must support the parent.",
        # We add uscdi_only tag to these elements
        must_supports[:elements].each do |element|
          path = element[:path]
          element[:uscdi_only] = true if path.include?('telecom.') || path.include?('communication.')
        end
      end
    end
  end
end