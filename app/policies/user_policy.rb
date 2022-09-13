# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :accessed_user

  def initialize(user, accessed_user)
    @user = user
    @accessed_user = accessed_user
  end

  def show_posts?
    follower = @accessed_user.followers.find_by(id: @user.id)
    @accessed_user == @user || @accessed_user.is_public || !follower.nil?
  end
end
