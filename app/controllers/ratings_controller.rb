class RatingsController < ApplicationController
	
  def index
		@ratings = Rating.all
    @top_beers = Beer.all.sort_by{ |b| -(b.average_rating) }.take(3)
    @top_breweries = Brewery.all.sort_by{ |b| -(b.average_rating) }.take(3)
    @top_styles = Style.all.sort_by{ |s| -(s.average_rating) }.take(3)
    # TODO
    @most_active_raters = User.all.sort_by { |u| -(u.ratings.count ) }.take(5)
    @most_recent_ratings = Rating.recent
	end

	def new
  	@rating = Rating.new
  	@beers = Beer.all
	end

	def create
  	@rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    
    if current_user.nil?
      redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
	end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  private

    def get_top_beers
      @beers = Beer.all
    end
  
end