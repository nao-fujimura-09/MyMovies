class Public::ViewsController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def create
    @view = View.new(movie_id: params[:movie_id])
    @view.user_id = current_user.id
    @view.save
    #@watch_lists = WatchList.all
    #@current_customer.watch_list.find_by(movie_id: watch_list.movie_id).destroy
    redirect_back(fallback_location: root_path)
    # @current_customer.watch_listsparams[:id]).destroy
  end
  
  def destroy
    @view = View.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private

  
  def view_params
    params.require(:view).permit(:user_id, :movie_id)
  end
end
