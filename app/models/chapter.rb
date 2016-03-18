class Chapter < ActiveRecord::Base
  belongs_to :story
  has_many :character_chapters
  has_many :characters, through: :character_chapters

  validates :name, presence: true
  validates :story_id, presence: true
  validates :ch_number, numericality: { only_integer: true }, allow_blank: true
  validates :objective, length: { maximum: 1000 }, allow_blank: true
  validates :overview, length: { maximum: 4000 }, allow_blank: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true

  def user
    self.story.user
  end
end