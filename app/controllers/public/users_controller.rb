class Public::UsersController < ApplicationController

    def create
        @favorite_genre = current_user.favorite_genre.new(name: favorite_genre_params[:name].compact_blank)
        @favorite_genre.save
        redirect_to public_user_path(current_user)   
    end
    
    def edit
        @user = User.find(params[:id])
        @genres = Tmdb::Genre.movie_list
    end
    
    def update 
        @user = User.find(params[:id])
        FavoriteGenre.where(user_id: @user.id).destroy_all
        params[:user][:favorite_genres].compact_blank.each do |genre_id|
            FavoriteGenre.create(user_id: @user.id, genre_id: genre_id)
        end
        @user.update(user_params)
        redirect_to public_user_path(current_user)        
    end
   
    def show
        @user = current_user
    end
    
    private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :favorite_movie, :favorite_genre1, :favorite_genre, :profile_image)
    # , favorite_genres_attributes: [:_destroy, :id]
  end
end