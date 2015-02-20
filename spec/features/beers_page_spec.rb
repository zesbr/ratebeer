require 'rails_helper'

describe "Beers" do
	let!(:user) { FactoryGirl.create :user }
	let!(:style) { FactoryGirl.create :style }
	
	before :each do
    	sign_in(username:"Pekka", password:"Foobar1")
  	end
	
	it "can be added if a valid name given" do
		visit new_beer_path
		fill_in('beer_name', with:'Karhu')
		select('Lager', from:'beer[style_id]')
		expect{ click_button('Create Beer') }.to change{Beer.count}.by(1)
	end

	it "is not added if a invalid valid name given" do
		visit new_beer_path
		expect{ click_button('Create Beer') }.to change{Beer.count}.by(0)
		expect(current_path).to eq(beers_path)
		expect(page).to have_content "New Beer"
		expect(page).to have_content "Name can't be blank"
		
	end

end