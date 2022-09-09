class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
end
