class Admin::MoviesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
   @movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).push(Tmdb::Movie.top_rated[:results]).flatten!.uniq
  # @movies.distinct
   
    if params[:id] == "1" #閲覧順
      # @views = View.where(movie_id: movie.id)
      # @movies = @movies.sort_by { |v| View.where(movie_id: v.id.to_i)}.count
      # @movies = @movies.joins(:views).group(:event_id).order('count(movie_id) desc')
      @movies = @movies.joins(:views).includes(:id).order("movie_id")
    
    elsif params[:id] == "2" #評価順
      @movies = @movies.sort_by { |v| Review.where(movie_id: v.id).average(:star) || 0.0 }.reverse
      
    elsif params[:id] == "3" #レビューの多い順
      # @movies = @movies.sort_by { |v| Review.where(movie_id: v.id).count}.reverse
      # @reviews =  Review.where("title!='' OR body!=''").where(movie_id: movie.id)
      @movies = @movies.sort_by { |v| Review.where("title!='' OR body!=''").where(movie_id: v.id)}.reverse
      # @movies = @movies.find(Review.group(:movie_id).order('count(movie_id) desc'))
      
    elsif params[:id] == "4" #ウォッチリスト追加数順
      @movies = @movies.sort_by { |v| WatchList.where(movie_id: v.id) }.reverse
    else
      # @movies = @movies.sort(title: :asc)
      # @movies = @movies.order_by('title DESC')
    end
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
    
    @directors = Tmdb::Movie.director(id)
    
    @views = View.where(movie_id: @movie.id)
    # @reviews = Review.where(movie_id: movie.id)
    @reviews = Review.where("title!='' OR body!=''").where(movie_id: params[:id])
    @watch_lists = WatchList.where(movie_id: @movie.id)
  end
  
  def before_movie_select
    redirect_to admin_movies_path(id: params[:movie_select])
  end
  
  def movie_select
  end
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
end
