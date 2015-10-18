class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.column :code, :string, null: false
      t.column :active, :boolean, null: false, default: true
      t.timestamps null: false
    end
  end
end
