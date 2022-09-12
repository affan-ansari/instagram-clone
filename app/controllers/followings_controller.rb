# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    following = user.followings.build(follower: current_user)

    if following.save
      flash[:notice] = 'Successfully Followed'
    else
      flash[:alert] = following.errors.full_messages.to_sentence
    end

    redirect_to user
  end

  def destroy
    user = User.find(params[:user_id])
    following = user.followings.find_by(id: params[:id])
    following.destroy

    flash[:notice] = 'Successfully Unfollowed'
    redirect_to user
  end
end
