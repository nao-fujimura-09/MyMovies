class Public::HomesController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  
  def top
    @genres = Tmdb::Genre.movie_list
    movies = Tmdb::Movie.popular[:results].push(Tmdb::Movie.now_playing[:results]).push(Tmdb::Movie.top_rated[:results]).flatten!.uniq
    movies_ids = movies.map {|o| o.id }
    @ranking_data = Hash[*Review.group(:movie_id).average(:star).map{|k, v| [k, v.to_f.round(1)]}.flatten]
    @movies = movies.sort_by { |v| @ranking_data[v.id] || 0.0 }.reverse
    @popular_movies = Tmdb::Movie.popular[:results]
    @all_users = User.find(Follow.group(:followed_id).order('count(followed_id) desc').limit(10).pluck(:followed_id)) #フォロワーの多いユーザーを１０位まで表示
  end
  
  
  
  private
  
  def movie_params
    params.require(:movie).permit(:genre_id, :tmdb_id, :title, :synopsis, :directer, :screen_writer, :perfomer)
  end
  
end
