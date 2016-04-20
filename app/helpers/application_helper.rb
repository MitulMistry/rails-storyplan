module ApplicationHelper
  def collection_grid_check_items_in_row(collection)
    item_class = collection.first.class
    if item_class == Audience
      4
    elsif item_class == Character
      3
    elsif item_class == Genre
      4
    elsif item_class == Story
      3
    elsif item_class == Writer
      3
    else
      3
    end
  end

  def collection_grid_render_partial(item)
    item_class = item.class
    if item_class == Audience
      render partial: 'audiences/audience', locals: { audience: item }
    elsif item_class == Character
      render partial: 'characters/character', locals: { character: item }
    elsif item_class == Genre
      render partial: 'genres/genre', locals: { genre: item }
    elsif item_class == Story
      render partial: 'stories/story', locals: { story: item }
    elsif item_class == Writer
      render partial: 'writers/writer', locals: { writer: item }
    end
  end

end
