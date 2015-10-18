class CreateHttpMethods < ActiveRecord::Migration
  def change
    create_table :http_methods do |t|
      t.column :code, :string, null: false
      t.timestamps null: false
    end

    add_index :http_methods, :code, unique: true
  end
end
