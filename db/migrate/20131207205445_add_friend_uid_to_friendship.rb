class AddFriendUidToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :friend_uid, :string
  end
end
