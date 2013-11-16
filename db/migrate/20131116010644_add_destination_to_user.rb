class AddDestinationToUser < ActiveRecord::Migration
  def change
    add_column :users, :destination, :text
  end
end
