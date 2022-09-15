# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    following = user.followings.build(follower: current_user)
    following.assign_accept_status(user)

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

  def update
    following = Following.find(params[:id])
    following.is_accepted = !following.is_accepted
    if following.save
      flash[:notice] = 'Accepted'
    else
      flash[:alert] = 'Sad'
    end
    redirect_to(request.referer)
  end

  def index
    # TODO: SHOW ONLY FOR LOGGEED IN USER
    user = User.find(params[:user_id])
    @followings = user.followings.all
  end
end
