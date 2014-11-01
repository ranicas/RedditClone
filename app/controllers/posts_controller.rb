class PostsController < ApplicationController
  
  before_action :editor_must_be_author, only: [:update, :edit]
  
  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end
  
  def create
    @post = Post.new(post_params.merge({ author_id: current_user.id})) 
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])    
  end

  def editor_must_be_author
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless current_user.id == @post.author_id 
  end
  
end
