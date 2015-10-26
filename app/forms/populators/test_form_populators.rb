module Populators::TestFormPopulators
  @@collection_populator = lambda do |fragment, collection, index, options|
    (item = collection[index]) ? item : collection.insert(index, OpenStruct.new(fragment))
  end

  @@headers_prepopulator = lambda do |_|
    self.headers = [OpenStruct.new({ name: 'User-Agent', value: 'AppShape'})]
  end

  @@assertions_prepopulator = lambda do |_|
    self.assertions = [OpenStruct.new({source_code: :status_code, property: :equal, value: 200})]
  end

  @@data_points_prepopulator = lambda do |_|
    self.data_points = [
        OpenStruct.new({source_code: 'status_code'}),
        OpenStruct.new({source_code: 'response_time'})
    ]
  end
end