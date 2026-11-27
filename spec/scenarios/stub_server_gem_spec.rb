# frozen_string_literal: true

require 'net/http'
require 'fhir_stub_server'

RSpec.describe FHIRStubServer::HTTPServer do
  let(:stub) do
    FHIRStubServer::Stub.new({ 'fhir' => { 'sources' => [{ 'package' => 'lib/au_core_test_kit/igs/3.0.0-ballot1.tgz' }] } })
  end
  let(:server) { described_class.new(stub) }
  let(:base_url) { server.start }

  before { WebMock.disable_net_connect!(allow: '127.0.0.1') }

  after do
    server.stop
    WebMock.disable_net_connect!
  end

  it 'serves Demo Data from an AU Core package and records misses' do
    patient = Net::HTTP.get_response(URI("#{base_url}/fhir/Patient/wang-li"))
    expect(patient.code).to eq('200')
    expect(JSON.parse(patient.body)).to include('resourceType' => 'Patient', 'id' => 'wang-li')

    miss = Net::HTTP.get_response(URI("#{base_url}/fhir/Patient?family=x"))
    expect(miss.code).to eq('404')
    expect(stub.unmatched.map { |entry| entry[:suggested_request] })
      .to eq([{ 'path' => '/Patient', 'query' => { 'family' => 'x' } }])
  end
end
