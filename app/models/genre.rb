class Genre < ActiveRecord::Base
  has_many :story_genres
  has_many :stories, through: :story_genres
  
  validates_presence_of :name
end
