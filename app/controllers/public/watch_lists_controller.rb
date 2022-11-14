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
    redirect_back(fallback_location: root_path)
  end
  
  def index
    @view = View.new
    exist_view_movies = current_user.views.pluck(:movie_id)
    @watch_lists = current_user.watch_lists.where.not(movie_id:exist_view_movies).select(:movie_id)
    
    # if params[:id] == "1"
    #   exist_view_movies = current_user.views.pluck(:movie_id)
    #   @watch_lists = current_user.watch_lists.where.(movie_id:exist_view_movies).select(:movie_id)
    #   # @watch_lists = current_user.watch_lists, lambda {where(movie_id:exist_view_movies).select(:movie_id)}
    # elsif params[:id] == "2"
    #   exist_view_movies = current_user.views.pluck(:movie_id)
    #   @watch_lists = current_user.watch_lists.where.not(movie_id:exist_view_movies).select(:movie_id)
    # else
    #   @watch_lists = current_user.watch_lists.all
    # end
    # render json: @movies
  end
  
  def destroy
    @watch_list = WatchList.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  def before_watch_select
    redirect_to public_watch_lists_path(id: params[:watch_select])
  end
  
  def watch_select
  end
  
  private
  
  def watch_list_params
    params.require(:watch_list).permit(:user_id, :movie_id)
  end
end