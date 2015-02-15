class Brewery < ActiveRecord::Base
    include AverageRating
	
    validates :name, presence: true
    validates :year, numericality: { 
        greater_than_or_equal_to: 1024, 
        less_than_or_equal_to: ->(_){Time.now.year} 
     }

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

	def print_report
	    puts name
	    puts "established at year #{year}"
	    puts "number of beers #{beers.count}"
  	end

    def restart
        self.year = 2015
        puts "changed year to #{year}"
    end

    def this_year
    end

end
