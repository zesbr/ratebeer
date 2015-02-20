class RenameColumnStyleToOldStyleForBeer < ActiveRecord::Migration
  def change
  	rename_column :beers, :old_style, :style
  end
end
