class TestsAddIntervalAndActiveColumns < ActiveRecord::Migration
  def change
    add_column :tests, :interval, :string, null: false
    add_column :tests, :active, :boolean, null: false, default: true
  end
end
