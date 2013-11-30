class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name=> 'User'

validates :friend_id, uniqueness: { scope: :user_id }

  
  def self.addFriend(friend_id, friend_user_id)
    Friendship.where(friend_id:friend_id, status: "pending").each do |friendship|
      transaction do
      friendship.status="finalized"
      friendship.friend_id=friend_user_id
      friendship.save!
      inverse_friendship=Friendship.create(user_id:friend_user_id,friend_id:friendship.user_id,status:"finalized")
      inverse_friendship.save!
      end
    end
  end
  
  
  def self.getReceivedInvitation(friend_id)
    return Friendship.where(friend_id:friend_id)  
  end


  def self.is_friend?(user_id, friend_id)
    return Friendship.where(user_id: user_id,friend_id:friend_id).exists?  || user_id==friend_id
  end
  

  def self.updateId(friend_id, friend_user_id)
     Friendship.where(friend_id:friend_id, status: "pending").each do |friendship|
      friendship.friend_id=friend_user_id
      friendship.save!

  end
  end
end
