class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_genres
  has_many :genres, through: :story_genres
  has_many :story_audiences
  has_many :audiences, through: :story_audiences
  has_many :chapters, dependent: :destroy #destroys all chapters belonging to it when the story is destroyed
  has_many :characters, through: :chapters

  validates :name, presence: true
  validates :user_id, presence: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true
  validates :overview, length: { maximum: 4000 }
end
