class SessionsController < ApplicationController
  #before_action :signed_in_user, :only => [:show,:profile]


  def show
    @user = User.find(params[:id])
  end

  private

# Never trust parameters from the scary internet, only allow the white list through.
 def user_params
  params.require(:user).permit(:name, :email, :password)
 end
#
end