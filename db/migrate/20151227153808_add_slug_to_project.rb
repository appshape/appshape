class AddSlugToProject < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string
    add_index :projects, [:slug, :organization_id], unique: true
  end
end
