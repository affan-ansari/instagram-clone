class FollowingsController < ApplicationController
  def create
    @following = current_user.followings.build(follower_id: params[:follower_id])
    if @following.save
      flash[:notice] = 'Successfully created Follow'
    else
      flash[:alert] = @following.errors.full_messages.to_sentence
    end
    redirect_to users_path
  end

  def destroy
    puts 'Follow create action------------------------'
    flash[:notice] = 'Successfully destroyed Follow'
    redirect_to 'users'
  end
end
