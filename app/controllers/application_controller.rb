class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :allow_iframe_requests

  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end



end
