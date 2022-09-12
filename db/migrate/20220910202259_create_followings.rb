# frozen_string_literal: true

class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
