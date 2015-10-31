class CreateTestRuns < ActiveRecord::Migration
  def change
    create_table :test_runs do |t|
      t.belongs_to :test, null: false
      t.column :location, :string, null: false
      t.column :result, :boolean, null: false, default: true
      t.timestamps null: false
    end
  end
end
