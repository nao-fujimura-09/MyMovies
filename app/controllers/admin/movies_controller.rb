class Admin::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @movies = Tmdb::Certification.movie_list
  end

  def show
  end
end
