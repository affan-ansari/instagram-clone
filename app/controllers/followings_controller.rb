# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :authenticate_user!

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
    @following = user.followings.find_by(id: params[:id])
    authorize @following
    @following.destroy

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
    user = User.find(params[:user_id])
    authorize user, :show_followings?

    @followings = user.followings.all
  end
end
