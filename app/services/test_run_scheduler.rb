class TestRunScheduler
  def execute
    tests.values.each do |test|
      test['locations'].each do |location|
        beanstalk.tubes.find("tests-#{location}-queue").put(test.to_json)
      end
    end
  end

  private
  def tests
    @tests ||= begin
      ids = TestsForRunQuery.new.execute.map { |test| "test-#{test.first}" }
      ids.empty? ? [] : Rails.cache.read_multi(ids)
    end
  end

  def beanstalk
    @beanstalk ||= Beaneater.new(Beaneater.configuration.beanstalkd_url)
  end

  def test_cache_key(id)
    "test-#{id}"
  end
end