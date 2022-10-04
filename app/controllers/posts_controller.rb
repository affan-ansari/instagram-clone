# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_post, except: %i[index new create]

  def index
    followed_user_ids = Following.where(follower: current_user, is_accepted: true).pluck(:user_id)
    @posts = Post.where(user: followed_user_ids)
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
      flash[:alert] = 'Post was not created'
      render 'new'
    end
  end

  def update
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
    authorize @post

    @post.destroy!

    flash[:notice] = 'Post was successfully destroyed'
    redirect_to user_path(current_user)
  end

  def show
    authorize @post
  end

  def edit
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def post_update_params
    params.require(:post).permit(:caption)
  end

  def fetch_post
    @post = Post.find(params[:id])
  end
end
