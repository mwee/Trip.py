class FriendshipsController < ApplicationController
  def create
    logger.info("friendship creating");

    @friendship = Friendship.new(:user_id=> params[:user_id],:friend_id=> params[:friend_id],:request_id=> params[:request_id],:status=> params[:status])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to root_path, notice: 'friendship created.' }
        format.json { render json: @friendship.to_json }
      else
        format.html {redirect_to root_path }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end

    end

  end

end
