class AddActiveToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :active, :boolean , :default => true
  end
end
