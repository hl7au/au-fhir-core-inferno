# frozen_string_literal: true

require 'net/http'
require 'json'
require 'base64'
require 'securerandom'

class AidboxConfig
  def initialize(base_url)
    @base_url = base_url
    @steps = []
  end

  def add_step(path, method, body, headers)
    @steps << AidboxConfigStep.new(@base_url, path, method, body, headers)
  end

  # Add a step that POSTs multipart/form-data (e.g. for /$upload-fhir-npm-packages).
  # file_path: path to the archive file; form_field: name of the file input (default "file").
  def add_upload_step(path, file_path, headers = {}, form_field: 'file')
    body = { __multipart_file: file_path, __form_field: form_field }
    @steps << AidboxConfigStep.new(@base_url, path, 'POST', body, headers)
  end

  def execute_all
    @steps.each(&:execute)
  end
end

class AidboxConfigStep
  def initialize(base_url, path, method, body, headers)
    @base_url = base_url
    @path = path
    @method = method
    @body = body
    @headers = headers
  end

  def build_multipart_body(file_path, form_field, boundary)
    filename = File.basename(file_path)
    content = File.binread(file_path)
    [
      "--#{boundary}\r\n",
      "Content-Disposition: form-data; name=\"#{form_field}\"; filename=\"#{filename}\"\r\n",
      "Content-Type: application/octet-stream\r\n\r\n",
      content,
      "\r\n--#{boundary}--\r\n"
    ].join
  end

  def post
    uri = URI.parse(@base_url + @path)
    request_headers = @headers.dup

    body, multipart = if @body.is_a?(Hash) && @body[:__multipart_file]
                        file_path = @body[:__multipart_file]
                        form_field = @body[:__form_field] || 'file'
                        boundary = "----RubyFormBoundary#{SecureRandom.hex(16)}"
                        request_headers['Content-Type'] = "multipart/form-data; boundary=#{boundary}"
                        [build_multipart_body(file_path, form_field, boundary), true]
                      elsif @body.is_a?(Hash)
                        @body.empty? ? ['', false] : [@body.to_json, false]
                      else
                        [@body.to_s, false]
                      end

    request = Net::HTTP::Post.new(uri, request_headers)
    request.body = body
    Net::HTTP.start(uri.hostname, uri.port) do |http|
      puts "Attempting to POST #{uri}#{' (multipart/form-data)' if multipart} with headers #{request_headers.to_json}"
      puts "(body size: #{body.bytesize} bytes)" if multipart
      response = http.request(request)
      puts response.body
    end
  end

  def execute
    case @method
    when 'POST'
      post
    else
      raise "Method #{@method} not supported"
    end
  end
end

login = ENV.fetch('AIDBOX_CLIENT_ID', 'root')
password = ENV.fetch('AIDBOX_CLIENT_SECRET', 'secret')
authorization = "Basic #{Base64.strict_encode64("#{login}:#{password}")}"
base_url = ENV.fetch('AIDBOX_BASE_URL', 'http://localhost:3500')
configurer = AidboxConfig.new(base_url)
value_sets = [
  'ValueSet-australian-indigenous-status-1.json',
  'ValueSet-australian-immunisation-register-vaccine-1.json',
  'ValueSet-australian-medication-1.json',
  'ValueSet-ihi-record-status-1.json',
  'ValueSet-ihi-status-1.json',
  'ValueSet-date-accuracy-indicator-1.json'
]
value_sets.each do |value_set|
  configurer.add_step('/fhir/ValueSet', 'POST', File.read("./resources/#{value_set}"), { 'Content-Type' => 'application/json', 'Authorization' => authorization })
end
configurer.add_step('/fhir/CodeSystem', 'POST', File.read('./resources/CodeSystem-australian-indigenous-status-1.json'), { 'Content-Type' => 'application/json', 'Authorization' => authorization })
configurer.execute_all
