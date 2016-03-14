class Character < ActiveRecord::Base
  has_many :character_chapters
  has_many :chapters, through: :character_chapters

  validates_presence_of :name
  validates :bio, length: { maximum: 2000 }
end
