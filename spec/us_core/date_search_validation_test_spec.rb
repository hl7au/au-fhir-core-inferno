class DateSearchValidationClass
  include USCoreTestKit::DateSearchValidation
end

RSpec.describe DateSearchValidationClass do
  subject { described_class.new }

  describe '#validate_date_search' do
    let(:search_datetime) { '2022-09-17T00:00:00+00:00'}

    context 'gt search' do
      let(:search_value) { "gt#{search_datetime}" }

      it 'returns true when the target date fall into the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-17')
        expect(result).to be true
      end

      it 'returns true when the target date is one day earlier than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-16')
        expect(result).to be true
      end

      it 'returns true when the target dateTime is greater than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-17T00:00:01+00:00')
        expect(result).to be true
      end

      it 'returns false when the target dateTime is less than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-16T23:59:59+00:00')
        expect(result).to be false
      end
    end

    context 'lt search' do
      let(:search_value) { "lt#{search_datetime}" }

      it 'returns true when the target date fall into the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-16')
        expect(result).to be true
      end

      it 'returns true when the target date is one day after than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-17')
        expect(result).to be true
      end

      it 'returns true when the target dateTime is less than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-16T23:59:59+00:00')
        expect(result).to be true
      end

      it 'returns false when the target dateTime is greater than the search dateTime' do
        result = subject.validate_date_search(search_value, '2022-09-17T00:00:01+00:00')
        expect(result).to be false
      end
    end
  end
end