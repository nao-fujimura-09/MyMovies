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
    @watch_lists = current_user.watch_lists.select(:movie_id).distinct
    @view = View.new
    # render json: @movies
  end
  
  def destroy
    @watch_list = WatchList.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def watch_list_params
    params.require(:watch_list).permit(:user_id, :movie_id)
  end
end
