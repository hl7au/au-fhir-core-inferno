# frozen_string_literal: true

RSpec.describe 'Validator SNOMED CT edition' do
  # Suites owned by this test kit. smart_access_brands comes from another gem and does
  # not validate against the AU terminology server, so it is deliberately excluded.
  au_suite_ids = %w[validations au_core_v100 au_core_v200 au_core_v210_draft].freeze

  def snomed_edition_for(suite_id)
    suite = Inferno::Repositories::TestSuites.new.find(suite_id)
    suite.fhir_validators.values.flatten.map { |v| v.validation_context.definition[:snomedCT] }
  end

  au_suite_ids.each do |suite_id|
    it "pins #{suite_id} to the Australian SNOMED CT edition" do
      editions = snomed_edition_for(suite_id)

      expect(editions).not_to be_empty
      expect(editions.uniq).to eq(['au'])
    end
  end
end
