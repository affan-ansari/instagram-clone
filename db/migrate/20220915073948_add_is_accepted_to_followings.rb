# frozen_string_literal: true

class AddIsAcceptedToFollowings < ActiveRecord::Migration[5.2]
  def change
    add_column :followings, :is_accepted, :boolean, default: false, null: false
  end
end
