# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @stories = Story.all
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      StoriesCleanupJob.set(wait: 24.hours).perform_later(@story)
      redirect_to @story
    else
      render 'new'
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    redirect_to stories_path
  end

  def show
    @story = Story.find(params[:id])
  end

  private

  def story_params
    params.require(:story).permit(:caption, :image)
  end
end
