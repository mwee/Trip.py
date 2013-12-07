class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :request_id
      t.string :status, :default => "pending"

      t.timestamps
    end
    
    end
end
