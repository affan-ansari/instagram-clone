class AddFollowerRefToFollowings < ActiveRecord::Migration[5.2]
  def change
    add_reference :followings, :follower, references: :users, foreign_key: { to_table: :users }
    add_index :followings, %i[user_id follower_id], unique: true
  end
end
