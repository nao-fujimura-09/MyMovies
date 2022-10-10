class FavoriteGenre < ApplicationRecord
  
belings_to :user
belings_to :genre
end
