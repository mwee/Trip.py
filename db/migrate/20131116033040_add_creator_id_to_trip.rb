class AddCreatorIdToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :creator_id, :integer
  end
end
