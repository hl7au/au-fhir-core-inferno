# frozen_string_literal: true

require 'nokogiri'
require 'json'
require 'net/http'

url = 'http://hl7.org.au/fhir/core/history.html'

begin
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  unless response.is_a?(Net::HTTPSuccess)
    puts "Failed to fetch HTML content from #{url}. HTTP Status: #{response.code} #{response.message}"
    exit
  end

  html_content = response.body

  doc = Nokogiri::HTML(html_content)

  script_tag = doc.at('script:contains("var pageJSON")')

  ig_versions_to_skip = ['0.1.0-draft', '0.2.0-preview', '0.2.1-preview', '0.2.2-preview', '0.3.0-ballot', '0.4.1-preview', 'current']

  if script_tag&.content
    json_data = script_tag.content[/\{.*\}/m]
    if json_data
      data_hash = JSON.parse(json_data)
      data_hash['list'].each do |item|
        version = item['version']
        next if ig_versions_to_skip.include? version

        package_url = "#{item['path']}/package.tgz"
        file_name = "#{version}.tgz"
        output_directory = 'lib/au_core_test_kit/igs'

        Dir.mkdir(output_directory) unless File.directory?(output_directory)

        File.open(File.join(output_directory, file_name), 'wb') do |file|
          uri = URI.parse(package_url)
          response = Net::HTTP.get_response(uri)
          if response.is_a?(Net::HTTPSuccess)
            file.write(response.body)
            puts "Successfully downloaded #{file_name}"
          else
            puts "Failed to download #{file_name}. HTTP Status: #{response.code} #{response.message}"
          end
        end
      end
    else
      puts 'Error: Unable to extract JSON data from script tag.'
    end
  else
    puts 'Error: Script tag containing pageJSON variable not found.'
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
