class AddCostMinToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :cost_min, :float
  end
end
