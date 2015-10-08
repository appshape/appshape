class AddOwnOrganizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :personal_organization_id, :integer
  end
end
