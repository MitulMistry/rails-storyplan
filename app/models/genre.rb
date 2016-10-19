class Genre < ActiveRecord::Base
  has_many :story_genres
  has_many :stories, through: :story_genres

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 1000 }

  include Orderable
end
