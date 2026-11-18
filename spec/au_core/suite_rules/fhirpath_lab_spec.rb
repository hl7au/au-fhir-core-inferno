# frozen_string_literal: true

require_relative '../../support/suite_rule_helpers'

RSpec.describe 'Suite Rule: each suite links to FHIRPath Lab and serves resources as its config says' do
  include SuiteRuleHelpers

  # Mirrors the generator's getters: a missing URL falls back to its default, and
  # only an explicit `false` turns resource serving off.
  def configured_url(entry)
    entry.merged.dig('suite', 'fhirpathlab_url') || 'https://fhirpath-lab.com/FhirPath'
  end

  def serves_resources?(entry)
    entry.merged.dig('suite', 'fhirpathlab_serve_resources') != false
  end

  def resource_route_path
    '/resources/:session_id/:resource_type/:resource_id'
  end

  def resource_route(suite)
    Inferno.routes.find do |route|
      route[:suite] == suite && %i[get all].include?(route[:method]) && route[:path] == resource_route_path
    end
  end

  AUCoreTestKit::SuiteConfigs.each do |entry|
    describe entry.suite_id do
      # Since generator 77fb005, suites that don't serve resources have no FHIRPATHLAB_URL.
      it 'links to the configured FHIRPath Lab URL' do
        suite = suite_for(entry)
        url_defined = suite.const_defined?(:FHIRPATHLAB_URL, false)

        expect(url_defined).to be(true), "#{entry.suite_id} serves resources but has no FHIRPATHLAB_URL" if serves_resources?(entry)
        expect(suite::FHIRPATHLAB_URL).to eq(configured_url(entry)) if url_defined
      end

      it 'serves session resources only when config allows it' do
        route = resource_route(suite_for(entry))

        if serves_resources?(entry)
          expect(route).not_to be_nil, "#{entry.suite_id} has no GET #{resource_route_path} route, but its config serves resources"
        else
          expect(route).to be_nil, "#{entry.suite_id} has a GET #{resource_route_path} route, but its config sets fhirpathlab_serve_resources: false"
        end
      end
    end
  end
end
