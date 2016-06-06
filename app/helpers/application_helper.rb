module ApplicationHelper
  def collection_grid_check(collection)
    item = collection.first #item_class = collection.first.class #doesn't work when using case when
    return_hash = {
      items_in_row: 3,
      partial_to_render: ""
    }

    item = collection.first
    case item #case when uses ===, so check actual object instead of object class (e.g. item.class)
    when Audience
      return_hash[:items_in_row] = 4
      return_hash[:partial_to_render] = 'audiences/audience'

    when Character
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'characters/character'

    when Genre
      return_hash[:items_in_row] = 4
      return_hash[:partial_to_render] = 'genres/genre'

    when Story
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'stories/story'

    when User
      return_hash[:items_in_row] = 3
      return_hash[:partial_to_render] = 'writers/writer'
    end

    return_hash
  end

end
