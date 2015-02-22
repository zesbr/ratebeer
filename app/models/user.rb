class User < ActiveRecord::Base
	include AverageRating
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }, format: { with: /[A-Z]/, message: "must have at least one capitalized letter" }

	has_secure_password
	has_many :ratings
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships


	def favorite_beer
		return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
	end

	# def favorite_brewery
		# return nil if ratings.empty?
		# brewery_ratings = rated_breweries.inject([]) { |set, brewery| set << [brewery, brewery_average(brewery) ] }
		# brewery_ratings.sort_by{ |r| r.last }.last.first
	# end

	# def favorite_style
		# return nil if ratings.empty?
		# style_ratings = rated_styles.inject([]) { |set, style| set << [style, style_average(style) ] }
		# style_ratings.sort_by{ |r| r.last }.last.first
	# end

	# def rated_breweries
		# ratings.map{ |r| r.beer.brewery}.uniq
	# end

	# def rated_styles
		# ratings.map{ |r| r.beer.style }.uniq
	# end

	# def style_average(style)
		# ratings_of_style = ratings.select{ |r| r.beer.style==style }
		# ratings_of_style.inject(0.0){ |sum, r| sum+r.score}/ratings_of_style.count
	# end

	# def brewery_average(brewery)
		# ratings_of_brewery = ratings.select{ |r| r.beer.brewery==brewery }
		# ratings_of_brewery.inject(0.0){ |sum, r| sum+r.score}/ratings_of_brewery.count
	# end

	def rating_of_brewery(brewery)
    ratings_of_brewery = ratings.select do |r|
      r.beer.brewery == brewery
    end
    ratings_of_brewery.map(&:score).sum / ratings_of_brewery.count
  end

  # NEW METHODS

	def rated(resource)
    ratings.map{ |r| r.beer.send(resource) }.uniq
  end

	def rating_of(resource, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(resource) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

  def favorite(resource)
    return nil if ratings.empty?
    resource_ratings = rated(resource).inject([]) do |set, item|
      set << {
        item: item,
        rating: rating_of(resource, item) }
    end
    resource_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

end
