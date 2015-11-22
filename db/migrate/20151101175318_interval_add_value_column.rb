class IntervalAddValueColumn < ActiveRecord::Migration
  def change
    add_column :intervals, :value, :integer
  end
end
