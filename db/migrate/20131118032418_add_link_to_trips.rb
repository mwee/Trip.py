class AddLinkToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :link, :text
  end
end
