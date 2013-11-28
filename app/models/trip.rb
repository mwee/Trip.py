class Trip < ActiveRecord::Base
     has_and_belongs_to_many :users, :join_table => :trips_users
     belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
	 
	 has_many :activities, :dependent => :destroy
	 has_many :trip_invitations, :dependent => :destroy
	 #has_many :logistics
	 
	AMOUNT_REGEX= /\d+\.?\d{0,2}+/i
	validates :cost_min, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}
	validates :cost_max, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => :cost_min, :less_than => 1000000}
	validates_date :start_date, :on_or_after => Time.now
	validates_date :end_date, :on_or_after => :start_date
	validates :title, :presence => true, length: { maximum:25}
	validates :destination, :presence => true
	validates :description, :presence => true
	 
	 #Return true if the user is the creator of the trip
	 def user_is_creator
	 end
	 #Return true if the user is a member of the trip(including the creator )
	 def user_is_member
	 end
	 
	 def get_status
		trip= Trip.find(self.id) 
		if trip.active
			return "Active"
		else
			return "finalized"
		end
	 end
	 
	 #return a list of friends that is not a memeber of the trip and not yet get an invitation to join the trip
	 #TODO: CHANGE!!!
	 def get_uninvited_friends(user)
	   trip= Trip.find(self.id) 
	   users= User.all #user.friends
	   uninvited = users-trip.users
	   uninvited -= [trip.creator]
	   for invi in trip.trip_invitations
	      uninvited -= [invi.invitee]
	   end
	   return uninvited
	 end
	 
	 def get_free_uninvited_friends(user)
	     trip= Trip.find(self.id) 
	     uninvited=trip.get_uninvited_friends(user)
		 free_uninvited_friends=[]
		 for f in uninvited
		    if Freerange.is_free_during(trip.start_date,trip.end_date,f)
			    free_uninvited_friends += [f]
			end
		 end
		 return free_uninvited_friends
	 end
end
