# frozen_string_literal: true

module AUCoreTestKit
  class Generator
    class MustSupportMetadataExtractorAUCore030Ballot
      attr_accessor :profile, :must_supports

      def initialize(profile, must_supports)
        self.profile = profile
        self.must_supports = must_supports
      end

      def handle_special_cases
        remove_date_from_names_not_must_support_or_mandatory
      end

      def remove_date_from_names_not_must_support_or_mandatory
        return unless profile.url == 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight'

        # - :path: effectiveDateTime
        # :original_path: effective[x]
        # puts must_supports
        must_supports[:elements].map do |element|
          next if element[:path] != 'effective[x]'

          element[:path] = 'effectiveDateTime'
          element[:original_path] = 'effective[x]'
          # element[:path] == 'address.period'
        end
      end
    end
  end
end
