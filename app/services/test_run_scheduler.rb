class TestRunScheduler
  def execute
    tests.each do |test|
      test['locations'].map do |location|
        beanstalk.tubes.find("tests-#{location}-queue").put(test.to_json)
      end
    end
  end

  private
  def tests
    @tests ||= Rails.cache.read_multi(TestsForRunQuery.new.execute.map { |test| "test-#{test['id']}" })
  end

  def beanstalk
    @beanstalk ||= Beaneater.new(Beaneater.configuration.beanstalkd_url)
  end
end