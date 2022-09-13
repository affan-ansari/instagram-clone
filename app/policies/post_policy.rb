# frozen_string_literal: true

class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    follower = @post.user.followers.find_by(id: @user.id)
    true if @post.user == @user || @post.user.is_public || !follower.nil?
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
