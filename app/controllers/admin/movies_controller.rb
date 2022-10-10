class Admin::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
   @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    # @movies.title = Tmdb::Movie.popular.title
    # @movie.tmdb_id = Tmdb::Movie.latest
  end

  def show
    # @movie = Tmdb::Movie.detail(550)
    @movie = @movies.find(movie.id)
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
end
