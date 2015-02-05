module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.map(&:score).sum.to_f/ratings.count
  end

  def average_rating_from(selected)
    selected.map(&:score).sum.to_f/selected.count
  end
end