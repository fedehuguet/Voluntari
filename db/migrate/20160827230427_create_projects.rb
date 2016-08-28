class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :capacity
      t.string :description
      t.string :date
      t.integer :free_spaces
      t.integer :money_donated

      t.timestamps null: false
    end
  end
end
