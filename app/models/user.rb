# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  validate :validate_image_type, on: :update

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

  private

  def validate_image_type
    return unless image.attached?

    return unless %w[image/png image/jpg image/jpeg].include?(image.content_type) == false

    errors.add(:image, 'File must be an of type jpg, jpeg or png')
  end
end
