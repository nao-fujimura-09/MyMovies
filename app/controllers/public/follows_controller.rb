class Public::FollowsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end
  
  def followings
    @user = User.find(params[:user_id]).select(status: "false")
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
  
  private
  
  def follows_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end
end
