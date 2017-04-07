require 'open-uri' #for URI.parse

class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_genres
  has_many :genres, -> { distinct }, through: :story_genres
  has_many :story_audiences
  has_many :audiences, through: :story_audiences
  has_many :chapters, dependent: :destroy #destroys all chapters belonging to it when the story is destroyed
  has_many :characters, through: :chapters
  has_many :comments
  has_attached_file :cover, styles: { medium: "400x625>", small: "205x320>" }, default_url: "paperclip/:style/default_story_cover.png"

  validates :name, presence: true
  validates :user_id, presence: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true
  validates :overview, length: { maximum: 4000 }

  validates_attachment :cover, #presence: true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
    size: { in: 0..2.megabytes }

  extend ClassOrderable

  def cover_from_url(url) #save model after calling method
    self.cover = URI.parse(url)
  end

  def recent_comments
    self.comments.order('created_at DESC').limit(10) #self.comments.limit(10).order('created_at DESC').reverse #self.comments.order('created_at DESC').last(10)
  end
end
