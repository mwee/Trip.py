class TripsController < ApplicationController
  before_filter :require_login
  before_action :set_trip, only: [:show, :edit, :update, :finalize, :destroy, :leavecabal]
  
  # Check for correct permission for the user to do a certain action
  before_action :user_is_creator, only: [:destroy,:edit,:finalize]
  before_action :user_is_in_cabal, only: [:leavecabal]
  before_action :user_is_member, only: [:show]
  
  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.get_all_trips(@current_user)
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @activities=@trip.activities
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
	  @trip  = @current_user.created_trips.create(trip_params) 
    respond_to do |format|
      if @trip.save
	    flash[:notice] ='Trip was successfully created.'
        format.html { redirect_to @trip}	
        format.json { render action: 'show', status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
	    flash[:notice] = 'Trip was successfully updated.' 
        format.html { redirect_to @trip}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #Finalizing a trip change active status from true to false
  def finalize
     @trip.finalize
	   redirect_to trips_path
  end
  
  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
	   @trip.destroy
     respond_to do |format|
       format.html { redirect_to trips_url }
       format.json { head :no_content }
	   end
  end
  
  #leave the cabal
  def leavecabal
	   @trip.users.find (@current_user.id).delete
     respond_to do |format|
       format.html { redirect_to trips_url }
       format.json { head :no_content }
     end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:title, :destination, :description, :link, :start_date, :end_date, :cost_min, :cost_max, :active)
    end
	
	#Redirect to user trip index page if the user is not the creator of the trip
	def user_is_creator
	    if ! @trip.user_is_creator(@current_user)
		    redirect_to(:controller => 'trips', :action => 'index')  
       end
	end
	
	#Redirect to user trip index page if the user is not in the cabal of the trip
	def user_in_cabal
	    if ! @trip.user_in_cabal(@current_user)
			redirect_to(:controller => 'trips', :action => 'index')  
       end
	end
	
	#Redirect to user trips page if the user is not a member of the trip
	def user_is_member
	   if !@trip.user_is_member(@current_user)
	   		redirect_to(:controller => 'trips', :action => 'index')  
       end
	end
	
end
