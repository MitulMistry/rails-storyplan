class Chapter < ActiveRecord::Base
  belongs_to :story
  has_many :character_chapters
  has_many :characters, through: :character_chapters

  #accepts_nested_attributes_for :characters #, reject_if: :all_blank #allows creating characters in the chapter creation form

  validates :name, presence: true
  validates :story_id, presence: true
  validates :ch_number, numericality: { only_integer: true }, allow_blank: true
  validates :objective, length: { maximum: 1000 }, allow_blank: true
  validates :overview, length: { maximum: 4000 }, allow_blank: true
  validates :target_word_count, numericality: { only_integer: true }, allow_blank: true

  scope :currently_writing, -> { where(currently_writing: true) } #sets Chapter.currently_writing class method

  extend ClassOrderable

  def user
    self.story.user
  end

  #custom writer/setter for use during mass assignment from form
  def characters_attributes=(characters_attributes)
    if !characters_attributes.nil?
      characters_attributes.values.each do |character_attribute|
        character = self.user.characters.find_or_create_by(character_attribute) #prevent duplicate characters for user #Character.find_or_create_by(character_attribute)
        character_chapter = self.character_chapters.build(character: character) #using build on self, it already sets the chapter_id to this chapter for the character_chapter it's building
        character_chapter.save
      end
    end
  end
end
