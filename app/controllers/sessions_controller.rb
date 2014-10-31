class SessionsController < ApplicationController
  
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
      redirect_to user_url(@user)
    end
      
  end
  
  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end
end
