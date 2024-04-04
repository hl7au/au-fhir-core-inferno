require 'erb'
require 'yaml'

def symbolize_keys(hash)
  hash.each_with_object({}) do |(key, value), result|
    result[key.to_sym] = if value.is_a?(Hash)
                           symbolize_keys(value)
                         elsif value.is_a?(Array)
                           value.map { |item| item.is_a?(Hash) ? symbolize_keys(item) : item }
                         else
                           value
                         end
  end
end

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
  summary_template = File.read(File.join(__dir__, 'templates', 'summary.md.erb'))
  folder_hashes.each do |folder_hash|
    folder_name = folder_hash[:folder_name]
    folder_path = folder_hash[:folder_path]
    test_groups = folder_hash[:test_groups]

    summary_content = ERB.new(summary_template).result(binding)

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
    test_groups.unshift(
      symbolize_keys(
        YAML.safe_load(
          File.read(
            File.join(
              __dir__, 'assets', 'capability_statement_group.yaml')))))

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
