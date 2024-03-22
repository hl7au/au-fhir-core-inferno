module AUCoreTestKit
  class Generator
    module SpecialCases
      RESOURCES_TO_EXCLUDE = [
        'Location',
        'Medication',
        'PractitionerRole',
        'RelatedPerson',
      ].freeze

      PROFILES_TO_EXCLUDE = [].freeze

      class << self
        def exclude_group?(group)
          RESOURCES_TO_EXCLUDE.include?(group.resource)
        end
      end
    end
  end
end
