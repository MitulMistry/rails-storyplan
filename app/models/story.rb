require 'uri' #for URI open

class Story < ActiveRecord::Base
  include PgSearch::Model
  multisearchable against: :name
  
  belongs_to :user
  has_many :story_genres
  has_many :genres, -> { distinct }, through: :story_genres
  has_many :story_audiences
  has_many :audiences, through: :story_audiences
  has_many :chapters, dependent: :destroy #destroys all chapters belonging to it when the story is destroyed
  has_many :characters, through: :chapters
  has_many :comments
  has_one_attached :cover

  validates :name, presence: true
  validates :user_id, presence: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true
  validates :overview, length: { maximum: 4000 }

  # validates :cover, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  #   dimension: { width: { min: 300, max: 3500 },
  #   height: { min: 300, max: 3500 }, message: 'is not within dimensions' },
  #   size: { less_than: 2.megabytes , message: 'is not under file size limit' }

  extend ClassOrderable

  def cover_from_url(url) #save model after calling method
    self.cover.attach(io: URI.open(url), filename: "generated-cover.jpg")
  end

  def recent_comments
    self.comments.order('created_at DESC').limit(10) #self.comments.limit(10).order('created_at DESC').reverse #self.comments.order('created_at DESC').last(10)
  end
end
