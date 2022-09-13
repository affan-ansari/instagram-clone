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
end
