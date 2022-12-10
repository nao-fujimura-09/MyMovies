class WatchList < ApplicationRecord
  
  belongs_to :user
  
  def self.sort(selection)
    case selection
    when 'all'
      return all
    when 'views'
      return find(View.group(:id))
    end
  end
  
end
