class Style < ActiveRecord::Base
	include AverageRating	

	has_many :beers
	has_many :ratings, through: :beers

	def self.top(n)
		ratings = Rating.all
		Style.all.each do |style|
			ratings_of_style = ratings.select{ |r| r.beer.style==style }
			ratings_of_style.inject(0.0){ |sum, r| sum+r.score}/ratings_of_style.count
		end
	end

	def rated_styles
		ratings.map{ |r| r.beer.style }.uniq
	end

	def style_average(style)
		ratings_of_style = ratings.select{ |r| r.beer.style==style }
		ratings_of_style.inject(0.0){ |sum, r| sum+r.score}/ratings_of_style.count
	end

end
