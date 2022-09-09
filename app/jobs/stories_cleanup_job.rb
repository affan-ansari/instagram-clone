class StoriesCleanupJob < ApplicationJob
  queue_as :default

  def perform(story)
    puts "Story #{story.id} has expired}"
    story.destroy
  end
end
