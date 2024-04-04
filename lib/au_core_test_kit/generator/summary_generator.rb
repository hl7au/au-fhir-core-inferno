require 'json'
require 'erb'

SUMMARY_TEMPLATE = <<-MD
# <%= folder_name %>

<% test_groups.each do |test_group| %>
## <%= test_group[:title] %>

<details>
<summary><%= test_group[:short_description] %></summary>

<%= test_group[:description] %>
</details>

### Tests
<% test_group[:tests].each do |test| %>
#### <%= test[:title] %>
<details>
<summary>Show details</summary>
<%= test[:description] %>
# <% if test[:search_string] != nil %>
# ##### Requests

# **HTTP GET**

# ```bash
# GET <%= test[:search_string] %> HTTP/1.1
# User-Agent: {agent}
# Host: {host}
# Accept: application/fhir+json
# ```

# **For browser based calls:**

# ```bash
# {test endpoint}<%= test[:search_string] %>
# ```
# <% end %>
</details>

<% end %>
<% end %>
MD

CAPABILITY_STATEMENT_GROUP = {
  "id": ":au_core_v030_ballot_capability_statement",
  "file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/capability_statement_group.rb",
  "title": "1.1 Capability Statement",
  "short_description": "Retrieve information about supported server functionality using the FHIR capabilties interaction.",
  "description": "# Background\nThe Capability Statement Sequence tests a FHIR server's ability to formally describe features supported by the API by using the [Capability Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource. The features described in the Capability Statement must be consistent with the required capabilities of a AU Core server. The Capability Statement must also advertise the location of the required SMART on FHIR endpoints that enable authenticated access to the FHIR server resources. The Capability Statement resource allows clients to determine which resources are supported by a FHIR Server. Not all servers are expected to implement all possible queries and data elements described in the AU Core API. For example, the AU Core Implementation Guide requires that the Patient resource and only one additional resource profile from the AU Core Profiles.\n# Testing Methodology\nThis test sequence accesses the server endpoint at `/metadata` using a `GET` request. It parses the Capability Statement and verifies that: * The endpoint is secured by an appropriate cryptographic protocol * The resource matches the expected FHIR version defined by the tests * The resource is a valid FHIR resource * The server claims support for JSON encoding of resources * The server claims support for the Patient resource and one other resource It collects the following information that is saved in the testing session for use by later tests: * List of resources supported * List of queries parameters supported",
  "tests": [
      {
          "id": ":au_core_v030_ballot_capability_statement_test",
          "test_file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/patient/patient_id_search_test.rb",
          "title": "1.1.1 FHIR server secured by transport layer security",
          "description": "Systems **SHALL** use TLS version 1.2 or higher for all transmissions not taking place over a secure network connection."
      },
      {
          "id": ":au_core_v030_ballot_capability_statement_test",
          "test_file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/patient/patient_id_search_test.rb",
          "title": "1.1.2 FHIR Server supports the conformance interaction",
          "description": "The conformance 'whole system' interaction provides a method to get the CapabilityStatement for the FHIR server. This test checks that the server responds to a `GET` request at the following endpoint: ``` GET [base]/metadata ``` This test checks the following SHALL requirement: > Applications SHALL return a resource that describes the functionality of the server end-point. [http://hl7.org/fhir/R4/http.html#capabilities](http://hl7.org/fhir/R4/http.html#capabilities) It does this by checking that the server responds with an HTTP OK 200 status code and that the body of the response contains a valid [CapabilityStatement resource](http://hl7.org/fhir/R4/capabilitystatement.html). This test does not inspect the content of the CapabilityStatement to see if it contains the required information. It only checks to see if the RESTful interaction is supported and returns a valid CapabilityStatement resource."
      },
      {
          "id": ":au_core_v030_ballot_capability_statement_test",
          "test_file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/patient/patient_id_search_test.rb",
          "title": "1.1.3 Server is using FHIR R4",
          "description": "This test inspects the CapabilityStatement returned by the server to verify that the server is using FHIR R4."
      },
      {
          "id": ":au_core_v030_ballot_capability_statement_test",
          "test_file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/patient/patient_id_search_test.rb",
          "title": "1.1.4 FHIR server capability states JSON support",
          "description": "FHIR provides multiple [representation formats](https://www.hl7.org/fhir/formats.html) for resources, including JSON and XML. AU Core profiles require servers to use the [JSON representation](https://www.hl7.org/fhir/json.html): [```The AU Core Server **SHALL** Support json source formats for all US Core interactions.```](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html#title) The FHIR conformance interaction require servers to describe which formats are available for clients to use. The server must explicitly state that JSON is supported. This is located in the format element of the CapabilityStatement Resource. This test checks that one of the following values are located in the format field. * json * application/json * application/fhir+json"
      },
      {
          "id": ":au_core_v030_ballot_capability_statement_test",
          "test_file_path": "lib/au_core_test_kit/generated/v0.3.0-ballot/patient/patient_id_search_test.rb",
          "title": "1.1.5 Capability Statement lists support for required AU Core Resource Types",
          "description": "The AU Core Implementation Guide states: ``` The AU Core Server SHALL: 1. Support the AU Core Patient resource. 2. Support at least one additional AU Core resources. In order to support USCDI, servers must support all USCDI resources. ```"
      }
  ]
}

def make_search_string(resource_name, search_names)
  search = search_names.map.with_index do |search_name, index|
      prefix = index == 0 ? "?" : "&"
      "#{prefix}#{search_name}={#{search_name}}"
  end
  "/#{resource_name}#{search.join('')}"
end

def search_string(file_path)
  search_names = extract_test_attribute(file_path, "search_param_names")
  if search_names
    resource_type = extract_test_attribute(file_path, "resource_type")
    make_search_string(resource_type, search_names)
  else
    nil
  end
end

def update_test_groups_titles(ig_index, test_groups)
  test_groups.map.with_index do |test_group, index|
    test_group_index = index + 2
    test_group[:title] = "#{ig_index}.#{test_group_index} #{test_group[:title]}"
    test_group[:tests].map.with_index do |test, t_index|
      test_index = t_index + 1
      test[:title] = "#{ig_index}.#{test_group_index}.#{test_index} #{test[:title]}"
    end
  end
end

def generate_summary_md(folder_hashes)
  folder_hashes.each do |folder_hash|
    folder_name = folder_hash[:folder_name]
    folder_path = folder_hash[:folder_path]
    test_groups = folder_hash[:test_groups]

    summary_content = ERB.new(SUMMARY_TEMPLATE).result(binding)

    File.open("#{folder_path}/summary.md", "w") do |summary_file|
      summary_file.puts summary_content
    end
  end
end

def find_value_in_file(file_path, search_str)
  value = nil
  File.open(file_path, "r") do |test_file|
    test_file.each_line do |test_line|
      if test_line.include?(search_str)
        value = test_line.split(search_str)[1].strip.gsub("'", "")
        break
      end
    end
  end
  value
end


def extract_test_attribute(test_file_path_with_id, attribute)
  attribute_value = nil
  case attribute
  when "resource_type"
    attribute_value = find_value_in_file(test_file_path_with_id, "resource_type").gsub(":", "").gsub(",", "").strip
  when "search_param_names"
    dirty_value = find_value_in_file(test_file_path_with_id, "search_param_names")
    if dirty_value
      attribute_value = dirty_value.scan(/\[(.*?)\]/).flatten.first.split(', ')
    end
  when "title"
    attribute_value = find_value_in_file(test_file_path_with_id, "title")
  when "short_description"
    attribute_value = find_value_in_file(test_file_path_with_id, "short_description")
  when "description"
    content = File.read(test_file_path_with_id)
    matches = content.scan(/%\((.*?)\)/m)
    if matches.empty?
      attribute_value = find_value_in_file(test_file_path_with_id, "description")
    else
      matches.each do |match|
        attribute_value = match[0].strip
      end
    end
  else
    puts "Unknown attribute: #{attribute}"
  end
  attribute_value
end

directory_path = "lib/au_core_test_kit/generated"

folder_hashes = []

if Dir.exist?(directory_path)
  folder_names = Dir.entries(directory_path).select { |entry| File.directory?(File.join(directory_path, entry)) && entry != '.' && entry != '..' }

  folder_names.each_with_index do |folder_name, index|
    folder_path = File.join(directory_path, folder_name)
    file_path = File.join(folder_path, "au_core_test_suite.rb")
    test_groups = []
    ig_index = index + 1

    if File.exist?(file_path)
      File.open(file_path, "r") do |file|
        file.each_line do |line|
          if line.include?("group from: :")
            value = line[/[:]\s*([^\s]+)/, 1]
            id = value if value
            file_path_with_id = Dir.glob("#{folder_path}/*").find { |f| File.file?(f) && File.read(f).include?("id #{id}") }
            tests = []
            if id && file_path_with_id
              File.open(file_path_with_id, "r") do |test_file|
                test_file.each_line do |test_line|
                  if test_line.include?("test from: :")
                    test_value = test_line[/[:]\s*([^\s]+)/, 1]
                    test_id = test_value if test_value
                    Dir.glob("#{folder_path}/**/*").select { |f| File.file?(f) }.each do |test_file_path_with_id|
                      if File.read(test_file_path_with_id).include?("id #{test_id}")
                        tests << { 
                          id: test_id, 
                          test_file_path: test_file_path_with_id, 
                          title: extract_test_attribute(test_file_path_with_id, "title"), 
                          description: extract_test_attribute(test_file_path_with_id, "description"),
                          search_string: search_string(test_file_path_with_id)
                        }
                        break
                      end
                    end
                  end
                end
              end
            end
            test_groups << { 
              id: id, 
              file_path: file_path_with_id, 
              title: extract_test_attribute(file_path_with_id, "title"), 
              short_description: extract_test_attribute(file_path_with_id, "short_description"), 
              description: extract_test_attribute(file_path_with_id, "description"), 
              tests: tests 
            } if id && file_path_with_id
          end
        end
      end
    end

    update_test_groups_titles(ig_index, test_groups)

    test_groups.unshift(CAPABILITY_STATEMENT_GROUP)

    folder_hash = {
      folder_name: "#{ig_index} AU Core #{folder_name}",
      folder_path: folder_path,
      test_groups: test_groups,
    }

    folder_hashes << folder_hash
  end
  generate_summary_md(folder_hashes)
else
  puts "Directory not found: #{directory_path}"
end
