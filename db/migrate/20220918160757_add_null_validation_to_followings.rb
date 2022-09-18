# frozen_string_literal: true

class AddNullValidationToFollowings < ActiveRecord::Migration[5.2]
  def change
    change_column_null :followings, :user_id, false
    change_column_null :followings, :follower_id, false
  end
end
