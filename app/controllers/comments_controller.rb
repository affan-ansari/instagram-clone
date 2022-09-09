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
    params.require(:comment).permit(:body, :user)
  end

  def authorize_user_for_delete?(comment)
    comment.post.user == current_user || comment.user == current_user
  end

  def authorize_user_for_edit?(comment)
    comment.user == current_user
  end
end
