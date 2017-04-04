class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :stories
  has_many :characters
  has_many :genres, -> { distinct }, through: :stories
  has_many :chapters, through: :stories
  has_many :comments
  #has_many :audiences, -> { uniq }, through: :stories
  has_attached_file :avatar, styles: { medium: "400x400>", thumb: "50x50>" }, default_url: "paperclip/:style/default_user_avatar.png"

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }
  validates :full_name, length: { maximum: 200 }
  validates :bio, length: { maximum: 4000 }

  validates_attachment :avatar, #presence: true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
    size: { in: 0..1.megabytes }

  extend Generatable
  extend ClassOrderable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.full_name = auth.info.name
      user.username = generate_username_for_oauth(auth.info.name) #user.full_name.parameterize.underscore + "_" + rand.to_s[2..5]
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  def ordered_updated_stories
    self.stories.order('updated_at DESC')
  end

  def current_chapters
    self.chapters.currently_writing #using scope method
  end

  def recent_stories
    self.stories.limit(3).order('updated_at DESC')
  end

  def recent_chapters
    self.chapters.limit(3).order('updated_at DESC')
  end

  def recent_characters
    self.characters.limit(3).order('updated_at DESC')
  end
end
