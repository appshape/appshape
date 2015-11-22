module Populators::TestFormPopulators
  @@collection_populator = lambda do |fragment, collection, index, options|
    (item = collection[index]) ? item : collection.insert(index, fragment)
  end

  @@headers_prepopulator = lambda do |_|
    self.headers = [{ name: 'User-Agent', value: 'AppShape'}]
  end

  @@assertions_prepopulator = lambda do |_|
    self.assertions = [{source_code: :status_code, property: :equal, value: 200}]
  end

  @@data_points_prepopulator = lambda do |_|
    self.data_points = [
      {source_code: 'status_code'},
      {source_code: 'response_time'}
    ]
  end
end