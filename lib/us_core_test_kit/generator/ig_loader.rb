require 'active_support/all'
require 'fhir_models'
require 'pathname'
require 'rubygems/package'
require 'zlib'
require 'json'
require_relative 'ig_resources'

module USCoreTestKit
  class Generator
    class IGLoader
      attr_accessor :ig_file_name

      def initialize(ig_file_name)
        self.ig_file_name = ig_file_name
      end

      def ig_resources
        @ig_resources ||= IGResources.new
      end

      def load
        load_ig
        load_standalone_resources
      end

      def load_ig
        tar = Gem::Package::TarReader.new(
          Zlib::GzipReader.open(ig_file_name)
        )

        tar.each do |entry|
          next if entry.directory?

          file_name = entry.full_name.split('/').last

          next if file_name.end_with? 'openapi.json'

          next unless file_name.end_with? '.json'

          next unless entry.full_name.start_with? 'package/'

          begin
            resource = FHIR.from_contents(entry.read)
            next if resource.nil?
          rescue StandardError
            puts "#{file_name} does not appear to be a FHIR resource."
            next
          end

          ig_resources.add(resource)
        end
        json_files = Dir.glob(File.join(Dir.pwd, 'lib', 'us_core_test_kit', 'igs', '*.json'))
        json_files.each do |file_path|
          file_content = File.read(file_path)
          bundle = FHIR.from_contents(file_content)
          bundle.entry.each do |entry|
            ig_resources.add(entry.resource)
          end
        end
        ig_resources
      end

      def load_standalone_resources
        ig_directory = ig_file_name.chomp('.tgz')

        return ig_resources unless File.exist? ig_directory

        Dir.glob(File.join(ig_directory, '*.json')).each do |file_path|
          begin
            resource = FHIR.from_contents(File.read(file_path))
            next if resource.nil?
          rescue StandardError
            file_name = file_path.split('/').last
            puts "#{file_name} does not appear to be a FHIR resource."
            next
          end

          ig_resources.add(resource)
        end

        ig_resources
      end
    end
  end
end
