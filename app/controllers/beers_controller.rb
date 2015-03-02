class BeersController < ApplicationController

  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :ensure_that_admin, only: [:destroy]
  before_action :skip_if_cached, only:[:index]

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{@order}"  )
  end

  def index
    order = params["order"] || "name"

    # Hyi! :( - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      if session[:reverse].nil? || session[:reverse]
        session[:reverse] = false
      else
        session[:reverse] = true
      end
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    @beers = Beer.all.includes(:brewery, :style).all

    case order
      when "name" then 
        @beers = @beers.sort_by{ |b| b.name }
      when "style" then
        @beers = @beers.sort_by{ |b| b.style.name }
      when "brewery" then
        @beers = @beers.sort_by{ |b| b.brewery.name }
    end

    # Hyi! :( - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if session[:reverse]
      @beers = @beers.reverse
    end
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  end

  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  def new
    @beer = Beer.new
  end
  
  def edit
  end

  def list
  end

  def nglist
  end

  def create
    @order = params[:order] || 'name'
    expire_fragment( "beerlist-#{@order}" )

    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order = params[:order] || 'name'
    expire_fragment( "beerlist-#{@order}" )

    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = params[:order] || 'name'
    expire_fragment( "beerlist-#{@order}" )

    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    def set_breweries_and_styles_for_template
      @breweries = Brewery.all
      @styles = Style.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style_id, :brewery_id)
    end
end
