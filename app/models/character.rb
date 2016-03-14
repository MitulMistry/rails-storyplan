class Character < ActiveRecord::Base
  has_many :character_chapters
  has_many :chapters, through: :character_chapters
  has_many :stories, through: :chapters
  has_many :users, through: :stories

  validates_presence_of :name
  validates :bio, length: { maximum: 2000 }

  def user #weird situation where it has users through stories, but you only have one user that's the same throughout
    self.users.first
  end
end
