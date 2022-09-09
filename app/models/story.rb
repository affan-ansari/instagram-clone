# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validate :validate_image_presence, :validate_image_type

  private

  def validate_image_presence
    errors.add(:image, 'No image attached') if image.attached? == false
  end

  def validate_image_type
    return unless image.attached? && %w[image/png image/jpg image/jpeg].include?(image.content_type) == false

    errors.add(:image, 'File must be an of type jpg, jpeg or png')
  end
end
