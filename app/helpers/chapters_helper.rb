module ChaptersHelper
  def chapter_truncated_objective(chapter)
    truncate(chapter.objective, length: 150, separator: /\s/)
  end

  def chapter_truncated_overview(chapter)
    truncate(chapter.overview, length: 250, separator: /\s/)
  end
end
