# frozen_string_literal: true

class FollowingPolicy
  attr_reader :user, :following

  def initialize(user, following)
    @user = user
    @following = following
  end

  def destroy?
    @following.follower == @user || @following.user == @user
  end
end
