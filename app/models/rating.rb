class Rating < ActiveRecord::Base
	validates :score, numericality: { 
		greater_than_or_equal_to: 1,
        less_than_or_equal_to: 50,
        only_integer: true 
    }

	belongs_to :beer
	belongs_to :user

	def getScore
		return score
	end

	def to_s
		"#{beer.name}, pisteitä: #{score} "
	end

end
