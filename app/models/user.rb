# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :followings, dependent: :destroy
  has_many :followers, through: :followings

  has_many :inverse_followings,
           class_name: 'Following',
           foreign_key: 'follower_id',
           dependent: :destroy

  has_many :follows, through: :inverse_followings, source: :user, dependent: :destroy
end
