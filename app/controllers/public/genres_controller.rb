class Public::GenresController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def show
    @genres = Tmdb::Genre.movie_list
    @genre_movies = Tmdb::Genre.movies(params[:id])[:results]
  end

end
