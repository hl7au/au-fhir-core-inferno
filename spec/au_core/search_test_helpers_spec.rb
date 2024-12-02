# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/au_core_test_kit/search_test_helpers'

RSpec.describe 'is_search_by_reference? method' do
  it 'SHOULD return false if there is no references in the search params hash' do
    expect(
      SearchTestHelpers.is_search_by_reference?(
        {"patient"=>"baratz-toni", :_count =>10}
      )
    ).to eq(false)
  end

  it 'SHOULD return true if there is references in the search params hash' do
    expect(
      SearchTestHelpers.is_search_by_reference?(
        {"patient"=>"Patient/baratz-toni", :_count =>10}
      )
    ).to eq(true)
  end
end

RSpec.describe 'replace_full_reference_search_param_to_id method' do
  it 'SHOULD return correctly formatted hash without resourceType' do
    expect(
      SearchTestHelpers.replace_full_reference_search_param_to_id(
        {"patient"=>"Patient/baratz-toni", :_count =>10}
      )
    ).to eq({"patient"=>"baratz-toni", "_count" =>10})
  end

  it 'SHOULD return true if there is references in the search params hash' do
    expect(
      SearchTestHelpers.replace_full_reference_search_param_to_id(
        {"patient"=>"baratz-toni", :_count =>10}
      )
    ).to eq({"patient"=>"baratz-toni", "_count" =>10})
  end
end
