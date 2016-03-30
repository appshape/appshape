class CreateTestRunGroups < ActiveRecord::Migration
  def change
    create_table :test_run_groups do |t|
      t.column :test_id, :integer, null: false
      t.column :grouping_code, :string, null: false
      t.column :result, :integer
      t.column :status, :integer, null: false, default: 0
      t.column :started_at, :timestamp
      t.column :finished_at, :timestamp
      t.column :avg_response_time, :decimal
      t.timestamps null: false
    end

    add_index :test_run_groups, :grouping_code, unique: true
    add_index :test_run_groups, :test_id

    add_foreign_key :test_run_groups, :tests
    add_foreign_key :test_runs, :tests
    add_foreign_key :test_runs, :test_run_groups, column: :grouping_code, primary_key: :grouping_code
  end
end
