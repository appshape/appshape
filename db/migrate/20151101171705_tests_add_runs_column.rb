class TestsAddRunsColumn < ActiveRecord::Migration
  def change
    add_column :tests, :last_run_at, 'timestamp with time zone'
    add_column :tests, :last_run_result, :string
    add_column :tests, :last_run_id, :integer
  end
end
