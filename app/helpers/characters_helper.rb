module CharactersHelper
  def character_truncated_bio(character)
    truncate(character.bio, length: 150, separator: /\s/)
  end

  def character_truncated_traits(character)
    truncate(character.traits, length: 80, separator: /\s/)
  end
end
