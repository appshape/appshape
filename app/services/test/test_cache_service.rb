class Test::TestCacheService
  def self.write(test)
    Rails.cache.write(cache_key(test.id), TestFormatter.new(test).as_json)
  end

  def self.read(*test_ids)
    Rails.cache.read_multi(test_ids.map do |test_id|
      cache_key(test_id)
    end).inject({}) do |memo, (_, test_data)|
      memo[test_data['id']] = test_data
      memo
    end || {}
  end

  def self.cache_key(test_id)
    "test-#{test_id}"
  end
end