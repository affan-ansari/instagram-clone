# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user: @user)
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
