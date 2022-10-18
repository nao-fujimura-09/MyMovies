class Public::WatchListsController < ApplicationController
  
  def create
    @watch_list.new(watch_list_params)
    
  end
  
  private
  
  def watch_list_params
    params.requre(:watch_list).permit(:user_id, :movie_id)
  end
end
