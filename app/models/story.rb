class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_genres
  has_many :genres, through: :story_genres
  has_many :story_audiences
  has_many :audiences, through: :story_audiences
  has_many :chapters, dependent: :destroy #destroys all chapters belonging to it when the story is destroyed
  has_many :characters, through: :chapters
  has_many :comments

  validates :name, presence: true
  validates :user_id, presence: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true
  validates :overview, length: { maximum: 4000 }

  def recent_comments
    self.comments.order('created_at ASC').last(10) #self.comments.limit(10).order('created_at DESC').reverse
  end
end
