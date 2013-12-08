class UsersController < ApplicationController
  before_filter :require_login
  def show
    @freeranges=@current_user.freeranges
  end

  def show_friend
    @friends= @current_user.friends.all
    @invitations=Friendship.getReceivedInvitation(@current_user.id)
    @invitations_users=@invitations.map { |invitation| User.find(invitation.user_id) }
  end

  def edit_destination
  end

  def edit_budget
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user}
        format.json { head :no_content }
      else
        format.html { render action: 'edit_budget'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :destination, :budget_in_min, :budget_in_max, :budget_out_min, :budget_out_max)
    end
end