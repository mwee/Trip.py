class AddEndDateToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :end_date, :date
  end
end
