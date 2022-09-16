# frozen_string_literal: true

module UsersHelper
  def profile_status(user)
    user.is_public ? 'Public' : 'Private'
  end

  def get_followers(user)
    user.followers.where(followings: { is_accepted: true })
  end

  def get_follows(user)
    user.follows.where(followings: { is_accepted: true })
  end

  def get_posts(user)
    user.posts
  end

  def get_following(user)
    user.followings.find_by(follower_id: current_user.id)
  end
end
