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
          tests.id, tests.locations
      ),
      test_run_groups as (
        insert into
          test_run_groups(test_id, grouping_code, started_at, created_at, updated_at)
        select
          scheduled_tests.id,
          uuid_generate_v1() as grouping_code,
          now(),
          now(),
          now()
        from
          scheduled_tests
        returning
          test_run_groups.started_at,
          test_run_groups.grouping_code,
          test_run_groups.test_id
      ),
      scheduled_tests_with_location as (
        select
          test_run_groups.test_id,
          test_run_groups.started_at,
          test_run_groups.grouping_code,
          unnest(scheduled_tests.locations) as location
        from
          test_run_groups, scheduled_tests
        where
          test_run_groups.test_id = scheduled_tests.id
      ),
      test_runs as (
        insert into
          test_runs(test_id, location, created_at, updated_at, grouping_code)
        select
          scheduled_tests_with_location.test_id,
          scheduled_tests_with_location.location,
          scheduled_tests_with_location.started_at,
          scheduled_tests_with_location.started_at,
          scheduled_tests_with_location.grouping_code
        from
          scheduled_tests_with_location
        returning
          test_runs.id as test_run_id, test_runs.test_id, test_runs.location
      )
      select
        test_runs.*,
        array_length(scheduled_tests.locations, 1) as runs_in_group_count
      from
        test_runs, scheduled_tests
      where
        test_runs.test_id = scheduled_tests.id;
    SQL
  end
end