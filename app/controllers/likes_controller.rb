# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    flash[:alert] = @like.errors.full_messages.to_sentence unless @like.save

    redirect_to post_path(@like.post)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    post = @like.post

    @like.destroy

    redirect_to post
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
