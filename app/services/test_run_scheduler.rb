class TestRunScheduler
  def execute
    test_runs.each do |test_run|
      test_data = cached_test_data[test_run['test_id'].to_i]
      schedule_test_run(test_run, test_data) unless test_data.empty?
    end
  end

  private
  def schedule_test_run(test_run, test_data)
    tube = beanstalk.tubes.find("tests-#{test_run['location']}-queue")
    tube.put(test_data.merge({
      test_run_id: test_run['test_run_id'].to_i,
      grouping_code: test_run['grouping_code'],
      runs_in_group_count: test_run['runs_in_group_count'].to_i
    }).to_json)
  end

  def beanstalk
    @beanstalk ||= Beaneater.new(Beaneater.configuration.beanstalkd_url)
  end

  def test_runs
    @test_runs ||= SchedulingQuery.new.execute.to_a
  end

  def cached_test_data
    @cached_test_data ||= Test::TestCacheService.read(*test_runs.map { |tr| tr['test_id'] }.uniq)
  end
end