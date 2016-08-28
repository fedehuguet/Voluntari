class AddCategoriesToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :categories, :string
  	 add_column :projects, :place, :string
  end
end
