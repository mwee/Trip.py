class UsersController < ApplicationController
  #before_action :signed_in_user, :only => [:show,:profile]

  def show
    @range = Daterange.find(user_id: params[:id])
  end

  def new
    @range = Daterange.new
  end
  def create
    @range = Daterange.new(daterange_params)	
	@user = User.find(params[:id])
    respond_to do |format|
      if @range.update(user_params)
        format.html { redirect_to @range, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @range.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

# Never trust parameters from the scary internet, only allow the white list through.
 def daterange_params
  params.require(:daterange).permit(:start_date, :end_date)
 end
#
end