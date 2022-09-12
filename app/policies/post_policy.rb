class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
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
