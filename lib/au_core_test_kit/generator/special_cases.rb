module USCoreTestKit
  class Generator
    module SpecialCases
      RESOURCES_TO_EXCLUDE = [
        'Location',
        'Medication',
        'PractitionerRole'
      ].freeze

      PROFILES_TO_EXCLUDE = [
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-survey',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-vital-signs'
      ].freeze

      class << self
        def exclude_group?(group)
          RESOURCES_TO_EXCLUDE.include?(group.resource)
        end
      end
    end
  end
end
