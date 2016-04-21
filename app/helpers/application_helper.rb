module ApplicationHelper
  def collection_grid_check(collection)
    item_class = collection.first.class
    return_hash = {
      items_in_row: 3,
      partial_to_render: ""
    }

    if item_class == Audience
      return_hash[:items_in_row] = 4
      return_hash[:partial_to_render] = 'audiences/audience'

    elsif item_class == Character
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'characters/character'

    elsif item_class == Genre
      return_hash[:items_in_row] = 4
      return_hash[:partial_to_render] = 'genres/genre'

    elsif item_class == Story
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'stories/story'

    elsif item_class == User
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'writers/writer'
    end

    return_hash
  end

end
