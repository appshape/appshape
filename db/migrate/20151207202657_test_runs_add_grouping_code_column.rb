class TestRunsAddGroupingCodeColumn < ActiveRecord::Migration
  def change
    add_column :test_runs, :grouping_code, :string, null: false
  end
end
