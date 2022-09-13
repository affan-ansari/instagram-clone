# frozen_string_literal: true

class StoryPolicy
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  def destroy?
    @story.user == @user
  end

  def show?
    follower = @story.user.followers.find_by(id: @user.id)
    true if @story.user == @user || @story.user.is_public || !follower.nil?
  end
end
