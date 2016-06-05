class Audience < ActiveRecord::Base
  has_many :story_audiences
  has_many :stories, through: :story_audiences

  validates :name, presence: true

  include Orderable
end
