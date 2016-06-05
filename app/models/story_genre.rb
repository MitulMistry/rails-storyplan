class StoryGenre < ActiveRecord::Base
  belongs_to :story
  belongs_to :genre
end
