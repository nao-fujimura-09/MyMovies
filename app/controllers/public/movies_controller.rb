class Public::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  

  def index
    @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
      # p @movies
    # @movies.each do |movie|
    #   # p movie.title
    #   # p movie.genre_id
    #   return if Movie.find_by(title: movie.title)
    #   movie.genre_ids.each do |id|
    #     return if Genre.find_by(genre_id: id)
    #     Genre.create!(genre_id: id, movie_id: movie.id)
    #   end
    #   Movie.create!(title: movie.title, )
    # end
   @watch_list = WatchList.new
  end
  
  def show
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
  
  def watch_list_params
    params.require(:watch_list).permit(:user_id, :movie_id)
  end
end
