# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_story, only: %i[show destroy]

  def index
    followed_user_ids = Following.where(follower: current_user, is_accepted: true).pluck(:user_id)
    @stories = Story.where(user: followed_user_ids)
                    .or(Story.where(user: current_user)).order('user_id, created_at').includes(:user)
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
    # @story = Story.find(params[:id])
    authorize @story

    @story.destroy!

    flash[:notice] = 'Story destroyed successfully'
    redirect_to stories_path
  end

  def show
    # @story = Story.find(params[:id])
    authorize @story
  end

  private

  def story_params
    params.require(:story).permit(:caption, :image)
  end

  def fetch_story
    @story = Story.find(params[:id])
  end
end
