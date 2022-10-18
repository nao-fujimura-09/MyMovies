class Movie < ApplicationRecord
  
  belongs_to :genre
  has_many :watch_lists, dependent: :destroy
end
