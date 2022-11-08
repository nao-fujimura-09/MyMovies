class Public::HomesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  
  def top
    @genres = Tmdb::Genre.movie_list
    @users = User.all
    # @reviews = Review.where(movie_id: movie.id)
    @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    # .sort_by(@review.star)
    @popular_movies = Tmdb::Movie.popular[:results]
  end
  
  
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
  
end
