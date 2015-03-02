class WelcomeController < ApplicationController
  def index
  	if current_user
  		redirect_to breweries_path
  	end
  end
end
