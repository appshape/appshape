class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.column :code, :string, null: false
      t.column :path_required, :boolean, null: false, default: false
      t.column :position, :integer
      t.timestamps null: false
    end
  end
end
