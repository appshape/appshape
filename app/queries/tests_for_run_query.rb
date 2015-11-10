class TestsForRunQuery
  def execute
    Test.connection.select_rows(query)
  end

  private
  def query
    <<-SQL
      select
        t.id,
        unnest(t.locations) as location
      from
        tests t
        inner join intervals i on (t.interval = i.code)
      where
        t.active and
        t.last_run_at > NOW() - (i.value || ' minutes')::interval
    SQL
  end
end