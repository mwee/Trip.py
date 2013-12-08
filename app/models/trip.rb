class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :trips_users
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id

  has_many :activities, :dependent => :destroy
  has_many :trip_invitations, :dependent => :destroy

  AMOUNT_REGEX = /\d+\.?\d{0,2}+/i
  validates :cost_min, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}
  validates :cost_max, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => :cost_min, :less_than => 1000000}
  validates_date :start_date, :on_or_after => Time.now
  validates_date :end_date, :on_or_after => :start_date
  validates :title, :presence => true, length: { maximum:25}
  validates :destination, :presence => true
  validates :description, :presence => true
  validates :link, :format => URI::regexp(%w(http https))
  
  #return the trips in which the user is either the creator or in the cabal
  def self.get_all_trips(user)
    return user.created_trips  + user.trips
  end

  #Return true if the user is the creator of the trip
  def user_is_creator(user)
    trip= Trip.find(self.id)
    return trip.creator.id==user.id
  end

  #Return true if the user is in the cabal of the trip
  def user_in_cabal(user)
    trip= Trip.find(self.id)
    return (trip.users).include? user
  end

  #Return true if the user is a member of the trip
  #(member is defines as users in the cabal and the creator)
  def user_is_member(user)
    trip= Trip.find(self.id)
    return (user_in_cabal(user) or user_is_creator(user))
  end

  #Return the status of the trip for displaying UI.
  def get_status
    trip= Trip.find(self.id)
    if trip.active
      return "Active"
    else
      return "finalized"
    end
  end

  #return a list of user's friends that is not in the cabal of trip and not yet get an invitation to join the trip
  def get_uninvited_friends(user)
    trip= Trip.find(self.id)
    uninvited = user.friends-trip.users-[trip.creator]
    for invi in trip.trip_invitations
      uninvited -= [invi.invitee]
    end
    return uninvited
  end

  #return a list of unvited friends who are free during the trip time
  def get_free_uninvited_friends(user)
    trip= Trip.find(self.id)
    free_uninvited_friends=[]
    for f in trip.get_uninvited_friends(user)
      if Freerange.is_free_during(trip.start_date,trip.end_date,f)
        free_uninvited_friends += [f]
      end
    end
    return free_uninvited_friends
  end

  #update the trip active status from true to false
  def finalize
    trip= Trip.find(self.id)
    trip.update_column(:active, false)
  end

  #return true if the trip is active, false otherwise
  def is_active
    trip= Trip.find(self.id)
    return trip.active
  end
end
