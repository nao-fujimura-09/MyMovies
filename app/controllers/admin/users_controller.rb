class Admin::UsersController < ApplicationController
  
  require 'themoviedb-api'
  Tmdb::Api.key(ENV['TMDB_API_KEY'])
  Tmdb::Api.language("ja")
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end
end
