class Beer < ActiveRecord::Base
	include RatingsMethods

	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
		self.name + ' (' + Brewery.find_by(self.brewery_id).name + ')'
	end

end
