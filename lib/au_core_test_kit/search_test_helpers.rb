# frozen_string_literal: true

module SearchTestHelpers
  def self.search_by_reference?(search_param)
    search_param = search_param.transform_keys(&:to_s)
    search_param.keys.map { |key| search_param_is_reference?(search_param[key]) }.include?(true)
  end

  def self.replace_full_reference_search_param_to_id(search_param)
    search_param = search_param.transform_keys(&:to_s)
    search_param.each_key do |key|
      search_param[key] = search_param[key].split('/').last if search_param_is_reference?(search_param[key])
    end
    search_param
  end

  def self.search_param_is_reference?(single_search_param)
    single_search_param = single_search_param.to_s
    single_search_param.include?('/') && single_search_param.split('/').length == 2
  end
end
