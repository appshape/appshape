class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.column :code, :string, null: false
      t.timestamps null: false
    end
  end
end
