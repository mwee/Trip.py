class RemoveRequestIdFromFriendships < ActiveRecord::Migration
  def change
    remove_column :friendships, :request_id, :integer
  end
end
