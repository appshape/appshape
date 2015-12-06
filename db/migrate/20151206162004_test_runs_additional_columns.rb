class TestRunsAdditionalColumns < ActiveRecord::Migration
  def change
    change_column_null :test_runs, :result, true

    add_column :test_runs, :failed_assertions, :json
    add_column :test_runs, :response_body_file_path, :string
    add_column :test_runs, :executed_at, 'timestamp with time zone'
  end
end
