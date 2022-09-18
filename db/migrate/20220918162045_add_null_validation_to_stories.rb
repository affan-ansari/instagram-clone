# frozen_string_literal: true

class AddNullValidationToStories < ActiveRecord::Migration[5.2]
  def change
    change_column_null :stories, :user_id, false
  end
end
