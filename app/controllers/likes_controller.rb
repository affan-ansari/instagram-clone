# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    flash[:alert] = @like.errors.full_messages.to_sentence unless @like.save

    @post = @like.post
    respond_to do |format|
      format.html { redirect_to post_path(@like.post) }
      format.js { render 'update_likes.js.erb' }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    authorize @like
    @post = @like.post

    @like.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@like.post) }
      format.js { render 'update_likes.js.erb' }
    end
    # redirect_to @post
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
