class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		sum = self.ratings.sum(:score)
		count = self.ratings.count
		avg = 1.0 * sum / count
		return "#{avg}"
	end

end
