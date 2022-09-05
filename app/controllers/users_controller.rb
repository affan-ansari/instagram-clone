class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user: current_user)
  end

  def index
    @users = User.all
  end
end
