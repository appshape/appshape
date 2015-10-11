class CreateOrganizationsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :organization_users, id: false do |t|
      t.references :organization, index: true, null: false
      t.references :user, index: true, null: false
      t.integer :role
    end

    add_index :organization_users, [:user_id, :organization_id]
  end
end
