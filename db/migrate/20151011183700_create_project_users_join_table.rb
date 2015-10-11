class CreateProjectUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :project_users, id: false do |t|
      t.references :project, index: true, null: false
      t.references :user, index: true, null: false
    end

    add_index :project_users, [:user_id, :project_id]
  end
end
