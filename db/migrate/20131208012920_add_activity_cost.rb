class AddActivityCost < ActiveRecord::Migration
  def change
  	add_column :activities, :cost, :decimal
  end
end
