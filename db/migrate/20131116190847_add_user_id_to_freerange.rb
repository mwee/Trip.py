class AddUserIdToFreerange < ActiveRecord::Migration
  def change
    add_column :freeranges, :user_id, :integer
  end
end
