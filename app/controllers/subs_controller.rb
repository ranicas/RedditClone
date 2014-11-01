class SubsController < ApplicationController

  before_action :redirect_to_signin_if_logged_out
  before_action :only_moderator_allow_edit, only: [:update, :edit]
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(subs_params.merge({moderator_id: current_user.id}))
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update(subs_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def index
    @subs = Sub.all.order(:title)
    render :index
  end
  
  private
  
  def subs_params
    params.require(:sub).permit(:title, :description)
  end
  
  def only_moderator_allow_edit
    unless current_user.id == Sub.find(params[:id]).moderator_id
      redirect_to subs_url
    end
  end
end
