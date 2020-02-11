require 'uri' #for URI.open

class Character < ActiveRecord::Base
  include PgSearch::Model
  multisearchable against: :name

  belongs_to :user
  has_many :character_chapters
  has_many :chapters, through: :character_chapters
  has_many :stories, -> { distinct }, through: :chapters
  has_one_attached :portrait

  validates :name, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :bio, length: { maximum: 4000 }
  validates :traits, length: { maximum: 800 }

  # validates :portrait, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  #   dimension: { width: { min: 300, max: 3500 },
  #   height: { min: 300, max: 3500 }, message: 'is not within dimensions' },
  #   size: { less_than: 2.megabytes , message: 'is not under file size limit' }

  extend ClassOrderable

  def portrait_from_url(url) #save model after calling method
    self.portrait.attach(io: URI.open(url), filename: "generated-portrait.jpg")
  end
end
