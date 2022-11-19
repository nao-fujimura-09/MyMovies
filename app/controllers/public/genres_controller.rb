class Public::GenresController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def show
    @genres = Tmdb::Genre.movie_list
    @genre_name = Tmdb::Genre.movies(params[:id])[:results]
    # genre_id = @genres.id
    # @genre_name = []
    # Tmdb::Genre.movie_list[:results].each do |movie_genre|
    #   movie_genre.name
    # end
    # @genre.push(movie_genre.name)
    @genre_movies = Tmdb::Genre.movies(params[:id])[:results]
    # render json: @genres
  end

end
