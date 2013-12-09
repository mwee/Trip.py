class AddFriendUidToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :friend_uid, :string
    add_index :friendships, [:user_id, :friend_id], :unique => true
    add_index :friendships, [:user_id, :friend_uid], :unique => true
  end
end
