class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :invite, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @user = current_user
    @trips = current_user.created_trips  + current_user.trips 
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
	@trip  = current_user.created_trips.create(trip_params) 
    respond_to do |format|
      if @trip.save
	    # add save the trip for invited friends
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
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
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # DELETE /trips/1
  # DELETE /trips/1.json
  #need to differentiate between deleting a whole trip a just a user from it
  def destroy
    if @user.is_trip_creator(@trip) 
	   @trip.destroy
	else 
	   @trip.users.delete(@user)
	end
    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

   def remove
     @user = current_user
	 @trip.users.find (@user.id).delete
     respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
     end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
	  @user=current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:title, :destination, :description, :link, :start_date, :end_date, :cost_min, :cost_max)
    end
end
