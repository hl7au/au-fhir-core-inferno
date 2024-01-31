require_relative '../../../lib/us_core_test_kit/generator/search_metadata_extractor.rb'

RSpec.describe USCoreTestKit::Generator::SearchDefinitionMetadataExtractor do

  # really slime the subject here because we don't care about interactions
  # if this test file grows, this will likely break and more stubbing and setup will be required
  subject { described_class.new("test", "nothing", "nope", "no") }

  describe '#full_paths' do
    let(:param) do
      ig_resource = double()
      allow(ig_resource).to receive(:expression).and_return(expression)
      ig_resource
    end

    context "a single dateTime expression" do
      let(:expression) { "Condition.onset.as(dateTime)" }

      it 'parses correctly' do
        allow(subject).to receive(:param).and_return(param)

        expected = ["Condition.onsetDateTime"]
        expect(subject.full_paths).to eq(expected)
      end
    end

    context "a single period expression" do
      let(:expression) { "Condition.onset.as(Period)" }

      it 'parses correctly' do
        allow(subject).to receive(:param).and_return(param)

        expected = ["Condition.onsetPeriod"]
        expect(subject.full_paths).to eq(expected)
      end
    end

    context "two expressions" do
      let(:expression) { "Condition.onset.as(dateTime)|Condition.onset.as(Period)" }

      it 'parses correctly' do
        allow(subject).to receive(:param).and_return(param)

        expected = ["Condition.onsetDateTime","Condition.onsetPeriod"]
        expect(subject.full_paths).to eq(expected)
      end
    end

  end
end

