module AverageRating
	extend ActiveSupport::Concern
	def average_rating
		count = self.ratings.count
        sum = self.ratings.sum(:score)
        avg = 1.0 * sum / count
        return "#{avg}"
	end
end