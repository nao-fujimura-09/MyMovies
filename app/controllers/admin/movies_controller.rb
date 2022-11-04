class Admin::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
   @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).flatten!
   @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:id])
    # @movies.title = Tmdb::Movie.popular.title
    # @movie.tmdb_id = Tmdb::Movie.latest
  end

  def show
    @movie = Tmdb::Movie.detail(params[:id])
    id = @movie.id #上のmovie情報からidだけを取得
    casts= Tmdb::Movie.cast(id) #変数castsに映画 IDに紐づくキャストを代入
    @persons = [] #空の配列を用意
    casts.select do |cast| #キャストの中の特定の条件を首藤
      cast.name #キャストの名前を取得
      @persons.push(cast.name) #変数personsにcast.nameを代入
    end
    @views = View.where(movie_id: @movie.id)
    # @reviews = Review.where(movie_id: movie.id)
    @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:id])
    @watch_lists = WatchList.where(movie_id: @movie.id)
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
end
