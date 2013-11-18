class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  
  def self.addFriend(friend_id, friend_user_id)
    Friendship.where(friend_id:friend_id, status: "pending").each do |friendship|
      transaction do
      friendship.status="finalized"
      friendship.friend_id=friend_user_id
      friendship.save!
      inverse_friendship=Friendship.create(user_id:friend_user_id,friend_id:friendship.user_id,request_id:friendship.request_id,status:"finalized")
      inverse_friendship.save!
      end
    end
  end
  


end
