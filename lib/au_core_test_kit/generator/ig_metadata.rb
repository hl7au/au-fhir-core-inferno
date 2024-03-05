module AUCoreTestKit
  class Generator
    class IGMetadata
      attr_accessor :ig_version, :groups

      def reformatted_version
        @reformatted_version ||= ig_version.delete('.').gsub('-', '_')
      end

      def ordered_groups
        @ordered_groups ||=
          [patient_group] + non_delayed_groups + delayed_groups
      end

      def patient_group
        @patient_group ||=
          groups.find { |group| group.resource == 'Patient' }
      end

      def delayed_groups
        @delayed_groups ||=
          groups.select { |group| group.delayed? }
      end

      def non_delayed_groups
        @non_delayed_groups ||=
          groups.reject { |group| group.delayed? } - [patient_group]
      end

      def delayed_profiles
        @delayed_profiles ||=
          delayed_groups.map(&:profile_url)
      end

      def postprocess_groups(ig_resources)
        groups.each do |group|
          group.add_delayed_references(delayed_profiles, ig_resources)
        end
      end

      def to_hash
        {
          ig_version: ig_version,
          groups: groups.map(&:to_hash)
        }
      end
    end
  end
end
