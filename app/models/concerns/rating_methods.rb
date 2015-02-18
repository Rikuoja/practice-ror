module RatingMethods
  extend ActiveSupport::Concern

  def average_rating
    ratings.map(&:score).sum.to_f/ratings.count
  end

  def average_rating_from(selected)
    selected.map(&:score).sum.to_f/selected.count
  end

  def top(n)
    sorted_by_rating_in_desc_order = self.class.all.sort_by{ |b| b.average_rating.nan? ? 0 : -(b.average_rating||0) }
    sorted_by_rating_in_desc_order[0,n]
  end

  def most_ratings(n)
    sorted_by_no_of_ratings_in_desc_order=self.class.all.sort_by{|b| -b.ratings.count}
    sorted_by_no_of_ratings_in_desc_order[0,n]
  end

end