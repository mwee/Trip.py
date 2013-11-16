class AddStartDateToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :date
  end
end
