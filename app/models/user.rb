class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stories
  has_many :genres, through: :stories
  has_many :chapters, through: :stories
  has_many :characters, through: :chapters

  validates :username, :presence => true, uniqueness: true
end
