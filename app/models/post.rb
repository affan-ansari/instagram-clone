# frozen_string_literal: true

class Post < ApplicationRecord
  validate :validate_images_count, :validate_image_presence, :validate_image_type

  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  private

  def validate_images_count
    errors.add(:images, 'Too many images') if images.length > 10
  end

  def validate_image_presence
    errors.add(:image, 'No image attached') if images.attached? == false
  end

  def validate_image_type
    return unless images.attached?

    images.each do |image|
      if %w[image/png image/jpg image/jpeg].include?(image.content_type) == false

        errors.add(:image, 'File must be an of type jpg, jpeg or png')
      end
    end
  end
end
