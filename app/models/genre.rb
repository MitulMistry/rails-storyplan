class Genre < ActiveRecord::Base
  has_many :story_genres
  has_many :stories, through: :story_genres
  
  validates :name, presence: true
  validates :description, presence: true
end
