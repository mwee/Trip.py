class AddLinkToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :link, :string
  end
end
