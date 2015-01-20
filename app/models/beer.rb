class Beer < ActiveRecord::Base
	include AverageRating
	
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	#def average_rating
		#sum = self.ratings.sum(:score)
		#count = self.ratings.count
		#avg = 1.0 * sum / count
		#return "#{avg}"
	#end

	def to_s
		return "#{name}, #{brewery.name}"
	end

end
