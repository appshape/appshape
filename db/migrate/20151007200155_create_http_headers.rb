class CreateHttpHeaders < ActiveRecord::Migration
  def change
    create_table :http_headers do |t|
      t.column :name, :string, null: false
      t.timestamps null: false
    end
    add_index :http_headers, :name, unique: true
  end
end
