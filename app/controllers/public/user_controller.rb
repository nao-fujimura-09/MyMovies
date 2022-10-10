class Public::UserController < ApplicationController
  
  def show
  end

  def edit
    @user = current_user
  end

  def comfirm
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :favorite_movie, :favorite_genre1, :favorite_genre2, :profile_image)  
  end
end
