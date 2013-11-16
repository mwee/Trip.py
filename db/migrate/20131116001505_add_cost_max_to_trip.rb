class AddCostMaxToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :cost_max, :float
  end
end
