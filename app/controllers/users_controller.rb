# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user: @user)
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
