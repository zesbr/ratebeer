class CreateStylesAndAssociateThoseToBeers < ActiveRecord::Migration
 	def change
    add_column :beers, :style_id, :integer
  end
end

#id: 1, name: "IPA", description: "India Pale Ale (IPA) is a hoppy beer style within ...", 
#id: 2, name: "Lager", description: "Lager (German: storage) is a type of beer that is ...", 
#id: 3, name: "Pale ale", description: "Pale ale is a beer made by warm fermentation using...", 
#id: 4, name: "Porter", description: "Porter is a dark style of beer developed in London...", 
#id: 5, name: "Weizen", description: "Wheat beer is a style of beer brewed with a large ...", 
