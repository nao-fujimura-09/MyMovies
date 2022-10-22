class Public::FollowsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    follows.user_id = User.find(params[:user_id])
    redirect_to user.followings
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
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  private
  
  def follows_params
    params.require(:follow).permit(:followe_id, :followed_id)
  end
end
