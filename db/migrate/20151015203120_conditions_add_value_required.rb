class ConditionsAddValueRequired < ActiveRecord::Migration
  def change
    add_column :conditions, :value_required, :boolean, null: false, default: true
  end
end
