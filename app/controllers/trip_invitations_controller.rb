class TripInvitationsController < ApplicationController
  before_filter :require_login
  before_action :set_trip_invitation, only: [:show, :accept, :decline]
  before_action :user_is_invitee, only: [:accept, :decline]

  # GET /trip_invitations
  # GET /trip_invitations.json
  def index
    @user = current_user
    @trip_invitations = @user.invitations
  end


  # GET /trip_invitations/new
  def new
    @trip = Trip.find(params[:id])
	@trip_invitation = TripInvitation.new
	@friends=@trip.get_uninvited_friends(current_user)
	@free_friends=@trip.get_free_uninvited_friends(current_user)
	@num_free_friends=@free_friends.length
	@no_free_friends=@friends-@free_friends
  end

  # POST /trip_invitations
  # POST /trip_invitations.json
  def create	
	@trip=Trip.find(params[:id])
    @friends=@trip.get_uninvited_friends(current_user)
	count=0
	params[:friends].each do |f|	
		if f
		    TripInvitation.create(current_user, @friends[count], @trip) 						
		end
		count = count + 1
	end
	if count>=1
	   flash[:notice] = "Invitation successfully sent."
	end
    redirect_to @trip	
  end
  
  #accept a trip invitation
  def accept
     @trip=Trip.find(@trip_invitation.trip.id)
	 @trip_invitation.accept	 
	 flash[:notice] ="Successfully join the trip. You are now part of the cabal."
	 redirect_to @trip
  end
  
  #decline a trip invitation
  def decline
	 @trip_invitation.decline
	 redirect_to trip_invitations_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_invitation
      @trip_invitation = TripInvitation.find(params[:id])
	  @user=current_user
    end

    def trip_invitation_params
      params[:trip_invitation]
    end
	
	#return true if the user is the person invited
	def user_is_invitee
	    if !@trip_invitation.is_invitee(@user)
	        redirect_to(:controller => 'trip_invitations', :action => 'index')  
	    end
	end
end
