class Beer < ActiveRecord::Base
	include RatingsMethods

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user

	validates :name, presence: true

	def to_s
		self.name + ' (' + Brewery.find_by(self.brewery_id).name + ')'
	end

	def average
		return 0 if ratings.empty?
		ratings.map{ |r| r.score }.sum.to_f/ratings.count
	end

end
