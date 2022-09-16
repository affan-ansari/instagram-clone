# frozen_string_literal: true

class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    following = @post.user.followings.find_by(follower_id: @user.id, is_accepted: true)
    @post.user == @user || @post.user.is_public || !following.nil?
  end

  def update?
    @post.user == @user
  end

  def edit?
    @post.user == @user
  end

  def destroy?
    @post.user == @user
  end
end
