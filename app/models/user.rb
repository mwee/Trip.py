class User < ActiveRecord::Base

    has_and_belongs_to_many :trips, :join_table => :added_trips
    has_many :created_trips, :class_name => "Trip", :foreign_key => :creator_id
	
    has_many :votes
	
	# Authentification
    def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			  user.provider = auth.provider
			  user.uid = auth.uid
			  user.name = auth.info.name
			  user.oauth_token = auth.credentials.token
			  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			  user.save!
        end
    end
end
