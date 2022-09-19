# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, :fetch_post
  before_action :fetch_comment, only: %i[update edit destroy]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    authorize @comment

    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated'
      redirect_to @post
    else
      flash[:alert] = 'Comment was not updated'
      render 'edit'
    end
  end

  def edit
    authorize @comment
  end

  def destroy
    authorize @comment

    @comment.destroy!

    flash[:notice] = 'Comment destroyed successfully'
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def fetch_post
    @post = Post.find(params[:post_id])
  end

  def fetch_comment
    @comment = @post.comments.find(params[:id])
  end
end
