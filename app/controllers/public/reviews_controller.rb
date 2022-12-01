class Public::ReviewsController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_back(fallback_location: root_path)
    # redirect_to public_review_path(@review.id)
  end
  
  def index
    @user = User.find_by(params[:user_id])
    @reviews = Review.where(user_id: params[:user_id]).where("title IS NOT NULL").where("title!=''")
    # @reviews = Review.where(user_id: params[:user_id])
  end

  def show
    @review = Review.find(params[:id])
    @movie = Tmdb::Movie.detail(@review.movie_id)

    id = @movie.id #上のmovie情報からidだけを取得
    casts= Tmdb::Movie.cast(id) #変数castsに映画 IDに紐づくキャストを代入
    @persons = [] #空の配列を用意
    casts.select do |cast| #キャストの中の特定の条件を取得
      cast.name #キャストの名前を取得
      @persons.push(cast.name) #変数personsにcast.nameを代入
    end
    
    @directors = Tmdb::Movie.director(id)
  end

  def edit
    @review = Review.find(params[:id])
    @user = @review.user
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
      redirect_to public_review_path(@review.id), notice: 'レビューの編集に成功しました'
  end
  
  def destroy
    @review = Review.find(params[:id]).destroy
    redirect_to public_movie_path(id: @review.movie_id)
    # redirect_to public_reviews_path
  end
    
  private

  def review_params
    params.require(:review).permit(:user_id, :movie_id,:title, :body, :star)
  end
end
