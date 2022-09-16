# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :accessed_user

  def initialize(user, accessed_user)
    @user = user
    @accessed_user = accessed_user
  end

  def show_posts?
    following = accessed_user.followings.find_by(follower_id: @user.id, is_accepted: true)
    @accessed_user == @user || @accessed_user.is_public || !following.nil?
  end

  def show_followings?
    @accessed_user == @user
  end
end
