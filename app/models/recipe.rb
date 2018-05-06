class Recipe < ApplicationRecord
  belongs_to :user 
  has_many :ingredients
  has_many :directions  
  has_many :comments
  def as_json
    {
      id: id,
      name: name,
      recipe_api_id: recipe_api_id,
      user: user.as_json,
      directions: directions.as_json,
      ingredients: ingredients.as_json,

    }
  end
end
