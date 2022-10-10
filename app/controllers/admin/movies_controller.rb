class Admin::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @movies = Tmdb::Movie.popular
    # @movies.title = Tmdb::Movie.popular.title
    # @movie.tmdb_id = Tmdb::Movie.latest
  end

  def show
    @movie = Tmdb::Movie.detail(550)
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
end
