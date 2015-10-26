class RequestsAddAssertionsAndDataPoints < ActiveRecord::Migration
  def change
    add_column :requests, :assertions, :json
    add_column :requests, :data_points, :json
  end
end
