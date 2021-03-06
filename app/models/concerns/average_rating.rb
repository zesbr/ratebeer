module AverageRating extend ActiveSupport::Concern
	def average_rating
		count = self.ratings.count
		return 0 if count == 0
    sum = self.ratings.sum(:score)
    avg = 1.0 * sum / count.to_f
    return avg
	end
end