class Character < ActiveRecord::Base
  has_many :character_chapters
  has_many :chapters, through: :character_chapters
end
