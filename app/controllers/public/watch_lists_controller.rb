class Public::WatchListsController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  
  def create
    @watch_list = WatchList.new(watch_list_params)
    @watch_list.user_id = current_user.id
    @watch_list.save
    # byebug
    # binding.pry
    redirect_to public_movies_path
  end
  
  def index
    @watch_lists = current_user.watch_lists.all
    @movies = []
    @watch_lists.each do |watch_list|
      @movies << Tmdb::Movie.detail(watch_list.movie_id)
    end
    
    # render json: @movies
  end
  
  def destroy
    
  end
  
  private
  
  def watch_list_params
    params.require(:watch_list).permit(:user_id, :movie_id)
  end
end
