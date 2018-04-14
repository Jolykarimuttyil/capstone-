class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :posted_comment
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
