class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.column :name, :string, null: false
      t.column :description, :text
      t.timestamps null: false
    end
  end
end
