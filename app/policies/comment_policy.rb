class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    @comment.user == @user
  end

  def edit?
    @comment.user == @user
  end

  def destroy?
    @comment.user == @user || @comment.post.user == @user
  end
end
