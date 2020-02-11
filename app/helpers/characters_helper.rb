module CharactersHelper
  def character_truncated_bio(character)
    truncate(character.bio, length: 150, separator: /\s/)
  end

  def character_truncated_traits(character)
    truncate(character.traits, length: 80, separator: /\s/)
  end

  def character_card_portrait(character)
    if character.portrait.attached?
      image_tag character.portrait.variant(resize: "400x400"), class: "card-img-top img-fluid"
    else
      image_tag "default/medium/default_character_portrait.png", class: "card-img-top img-fluid"
    end
  end

  def character_image_portrait(character)
    if character.portrait.attached?
      image_tag character.portrait.variant(resize: "400x400"), class: "img-fluid"
    else
      image_tag "default/medium/default_character_portrait.png", class: "img-fluid"
    end
  end
end
