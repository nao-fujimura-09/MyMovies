class Genre < ApplicationRecord
  
  has_many :movies
  # belongs_to :movie
  has_many :favorite_genres
end
