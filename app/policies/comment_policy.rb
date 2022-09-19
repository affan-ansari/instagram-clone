# frozen_string_literal: true

class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    comment_owner?
  end

  alias edit? update?

  def destroy?
    comment_owner? || @comment.post.user == @user
  end

  private

  def comment_owner?
    @comment.user == @user
  end
end
