class AddProjectRefToTest < ActiveRecord::Migration
  def change
    add_reference :tests, :project, index: true, foreign_key: true
  end
end
