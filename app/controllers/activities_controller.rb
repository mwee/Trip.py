class ActivitiesController < ApplicationController
  def index
    @user = current_user
    @trips = current_user.created_trips  + current_user.trips 
    @activities = Activity.all 
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  	@activity = Activity.find(params[:id])
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  	@activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    respond_to do |format|
      if @activity.save
      	# puts @activity
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
  	@activity = Activity.find(params[:id])
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
  	@activity = Activity.find(params[:id])
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  def like
	@activity = Activity.find(params[:id])
  	@user = current_user
  	@activity.liked_by @user
  	render action: 'show'
  end

  def unlike
	@activity = Activity.find(params[:id])
	@user = current_user
  @activity.unliked_by @user
	render action: 'show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:topic)
    end

end
