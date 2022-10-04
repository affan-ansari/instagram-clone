# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :authenticate_user!, :fetch_user
  before_action :fetch_following, only: %i[update destroy]

  def create
    following = @user.followings.build(follower: current_user)
    following.assign_accept_status(@user)

    if following.save
      flash[:notice] = if following.is_accepted
                         'Successfully created following'
                       else
                         'Successfully created Request'
                       end
    end

    redirect_to @user
  end

  def destroy
    authorize @following
    @following.destroy!

    flash[:notice] = if @following.is_accepted
                       'Successfully destroyed following'
                     else
                       'Successfully destroyed request'
                     end
    redirect_to @user
  end

  def update
    @following.is_accepted = params['request_status']
    unless @following.is_accepted
      flash[:alert] = 'Unable to accept'
      redirect_to user_followings_path(@user)
      return
    end

    flash[:notice] = 'Accepted' if @following.save
    redirect_to user_followings_path(@user)
  end

  def index
    authorize @user, :show_followings?

    @followings = @user.followings.all
  end

  private

  def fetch_user
    @user = User.find(params[:user_id])
  end

  def fetch_following
    @following = Following.find(params[:id])
  end
end
