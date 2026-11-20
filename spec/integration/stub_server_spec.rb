# frozen_string_literal: true

require 'fhir_stub_server'
require 'net/http'
require 'rack/mock'
require_relative '../../lib/au_core_test_kit/suite_configs'

RSpec.describe 'fhir_stub_server on the kit\'s IG packages' do
  def stub_for(entry)
    package = File.join(AUCoreTestKit::SuiteConfigs::ROOT, entry.merged.dig('ig', 'package_archive_path'))
    FHIRStubServer::Stub.new({ 'fhir' => { 'sources' => [{ 'package' => package }] } })
  end

  AUCoreTestKit::SuiteConfigs.each do |entry|
    describe entry.suite_id do
      let(:stub) { stub_for(entry) }
      let(:app) { Rack::MockRequest.new(FHIRStubServer::RackApp.new(stub)) }

      it 'answers GET /metadata with the CapabilityStatement the suite tests against' do
        response = app.get('/fhir/metadata')

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to include('url' => entry.capability_statement['url'])
      end

      it 'records a read it has no Demo Data for as unmatched' do
        response = app.get('/fhir/Patient/missing')

        expect(response.status).to eq(404)
        expect(stub.unmatched.map { |miss| miss[:request].slice(:method, :path) })
          .to eq([{ method: 'GET', path: '/Patient/missing' }])
      end
    end
  end

  describe FHIRStubServer::HTTPServer do
    let(:entry) { AUCoreTestKit::SuiteConfigs.entries.last }
    let(:server) { described_class.new(stub_for(entry)) }

    before { WebMock.disable_net_connect!(allow_localhost: true) }

    after do
      server.stop
      WebMock.disable_net_connect!
    end

    it 'serves GET /metadata over HTTP' do
      response = Net::HTTP.get_response(URI("#{server.start}/fhir/metadata"))

      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)).to include('url' => entry.capability_statement['url'])
    end
  end
end
