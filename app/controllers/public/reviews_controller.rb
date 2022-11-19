class Public::ReviewsController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to public_review_path(@review.id), notice: 'レビューに成功しました'
  end
  
  def index
    @reviews = Review.all
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
    redirect_to public_review_path(@review.id), notice: 'レビューの編集に成功しました'
  end
  
  def destroy
    @review = Review.find(params[:id]).destroy
    redirect_to public_reviews_path
  end
    
  private

  def review_params
    params.require(:review).permit(:user_id, :movie_id,:title, :body, :star)
  end
end
