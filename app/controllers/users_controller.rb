class UsersController < ApplicationController
  
  before_action :redirect_to_signin_if_logged_out, only: [:show]
  before_action :redirect_to_index_if_logged_in, only: [:new]
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in!(@user)
      redirect_to subs_url
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
    @posts = @user.posts
    render :show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
