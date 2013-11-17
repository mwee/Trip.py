class AddToActivity < ActiveRecord::Migration
  def change
  	add_column :activities, :user_id, :integer
  	add_column :activities, :topic, :text
  	add_column :activities, :trip_id, :integer
  end
end
