class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :test

      t.column :url, :string, null: false
      t.column :http_method, :string, null: false
      t.column :description, :text, null: false
      t.column :basic_auth_user, :string
      t.column :basic_auth_password, :string
      t.column :headers, :json
      t.column :url_params, :json
      t.column :form_params, :json
      t.column :body, :text
      t.timestamps null: false
    end
  end
end
