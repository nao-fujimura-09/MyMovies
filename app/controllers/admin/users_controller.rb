class Admin::UsersController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @users = User.all
    if params[:id] == "0" #有効
      @users = User.where(status: false)
    elsif params[:id] == "1" #退会
      @users = User.where(status: true)
    elsif params[:id] == "2" #全て
      @users = User.all
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @views = @user.views.select(:movie_id).distinct
    @reviews = Review.where("title!='' OR body!=''").where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    @genres = Tmdb::Genre.movie_list
  end
    
  def update 
    @user = User.find(params[:id])
    
    FavoriteGenre.where(user_id: @user.id).destroy_all
    params[:user][:favorite_genres].compact_blank.each do |genre_id|
      FavoriteGenre.create!(user_id: @user.id, genre_id: genre_id.to_i)
    end
    @user.update!(user_params.except(:favorite_genres)) #exceptでfavorite_genres以外をupdate(上で保存しているため)
    redirect_to admin_user_path(@user.id)
  end
    
  def before_user_select
    redirect_to admin_users_path(id: params[:user_select])
  end
  
  def user_select
  end

  def withdrawal
      @user = User.find(params[:id])
      if @user.update(status: true)
          flash[:alert] = "本当に退会にしてもよろしいですか？"
      end
      reset_session
      redirect_to admin_user_path(@user.id)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :favorite_movie, :status, :favorite_genres, :profile_image)
  end
end
