class TripInvitation < ActiveRecord::Base
    belongs_to :trip
  	belongs_to :inviter, :class_name => "User", :foreign_key => :inviter_id
    belongs_to :invitee, :class_name => "User", :foreign_key => :invitee_id
	
	# Create an invitation
    def self.create(inviter, invitee, trip)
		invitation=trip.trip_invitations.new("inviter_id" => inviter.id, "invitee_id" => invitee.id,)
		invitation.save	  
    end
	
	#delete the invitation and add the invitee to the cabal of the trip
	def accept()
		self.trip.users << self.invitee
		self.destroy()	
	end
	
	#delete the invitation
	def decline()
		self.destroy()
	end
	
	#Return true if the user is the invitee for the invitation
	def is_invitee(user)
		return self.invitee.id==user.id
	end
end
