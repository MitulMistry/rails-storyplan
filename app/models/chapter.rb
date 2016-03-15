class Chapter < ActiveRecord::Base
  belongs_to :story
  has_many :character_chapters
  has_many :characters, through: :character_chapters
  
  validates_presence_of :name, :story_id
  validates :overview, length: { maximum: 2000 }  
  
  def user
    self.story.user
  end
end
