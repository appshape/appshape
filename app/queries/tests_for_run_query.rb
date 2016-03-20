class TestsForRunQuery
  def execute
    Test.connection.select_all(query)
  end

  private
  def query
    <<-SQL
      with scheduled_tests as (
        update
          tests
        set
          last_run_at = now()
        from
          intervals i
        where
          tests.interval = i.code and
          tests.active and
          (tests.last_run_at is null or tests.last_run_at < NOW() - (i.value || ' minutes')::interval)
        returning
          tests.id, tests.locations, now() as created_at, uuid_generate_v1() as grouping_code
      ),
      scheduled_tests_with_location as (
        select
          scheduled_tests.id,
          scheduled_tests.created_at,
          scheduled_tests.grouping_code,
          unnest(scheduled_tests.locations) as location
        from
          scheduled_tests
      ),
      test_runs as (
        insert into
          test_runs(test_id, location, created_at, updated_at, grouping_code)
        select
          scheduled_tests_with_location.id,
          scheduled_tests_with_location.location,
          scheduled_tests_with_location.created_at,
          scheduled_tests_with_location.created_at,
          scheduled_tests_with_location.grouping_code
        from
          scheduled_tests_with_location
        returning
          test_runs.id as test_run_id, test_runs.test_id, test_runs.location
      )
      select * from test_runs;
    SQL
  end
end