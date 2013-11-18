class UsersController < ApplicationController
  #before_action :signed_in_user, :only => [:show,:profile]
  
  
  def show
     @user = current_user
	 @freeranges=@user.freeranges
  end

  def show_friend
     @user = current_user
     @freeranges=@user.freeranges	 
     @friends=User.all-[@user]#need to changed to @user.friends	 
  end
  
  def edit_destination
     @user = current_user
  end
  
  def edit_budget
     @user = current_user
  end
  
   def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit_budget'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  private

# Never trust parameters from the scary internet, only allow the white list through.
 def user_params
    params.require(:user).permit(:name, :email, :password, :destination, :budget_in_min, :budget_in_max, :budget_out_min, :budget_out_max)
 end
 
#
end