# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user: @user)
    @following = @user.followings.find_by(user_id: @user.id, follower_id: current_user.id)
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
