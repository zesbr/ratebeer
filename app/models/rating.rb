class Rating < ActiveRecord::Base
	belongs_to :beer

	def getScore
		return score
	end

	def to_s
		return  "#{self.beer.name}, pisteitä: #{score} "
	end

end
