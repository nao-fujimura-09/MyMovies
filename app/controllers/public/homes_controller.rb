class Public::HomesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  
  def top
    @genres = Tmdb::Genre.movie_list
    # @users = User.all
    # @reviews = Review.where(movie_id: movie.id)
    movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    @movies = movies.sort_by { |v| Review.where(movie_id: v.id).average(:star) || 0.0 }.reverse
    
    @popular_movies = Tmdb::Movie.popular[:results]
    # @popular_movies = popular_movies.sort_by { |v| Review.where(movie_id: v.id).average(:star) || 0.0 }.reverse
    
    
    @all_users = User.find(Follow.group(:followed_id).order('count(followed_id) desc').limit(10).pluck(:followed_id)) #フォロワーの多いユーザーを１０位まで表示
    
  end
  
  
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
  
end
