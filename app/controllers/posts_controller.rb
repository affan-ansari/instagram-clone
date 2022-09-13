# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.where(user: current_user.follows)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

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
    authorize @post

    @post.destroy

    flash[:notice] = 'Post was successfully destroyed'
    redirect_to user_path(current_user)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def post_update_params
    params.require(:post).permit(:caption)
  end
end
