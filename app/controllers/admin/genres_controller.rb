class Admin::GenresController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @genres = Tmdb::Genre.movie_list
  end
end
