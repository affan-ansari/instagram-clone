class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validate :validate_images

  private

  def validate_images
    errors.add(:images, 'Too many images') if images.length > 10
  end
end
