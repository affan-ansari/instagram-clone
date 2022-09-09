# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
    # @comment = @post.comments.new(user_id: current_user.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    # @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated'
      redirect_to @post
    else
      flash[:alert] = 'Comment was not updated'
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    return unless authorize_user_for_edit?(@comment) == false

    flash[:alert] = 'Not authorized'
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if authorize_user_for_delete?(@comment) == false
      flash[:alert] = 'Not authorized'
    else
      @comment.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user_for_delete?(comment)
    comment.post.user == current_user || comment.user == current_user
  end

  def authorize_user_for_edit?(comment)
    comment.user == current_user
  end
end
