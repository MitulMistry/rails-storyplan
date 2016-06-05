module StoriesHelper
  def story_truncated_overview(story)
    truncate(story.overview, length: 150, separator: /\s/)
  end
end
