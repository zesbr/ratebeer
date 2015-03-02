class Rating < ActiveRecord::Base
	validates :score, numericality: { 
		greater_than_or_equal_to: 1,
        less_than_or_equal_to: 50,
        only_integer: true 
    }

  scope :recent, -> { Rating.all.order(created_at: :desc).limit(5) }

	belongs_to :beer, touch: true
	belongs_to :user
	
	def to_s
		"#{beer.name}, pisteitä: #{score} "
	end

end
