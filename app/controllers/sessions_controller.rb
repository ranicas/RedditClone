class SessionsController < ApplicationController
  
  before_action :redirect_to_index_if_logged_in, only: [:new]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.authenticate_user(
    params[:user][:username],
    params[:user][:password]
    )
    
 
    if @user.nil?
      @user = User.new
      render :new
    else
      log_in!(@user)
      redirect_to subs_url
    end
      
  end
  
  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end
end
