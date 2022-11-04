class Public::ReviewsController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    # byebug
    # binding.pry
    redirect_back(fallback_location: root_path)
  end
  
  def index
    # @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    # @movie = Tmdb::Movie.detail(movie_id: params[:movie.id])
    @movie = Tmdb::Movie.detail(@review.movie_id)
    @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:movie_id])
    # @reviews = Review.where(movie_id: params[:id])
    # @reviews = Review.select(:movie_id).distinct
    # @reviews = Review.where(movie_id: @review.movie_id)
  end

  def show
    @review = Review.find(params[:id])
    @movie = Tmdb::Movie.detail(@review.movie_id)
  end

  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to public_review_path(@review.id)
  end
  
  def destroy
    @review = Review.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
    
  private

  def review_params
 params.require(:review).permit(:user_id, :movie_id,:title, :body, :star)
  end
end
