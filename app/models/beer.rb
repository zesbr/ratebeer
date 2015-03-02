class Beer < ActiveRecord::Base
	include AverageRating	
	
	validates :name, presence: true
	validates :style_id, presence: true
	
	belongs_to :brewery, touch: true
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user
	belongs_to :style

	def average
		return 0 if ratings.empty?
		ratings.map { |r| r.score }.sum / ratings.count.to_f
	end

	def to_s
		return "#{name}, #{brewery.name}"
	end

end
