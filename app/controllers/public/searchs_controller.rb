class Public::SearchsController < ApplicationController
  
  before_action :to_genre_show, only: [:search] 
  
  def search
    @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).push(Tmdb::Movie.top_rated[:results]).flatten!.uniq

    if params[:word]
      @movies = @movies.select{|e| e.title.include?(params[:word])}
    end
  end
  
  private
  
  def to_genre_show
    if params[:genre_id].present?
      redirect_to public_genre_path(params[:genre_id])
    end
  end
end
