class User < ActiveRecord::Base
  acts_as_voter
  has_many :freeranges, :dependent => :destroy

  has_and_belongs_to_many :trips, :join_table => :trips_users
  has_many :created_trips, :class_name => "Trip", :foreign_key => :creator_id, :dependent => :destroy

  has_many :invitations, :class_name => "TripInvitation", :foreign_key => :invitee_id, :dependent => :destroy
  has_many :created_invitations, :class_name => "TripInvitation", :foreign_key => :inviter_id, :dependent => :destroy

  has_many :friendships
  #has_many :friends, -> {"status = 'finalized'"}, :through => :friendships
  has_many :friends, :conditions => "status = 'finalized'", :through => :friendships

  EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i

  AMOUNT_REGEX= ( /\d+\.?\d{0,2}+/i)
  validates :budget_in_min, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}, :allow_nil => true
  validates :budget_in_max, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => :budget_in_min, :less_than => 1000000},:allow_nil => true
  validates :budget_out_min, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000},:allow_nil => true
  validates :budget_out_max, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => :budget_out_min, :less_than => 1000000},:allow_nil => true
  
  # Authentification
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email=auth.info.email
      user.gender=auth.extra.raw_info.gender
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      Friendship.updateId(user.uid, user.id)
    end
  end

  #return the number of the trips that the user created or is a member of the cabal
  def get_trip_num
    user= User.find(self.id)
    num =(user.trips+user.created_trips).length
    return num
  end

  #return the number of friends
  def get_friend_num
    user = User.find(self.id)
    num = user.friends.length
    return num
  end
  
  #
  def get_invitation_num
    user = User.find(self.id)
    num = user.invitations.length
    return num
  end


  #return the user with particular email

  def self.get_user(email)
    if EMAIL_REGEX.match(email)
      user = User.find_by_email(email)
    end
    if user
      return user
    end
  end

  #return user with particular facebook uid
  def self.get_facebook_user(uid)
      user = User.find_by_uid(uid)
    if user
       return user
    end
  end

end
