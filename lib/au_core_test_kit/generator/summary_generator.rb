require 'json'

def extract_test_title(test_file_path_with_id)
  test_title = nil
  File.open(test_file_path_with_id, "r") do |test_file|
    test_file.each_line do |test_line|
      if test_line.include?("title")
        test_title = test_line.split("title")[1].strip.gsub("'", "")
        break
      end
    end
  end
  test_title
end

def extract_test_short_description(test_file_path_with_id)
  short_description = nil
  File.open(test_file_path_with_id, "r") do |test_file|
    test_file.each_line do |test_line|
      if test_line.include?("short_description")
        short_description = test_line.split("short_description")[1].strip.gsub("'", "")
        break
      end
    end
  end
  short_description
end

def extract_test_description(test_file_path_with_id)
  test_description = nil
  content = File.read(test_file_path_with_id)
  matches = content.scan(/%\((.*?)\)/m)
  if matches.empty?
    File.open(test_file_path_with_id, "r") do |test_file|
      test_file.each_line do |test_line|
        if test_line.include?("description")
          test_description = test_line.split("description")[1].strip.gsub("'", "")
          break
        end
      end
    end
  else
    matches.each do |match|
      test_description = match[0].strip
    end
  end
  test_description
end

directory_path = "lib/au_core_test_kit/generated"

folder_hashes = []

if Dir.exist?(directory_path)
  folder_names = Dir.entries(directory_path).select { |entry| File.directory?(File.join(directory_path, entry)) && entry != '.' && entry != '..' }

  folder_names.each do |folder_name|
    folder_path = File.join(directory_path, folder_name)
    file_path = File.join(folder_path, "au_core_test_suite.rb")
    test_groups = []

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
                        tests << { id: test_id, test_file_path: test_file_path_with_id, title: extract_test_title(test_file_path_with_id), description: extract_test_description(test_file_path_with_id) }
                        break
                      end
                    end
                  end
                end
              end
            end
            test_groups << { id: id, file_path: file_path_with_id, title: extract_test_title(file_path_with_id), short_description: extract_test_short_description(file_path_with_id), description: extract_test_description(file_path_with_id), tests: tests } if id && file_path_with_id
          end
        end
      end
    end

    folder_hash = {
      folder_name: folder_name,
      folder_path: folder_path,
      test_groups: test_groups
    }

    folder_hashes << folder_hash
  end

  summary_data = { summary_data: folder_hashes }

  puts JSON.pretty_generate(summary_data)
else
  puts "Directory not found: #{directory_path}"
end
