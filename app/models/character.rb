class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_chapters
  has_many :chapters, through: :character_chapters
  has_many :stories, ->{ distinct }, through: :chapters
  has_attached_file :portrait, styles: { medium: "400x400>", thumb: "50x50>" }, default_url: "/images/paperclip/:style/default_character_portrait.png"

  validates :name, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :bio, length: { maximum: 4000 }
  validates :traits, length: { maximum: 800 }

  validates_attachment :portrait, #presence: true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
    size: { in: 0..2.megabytes }

  extend ClassOrderable
end
