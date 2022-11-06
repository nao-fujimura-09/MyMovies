class Public::FollowsController < ApplicationController
  
  def create
    # @follow = Follow.new(follows_params)
    # @follow.save
    # redirect_back(fallback_location: root_path)
    current_user.follow(params[:user_id])
    # follows.user_id = User.find(params[:user_id])
    # redirect_to user.followings
    
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to  user.followings
  end
  
  def followings
    user = User.find(params[:user_id])
    @followers = user.followers
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
