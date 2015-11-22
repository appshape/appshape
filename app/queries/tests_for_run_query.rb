class TestsForRunQuery
  def execute
    Test.connection.select_rows(query)
  end

  private
  def query
    <<-SQL
      update
        tests
      set
        last_run_at = now()
      from
        intervals i
      where
        tests.interval = i.code and
        tests.active and
        tests.last_run_at < NOW() - (i.value || ' minutes')::interval
      returning
        tests.id
    SQL
  end
end