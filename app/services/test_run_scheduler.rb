class TestRunScheduler
  def execute
    scheduled_test_runs.each do |scheduled_test_run|
      test_data = scheduled_tests_data[scheduled_test_run['test_id'].to_i]
      unless test_data.empty?
        beanstalk.tubes.find("tests-#{scheduled_test_run['location']}-queue").put(
          test_data.merge({test_run_id: scheduled_test_run['test_run_id'].to_i}).to_json
        )
      end
    end
  end

  private
  def beanstalk
    @beanstalk ||= Beaneater.new(Beaneater.configuration.beanstalkd_url)
  end

  def scheduled_test_runs
    @scheduled_test_runs ||= TestsForRunQuery.new.execute
  end

  def scheduled_test_ids
    @scheduled_tests ||= scheduled_test_runs.map { |scheduled_test_run| scheduled_test_run['test_id'] }.uniq
  end

  def scheduled_tests_data
    @scheduled_tests_data ||= begin
      test_cache_keys = scheduled_test_ids.map { |test_id| test_cache_key(test_id) }
      fetch_cached_tests(test_cache_keys).inject({}) do |memo, (_, test_data)|
        memo[test_data['id']] = test_data
        memo
      end || {}
    end
  end

  def fetch_cached_tests(keys)
    Rails.cache.fetch_multi(*keys) { |key| formatted_test_by_cache_key(key) }
  end

  def formatted_test_by_cache_key(key)
    test_id = key.gsub('test-', '').to_i
    test = Test.find(test_id)
    TestFormatter.new(test).as_json
  end

  def test_cache_key(id)
    "test-#{id}"
  end
end