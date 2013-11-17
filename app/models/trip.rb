class Trip < ActiveRecord::Base
     has_and_belongs_to_many :users, :join_table => :trips_users
     belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
	 
	 has_many :activities
	 #has_many :logistics
	 
	AMOUNT_REGEX= /\d+\.?\d{0,2}+/i
	validates :cost_min, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}
	validates :cost_max, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}
	validates_date :start_date, :on_or_after => Time.now
	validates_date :end_date, :on_or_after => :start_date
	validates :title, :presence => true
	validates :destination, :presence => true
	 
	 #Return true if the user is the creator of the trip
	 def user_is_creator
	 end
	 #Return true if the user is a member of the trip(including the creator )
	 def user_is_member
	 end
end
