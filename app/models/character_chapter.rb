class CharacterChapter < ActiveRecord::Base
  belongs_to :character
  belongs_to :chapter
end
