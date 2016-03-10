class Genre < ActiveRecord::Base
  has_many :story_genres
  has_many :stories, through: :story_genres
end
