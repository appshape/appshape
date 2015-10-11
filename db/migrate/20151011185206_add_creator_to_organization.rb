class AddCreatorToOrganization < ActiveRecord::Migration
  def change
    remove_column :users, :personal_organization_id
    change_table :organizations do |t|
      t.references :creator, index: true, null: false
    end
  end
end
