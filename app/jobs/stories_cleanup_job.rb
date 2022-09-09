# frozen_string_literal: true

class StoriesCleanupJob < ApplicationJob
  queue_as :default

  def perform(story)
    Rails.logger.debug "Story #{story.id} has expired}"
    story.destroy
  end
end
