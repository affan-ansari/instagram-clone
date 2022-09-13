# frozen_string_literal: true

class LikePolicy
  attr_reader :user, :like

  def initialize(user, like)
    @user = user
    @like = like
  end

  def destroy?
    @like.user == @user
  end
end
