class FriendshipsController < ApplicationController

  before_filter :require_login
  before_action :set_friendship, only: [:accept, :decline]
  #GET
  def new
    @friend= User.get_user(params[:email])
    if @friend.nil?
      flash[:notice] = "Invalid email"
    elsif Friendship.is_friend?(current_user.id, @friend.id)
      flash[:notice] =  "User with email "+ @friend.email+" is already your friends or invitations already sent."
    else
      @friendship = @current_user.friendships.build(friend_id: @friend.id)
      @friendship.save
      flash[:success]= "Send Friend Invitation To User With Email "+ @friend.email
    end
    redirect_to  user_show_friend_path(@current_user.id)
  end



  #POST, used for facebook invitation request
  def create
    puts "friendship creating";
    #first check if user exists
    @friend=User.get_facebook_user(params[:friend_id])
    respond_to do |format|
      if @friend.nil?
        @friendship = @current_user.friendships.build(:friend_uid=> params[:friend_uid])
        @friendship.save
        format.html { redirect_to user_show_friend_path(@current_user.id), success: 'friend invitation send' }
        format.json { render json: @friendship.to_json }
      elsif !Friendship.is_friend?(@current_user.id,@friend.id)
        puts "chaning id";
        @friendship = @current_user.friendships.build(:friend_id=>@friend.id)
        @friendship.save
        format.html { redirect_to user_show_friend_path(@current_user.id), success: 'friend invitation send' }
        format.json { render json: @friendship.to_json }
      else
        format.html { redirect_to user_show_friend_path(@current_user.id), notice:  @friend.name+" is already your friends or invitations already sent." }
        format.json { render json: @friendship.to_json }
      end

    end
  end

  # POST /friendships/1
  def accept
    # Prevents unauthorized access by other users
    if !@friendship.is_invited?(@current_user.id)
      flash[:notice] = "This friend invitation is not for you!"
      redirect_to user_show_friend_path(@current_user.id)
    return
    end
    @friendship.update()
    @friendship.createInverse()
    redirect_to user_show_friend_path(@current_user.id)
  end

  # DELETE /friendships/1
  def decline
    # Prevents unauthorized access by other users
    if !@friendship.is_invited?(@current_user.id)
      flash[:notice] = "This friend invitation is not for you!"
      redirect_to user_show_friend_path(@current_user.id)
    return
    end
    @friendship.destroy
    flash[:success] = "Invitation declined"
    redirect_to user_show_friend_path(@current_user.id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

end
