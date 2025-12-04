# frozen_string_literal: true

# Helpers for validating FHIR resources
module ValidatorHelpers
  VALIDATOR_KEY = 'validator_version'
  WRAPPER_KEY = 'validator_wrapper_version'
  RESPONSE_VALIDATOR_KEY = 'validatorVersion'
  RESPONSE_WRAPPER_KEY = 'validatorWrapperVersion'
  RESPONSE_KEYS = [RESPONSE_VALIDATOR_KEY, RESPONSE_WRAPPER_KEY].freeze
  DEFAULT_VALUE = 'Unknown'

  def show_validator_version
    versions = read_or_create_validator_version
    if versions.nil?
      info 'Unable to fetch validator version'
      return
    end

    validator_version = versions[VALIDATOR_KEY] || DEFAULT_VALUE
    wrapper_version = versions[WRAPPER_KEY] || DEFAULT_VALUE

    info "Using validator version #{validator_version} and validator wrapper version #{wrapper_version}"
  end

  private

  def read_or_create_validator_version
    return cached_versions if version_cached?

    fetch_and_cache_versions
  end

  def validator_url
    ENV['FHIR_RESOURCE_VALIDATOR_URL']
  end

  def response_valid?(version_data)
    RESPONSE_KEYS.all? { |key| version_data.keys.include?(key) }
  end

  def fetch_and_cache_versions
    response_body = fetch_validator_version(validator_url)
    return warning("Unable to fetch validator version from #{validator_url}") if response_body.nil?

    version_data = parse_response(response_body)

    return warning "Invalid response from validator at #{validator_url}: #{version_data}" unless response_valid?(version_data)

    cache_versions(version_data[RESPONSE_VALIDATOR_KEY], version_data[RESPONSE_WRAPPER_KEY])
    build_version_hash(version_data[RESPONSE_VALIDATOR_KEY], version_data[RESPONSE_WRAPPER_KEY])
  end

  def cache_versions(validator_version, validator_wrapper_version)
    scratch[VALIDATOR_KEY.to_sym] = validator_version
    scratch[WRAPPER_KEY.to_sym] = validator_wrapper_version
  end

  def version_cached?
    scratch[VALIDATOR_KEY.to_sym] && scratch[WRAPPER_KEY.to_sym]
  end

  def cached_versions
    build_version_hash(scratch[VALIDATOR_KEY.to_sym], scratch[WRAPPER_KEY.to_sym])
  end

  def fetch_validator_version(url)
    version_url = "#{url}/validator/version"
    begin
      response = Faraday.get(version_url)
      response.body
    rescue Faraday::Error => e
      warning "Error connecting to validator at #{url}: #{e.message}"
      nil
    end
  end

  def parse_response(response_body)
    JSON.parse(response_body)
  rescue JSON::ParserError => e
    warning "Error parsing response from validator: #{e.message}"
    nil
  end

  def build_version_hash(validator_version, validator_wrapper_version)
    {
      'validator_version' => validator_version,
      'validator_wrapper_version' => validator_wrapper_version
    }
  end
end
