class ProfileSearch < Searchlight::Search
  def base_query
    Profile.all
  end

  def search_first_name
    query.where('profiles.first_name ILIKE ?', "#{options[:first_name]}%")
  end

  def search_last_name
    query.where('profiles.last_name ILIKE ?', "#{options[:last_name]}%")
  end

  def search_city
    query.where('profiles.city ILIKE ?', "#{options[:city]}%")
  end
end