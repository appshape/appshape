class TestRunScheduler
  def execute

  end

  private
  def tests
    @tests ||= TestsForRunQuery.new.execute
  end
end