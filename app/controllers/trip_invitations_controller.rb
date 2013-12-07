class TripInvitationsController < ApplicationController
  before_filter :require_login
  before_action :set_trip_invitation, only: [:show, :edit, :update, :destroy, :accept, :decline]

  # GET /trip_invitations
  # GET /trip_invitations.json
  def index
    @user = current_user
    @trip_invitations = @user.invitations
  end

  # GET /trip_invitations/1
  # GET /trip_invitations/1.json
  def show
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

  # GET /trip_invitations/1/edit
  def edit
  end

  # POST /trip_invitations
  # POST /trip_invitations.json
  def create	
	@trip=Trip.find(params[:id])
    @friends=@trip.get_uninvited_friends(current_user)
	@count=-1
	params[:friends].each do |f|
		@count = @count + 1
		if f
		    @invitee = @friends[@count]
		    @trip_invitation = TripInvitation.create(current_user, @invitee, @trip) 				
		    #	@invitee.invitations << @trip_invitation
			@trip_invitation.save	
		end
		
	end
    redirect_to @trip
	
  end

  # PATCH/PUT /trip_invitations/1
  # PATCH/PUT /trip_invitations/1.json
  def update
    respond_to do |format|
      if @trip_invitation.update(trip_invitation_params)
        format.html { redirect_to @trip_invitation, notice: 'Trip invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
     @trip=Trip.find(@trip_invitation.trip.id)
	 @trip_invitation.accept()	 
	 redirect_to @trip
  end
  
  def decline
	 @trip_invitation.decline()
	 @trip_invitations = @user.invitations
	 redirect_to trip_invitations_path
  end
  
  # DELETE /trip_invitations/1
  # DELETE /trip_invitations/1.json
  def destroy
    @trip_invitation.destroy
    respond_to do |format|
      format.html { redirect_to trip_invitations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_invitation
      @trip_invitation = TripInvitation.find(params[:id])
	  @user=current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_invitation_params
      params[:trip_invitation]
    end
end
