class Trip < ActiveRecord::Base

     has_and_belongs_to_many :users, :join_table => :added_trips
     belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
	 
	 #has_many :activities
	 #has_many :logistics
	 
	 #Return true if the user is the creator of the trip
	 def user_is_creator
	 end
	 #Return true if the user is a member of the trip(including the creator)
	 def user_is_member
	 end
end
