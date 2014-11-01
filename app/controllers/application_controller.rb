class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_in?, :current_user
  
  def current_user
    return nil if session[:session_token].nil?
    @user ||= User.find_by(session_token: session[:session_token])
  end
  
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end
  
  def logged_in?
    User.find_by(session_token: session[:session_token])
  end
  
  def redirect_to_signin_if_logged_out
    redirect_to new_session_url unless logged_in?
  end
  
  def redirect_to_index_if_logged_in
    redirect_to subs_url if logged_in?
  end
  
end
