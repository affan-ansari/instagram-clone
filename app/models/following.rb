class Following < ApplicationRecord
  validates :user_id, uniqueness: { scope: :follower_id }
  belongs_to :user
  belongs_to :follower, class_name: 'User'
end
