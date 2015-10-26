class CreateIntervals < ActiveRecord::Migration
  def change
    create_table :intervals do |t|
      t.column :code, :string, null: false
      t.timestamps null: false
    end
  end
end
