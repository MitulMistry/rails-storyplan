module StoriesHelper
  def story_truncated_overview(story)
    truncate(story.overview, length: 150, separator: /\s/)
  end

  def story_card_cover(story)
    if story.cover.attached?
      image_tag story.cover.variant(resize: "400x650"), class: "card-img-top img-fluid"
    else
      image_tag "default/medium/default_story_cover.png", class: "card-img-top img-fluid"
    end
  end

  def story_image_cover(story)
    if story.cover.attached?
      image_tag story.cover.variant(resize: "400x650"), class: "img-fluid"
    else
      image_tag "default/medium/default_story_cover.png", class: "img-fluid"
    end
  end
end
