class FavoriteGenre < ApplicationRecord
  
belongs_to :user
#belongs_to :genre

def genre_name
  Tmdb::Genre.movie_list.select {|movie| movie.id == genre_id}[0].name
end
end
