class Admin::GenresController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @genres = Tmdb::Genre.movie_list
      # @genres.each do |genre|
      #   return if Genre.find_by(name: genre.name)
      #   Genre.create!(name: genre.name)
      # end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
