class User < ActiveRecord::Base
	acts_as_voter

    has_many :freeranges
    has_and_belongs_to_many :trips, :join_table => :trips_users
    has_many :created_trips, :class_name => "Trip", :foreign_key => :creator_id
	

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
			  #user.image=auth.info.image
			  user.oauth_token = auth.credentials.token
			  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			  user.save!
        end
    end
	
     #return the number of the trips that the user created or is a member of the cabal
	def get_trip_num()
	    user= User.find(self.id) 
		num =(user.trips+user.created_trips).length
	    return num
	end
	
	#return the number of friends
	def get_friend_num
	    user = User.find(self.id) 
		num = User.all.length-1 #TODO: user.friends.length
	    return num
	end
	
	#Return true if the user is the creator of the trip
	def is_trip_creator(trip)
	    return self.id==trip.creator.id
	end
end
