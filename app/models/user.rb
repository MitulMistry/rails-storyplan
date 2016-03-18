class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stories
  has_many :characters
  has_many :genres, -> { distinct }, through: :stories
  has_many :chapters, through: :stories
  #has_many :audiences, -> { uniq }, through: :stories

  validates :username, presence: true, uniqueness: true
  validates :full_name, length: { maximum: 200 }
  validates :bio, length: { maximum: 4000 }
end
