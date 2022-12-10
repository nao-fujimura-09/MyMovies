class Public::UsersController < ApplicationController

  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")

    def create
        @favorite_genre = current_user.favorite_genre.new(name: favorite_genre_params[:name].compact_blank)
        @favorite_genre.save
        redirect_to public_user_path(current_user)   
    end
    
    def edit
        @user = current_user
        @genres = Tmdb::Genre.movie_list
    end
    
    def update 
        @user = current_user
        FavoriteGenre.where(user_id: @user.id).destroy_all
        params[:user][:favorite_genres].compact_blank.each do |genre_id| #comapct_blankで空白の配列を排除
            FavoriteGenre.create(user_id: @user.id, genre_id: genre_id.to_i)
        end
        @user.update!(user_params.except(:favorite_genres)) #exceptでfavorite_genres以外をupdate(上で保存しているため)
        redirect_to public_user_mypage_path(current_user), notice: 'プロフィールを変更しました'
    end
   
    def mypage
        @user = current_user
        @views = current_user.views.select(:movie_id).distinct
        @review = Review.new
    end
    
    def show
        @user = User.find(params[:id])
        @views = View.select(:movie_id).distinct
        @review = Review.new
    end

    def comfirm
        @user = current_user
    end

    def withdrawal
        @user = current_user
        if @user.update(status: true)
            flash[:alert] = "本当に退会してもよろしいですか？"
        end
        reset_session
        redirect_to root_path, alert: '退会しました'
    end
    
    private
  
    def user_params
        params.require(:user).permit(:name, :email, :password, :favorite_movie, :profile_image, favorite_genres:[])
    end
end