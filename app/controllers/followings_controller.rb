# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :authenticate_user!, :fetch_user

  def create
    following = @user.followings.build(follower: current_user)
    following.assign_accept_status(@user)

    if following.save
      flash[:notice] = if @user.is_public
                         'Successfully create following'
                       else
                         'Successfully created Request'
                       end

    else
      flash[:alert] = following.errors.full_messages.to_sentence
    end

    redirect_to @user
  end

  def destroy
    @following = @user.followings.find_by(id: params[:id])
    authorize @following
    @following.destroy

    flash[:notice] = if @following.is_accepted
                       'Successfully destroyed following'
                     else
                       'Successfully destroyed request'
                     end
    redirect_to @user
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
    authorize @user, :show_followings?

    @followings = @user.followings.all
  end

  private

  def fetch_user
    @user = User.find(params[:user_id])
  end
end
