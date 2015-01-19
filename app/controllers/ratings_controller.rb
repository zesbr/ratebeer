class RatingsController < ApplicationController
	def index
		@rating = Rating.all
	end
  	# GET /ratings/new
  	def new
    	@rating = Rating.new
  	end
  	def create
    	raise
 	end
end