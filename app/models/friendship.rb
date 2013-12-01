class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name=> 'User'
  #validates :friend_id, uniqueness: { scope: :user_id }
  def self.getReceivedInvitation(friend_id)
    return Friendship.where(friend_id:friend_id,status:"pending")
  end

  #check if the user is already the friend or send frind invitation to user with friend_id
  def self.is_friend?(user_id, friend_id)
    return Friendship.where(user_id: user_id,friend_id:friend_id).exists?  || (user_id==friend_id)
  end


  #check if the user with friend_id is being invited
  def is_invited?(friend_id)
    return (self.friend_id==friend_id)
  end


  def update
    self.status='finalized'
    self.save!
  end
  
  def createInverse
    
    inverseFriendship= Friendship.find_by(user_id:self.friend_id, friend_id:self.user_id)
    if inverseFriendship.nil?
      newFriendship=Friendship.new(user_id:self.friend_id, friend_id:self.user_id,status:"finalized")
      newFriendship.save!
      
    else
      inverseFriendship.update
    end
  end
  #update the friend_id
  def self.updateId(facebook_id, friend_id)
     Friendship.where(friend_id:facebook_id, status:'pending').each do |friendship|
        friendship.friend_id=friend_id
       friendship.save!
    end
  end

end
