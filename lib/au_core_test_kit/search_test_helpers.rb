module SearchTestHelpers

  def self.is_search_by_reference?(search_param)
    search_param = search_param.transform_keys(&:to_s)
    search_param.keys.map {|key| is_search_param_is_reference?(search_param[key])}.include?(true)
  end

  def self.replace_full_reference_search_param_to_id(search_param)
    search_param = search_param.transform_keys(&:to_s)
    search_param.keys.each do |key|
      if is_search_param_is_reference?(search_param[key])
        search_param[key] = search_param[key].split('/').last
      end
    end
    search_param
  end

  private

  def self.is_search_param_is_reference?(single_search_param)
    single_search_param = single_search_param.to_s
    single_search_param.include?('/') && single_search_param.split('/').length == 2
  end

end