# frozen_string_literal: true

class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    following = @post.user.followings.find_by(follower_id: @user.id, is_accepted: true)
    post_owner? || @post.user.is_public || !following.nil?
  end

  def update?
    post_owner?
  end

  alias edit? update?
  alias destroy? update?

  private

  def post_owner?
    @post.user == @user
  end
end
