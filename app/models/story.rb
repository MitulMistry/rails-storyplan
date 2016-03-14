class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_genres
  has_many :genres, through: :story_genres
  has_many :chapters
  has_many :characters, through: :chapters

  validates_presence_of :name, :user_id
  validates :overview, length: { maximum: 2000 }
end
