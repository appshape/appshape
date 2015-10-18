class TestsAddLocationsColumn < ActiveRecord::Migration
  def change
    add_column :tests, :locations, :string, array: true
  end
end
