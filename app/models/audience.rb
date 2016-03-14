class Audience < ActiveRecord::Base
  has_many :story_audiences
  has_many :stories, through: :story_audiences
end
