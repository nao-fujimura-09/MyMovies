class Public::GenresController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def show
    # @genres = Tmdb::Genre.movie_list
    @genres = Tmdb::Genre.movie_list
    @genre_movies = Tmdb::Genre.movies(params[:id])[:results]
    @watch_list = WatchList.new
    @review = Review.new
    @view = View.new
  end

end
