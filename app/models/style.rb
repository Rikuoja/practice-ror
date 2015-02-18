class Style < ActiveRecord::Base
  include RatingMethods

  validates :name, presence: true

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
end
