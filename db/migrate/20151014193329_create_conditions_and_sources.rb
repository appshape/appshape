class CreateConditionsAndSources < ActiveRecord::Migration
  def change
    create_table :conditions_sources, id: false do |t|
      t.belongs_to :condition, index: true
      t.belongs_to :source, index: true
    end
  end
end
