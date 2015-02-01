class Beer < ActiveRecord::Base
	include AverageRating	
	
	validates :name, presence: true

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user

	def average
		return 0 if ratings.empty?
		ratings.map { |r| r.score }.sum / ratings.count.to_f
	end

	def to_s
		return "#{name}, #{brewery.name}"
	end

end
