class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.belongs_to :user
      t.column :provider, :string, null: false
      t.column :uid, :string, null: false
      t.timestamps null: false
    end

    add_index :identities, [:provider, :uid], unique: true
  end
end
