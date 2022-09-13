# frozen_string_literal: true

module UsersHelper
  def profile_status(user)
    user.is_public ? 'Public' : 'Private'
  end
end
