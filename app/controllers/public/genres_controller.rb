class Public::GenresController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def show
    @genre_movies = Tmdb::Genre.movies(params[:id])
    # @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    # id = @genre.genre_ids
    # movies = @movies(id)
    
  end

end
