class Movie < ActiveRecord::Base
  def self.getRatings
    Movie.order("rating").map(&:rating).uniq.sort
  end
    
end
