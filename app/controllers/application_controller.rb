class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :allow_iframe_requests

  helper_method :current_user, :require_login

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless session[:user_id]
        redirect_to root_path
    end

    current_user
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

end
