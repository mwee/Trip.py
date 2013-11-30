class FriendshipsController < ApplicationController
  
    before_filter :require_login
  
  def new
     @friend= User.get_user(params[:email])
      if @friend.nil?
        flash[:notice] = "Invalid email"
         elsif Friendship.is_friend?(current_user.id, @friend.id)
        flash[:notice] =  "User with"+ @friend.email+" is already your friends or invitations already sent."
      else
     @friendship = @current_user.friendships.build(friend_id: @friend.id)
      @friendship.save
      flash[:success]= "Send Friend Invitation To User With Email "+ @friend.email
      end
      redirect_to  user_show_friend_path(@current_user.id) 
  end

  def create
      @friend= User.get_user(params[:email])
      #first check if user exists
      if @friend.nil?
        flash[:notice] = "Invalid email"
      elsif Frienship.is_friend?(current_user.id, @friend.id)
        flash[:notice] =  "User with"+ @friend.email+" is already your friends or invitations already sent."
      else
        @friendship = Friendship.new(:user_id=> current_user.id,:friend_id=> @friend.id)
        @friendship.save
        flash[:success]= "Send Friend Invitation To User With Email "+ @friend.email
      end
    redirect_to  user_show_friend_path(current_user.id) 
  end



  def createFacebook
    logger.info("friendship creating");
    @friendship = Friendship.new(:user_id=> params[:user_id],:friend_id=> params[:friend_id])
    respond_to do |format|
      if Friendship.is_friend?(params[:user_id],params[:friend_id])

        format.html { redirect_to new_friendship_path, notice: '' }
        format.json { render json: @friendship.to_json }
      elsif
      @friendship.save
        format.html { redirect_to root_path, notice: 'friendship created.' }
        format.json { render json: @friendship.to_json }
      else
        format.html {redirect_to root_path }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end

    end

  end

  private

#def friendship_params
#  params.require(:friendship).permit(:user_id, :friend_id)
#end

end
