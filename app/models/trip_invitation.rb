class TripInvitation < ActiveRecord::Base
    belongs_to :trip
	belongs_to :inviter, :class_name => "User", :foreign_key => :inviter_id
    belongs_to :invitee, :class_name => "User", :foreign_key => :invitee_id
	
		#if the contributor is the collector, then save status as approved.
    def self.create(inviter, invitee, trip)
		invitation=trip.trip_invitations.new("inviter_id" => inviter.id, "invitee_id" => invitee.id,)
		return invitation
    end
	
	#delete the invitation and add the invitee to the cabal of the trip
	def accept()
	    @invi= TripInvitation.find(self.id) 
		@invi.trip.users << @invi.invitee
		@invi.destroy		
	end
	
	#delete the invitation
	def decline()
		@invi= TripInvitation.find(self.id) 
		@invi.destroy
	end
end
