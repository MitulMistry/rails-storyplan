class StoryAudience < ActiveRecord::Base
  belongs_to :story
  belongs_to :audience
end
