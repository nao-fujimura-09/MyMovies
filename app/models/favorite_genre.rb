class FavoriteGenre < ApplicationRecord
  
belongs_to :user

def genre_name
  genreData = Tmdb::Genre.movie_list.select {|movie| movie.id == genre_id}.first
  if genreData.nil?
    ""
  else
    genreData.name
  end
end

end
