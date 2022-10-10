class Public::HomesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  
  def top
    @genres = Tmdb::Genre.movie_list
    @movies = Tmdb::Movie.popular
  #   @movies = JSON.parse((Tmdb::Movie.popular).to_json) 
  #   @movie.title = 
  end
end
