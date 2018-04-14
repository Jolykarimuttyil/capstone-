class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.text :text
      t.integer :recipe_id
      t.integer :order

      t.timestamps
    end
  end
end
