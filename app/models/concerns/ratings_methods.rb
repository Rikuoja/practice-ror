module RatingsMethods

  def average_rating
    extend ActiveSupport::Concern

    (self.ratings.inject(0) {|sum, rating| sum+rating.score})/self.ratings.count #0 is the initial value of sum
  end

end