class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_show_path(user.id)   

 end
     
  def new
    if current_user
      redirect_to user_show_path(current_user.id)
    else
      render "new"
    end
  end
    
 

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end