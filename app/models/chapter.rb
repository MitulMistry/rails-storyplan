class Chapter < ActiveRecord::Base
  belongs_to :story
  has_many :character_chapters
  has_many :characters, through: :character_chapters

  accepts_nested_attributes_for :characters #allows creating characters in the chapter creation form

  validates :name, presence: true
  validates :story_id, presence: true
  validates :ch_number, numericality: { only_integer: true }, allow_blank: true
  validates :objective, length: { maximum: 1000 }, allow_blank: true
  validates :overview, length: { maximum: 4000 }, allow_blank: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true

  def user
    self.story.user
  end

  #custom writer/setter for use during mass assignment from form
  def character_attributes=(character_attributes)
    character_attributes.values.each do |character_attribute|
      character = Character.find_or_create_by(character_attribute)
      self.character_chapters.build(character: character) #using build on self, it already sets the chapter_id to this post for the character_chapter it's building
    end
  end
end