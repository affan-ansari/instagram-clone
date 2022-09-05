class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.where.not(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_update_params)
      flash[:notice] = 'Post was successfully updated'
      redirect_to @post
    else
      flash[:alert] = 'Post was not updated'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to user_path(current_user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def post_update_params
    params.require(:post).permit(:caption)
  end
end