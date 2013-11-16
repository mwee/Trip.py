class AddUserIdToFreerange < ActiveRecord::Migration
  def change
    add_column :freeranges, :user_id, :interger
  end
end
