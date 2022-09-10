class Following < ApplicationRecord
  validates :user_id, uniqueness: { scope: :follower_id }
  validate :user_can_not_be_self_follower
  belongs_to :user
  belongs_to :follower, class_name: 'User'

  def user_can_not_be_self_follower
    errors.add(:follower_id, 'User cannot be self-follower') if user_id == follower_id
  end
end
