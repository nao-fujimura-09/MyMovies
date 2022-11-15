class Public::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  

  def index
    @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
    @watch_list = WatchList.new
    @review = Review.new
    @view = View.new
  end

  def review
    @reviews = Review.where(movie_id: params[:movie_id]).where("title IS NOT NULL").where("title!=''")
    # @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:id]) #タイトルと本文がからのものは表示しない。movie_idが当てはまるものを探す
  end
  
  def show
    @user = current_user
    @movie = Tmdb::Movie.detail(params[:id])
    id = @movie.id #上のmovie情報からidだけを取得
    casts= Tmdb::Movie.cast(id) #変数castsに映画 IDに紐づくキャストを代入
    @persons = [] #空の配列を用意
    casts.select do |cast| #キャストの中の特定の条件を取得
      cast.name #キャストの名前を取得
      @persons.push(cast.name) #変数personsにcast.nameを代入
    end
     # render json: @movie.perfomer    
    # byebug

    @review = Review.new
    @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:id]) #タイトルと本文がからのものは表示しない。movie_idが当てはまるものを探す
    @views= View.all
    @view = View.new
    @watch_list = WatchList.new
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
  
  def watch_list_params
    params.require(:watch_list).permit(:user_id, :movie_id)
  end
end
