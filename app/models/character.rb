class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_chapters
  has_many :chapters, through: :character_chapters
  has_many :stories, ->{ distinct }, through: :chapters

  validates :name, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :bio, length: { maximum: 4000 }
  validates :traits, length: { maximum: 800 }

  extend ClassOrderable
end
