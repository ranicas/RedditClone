class UsersController < ApplicationController
  
  before_action :redirect_to_signin, only: [:show]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new 
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_url
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
