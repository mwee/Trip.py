class User < ActiveRecord::Base

    has_many :freeranges
    has_and_belongs_to_many :trips, :join_table => :trips_users
    has_many :created_trips, :class_name => "Trip", :foreign_key => :creator_id
	
    #has_many :votes
	
	AMOUNT_REGEX= ( /\d+\.?\d{0,2}+/i)
	validates :budget_in_min, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}, :allow_nil => true
	validates :budget_in_max, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000},:allow_nil => true
	validates :budget_out_min, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000},:allow_nil => true
	validates :budget_out_max, :format => AMOUNT_REGEX, :numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000},:allow_nil => true
	
	# Authentification
    def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			  user.provider = auth.provider
			  user.uid = auth.uid
			  user.name = auth.info.name
			  user.image=auth.info.image
			  user.oauth_token = auth.credentials.token
			  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			  user.save!
        end
    end
end
