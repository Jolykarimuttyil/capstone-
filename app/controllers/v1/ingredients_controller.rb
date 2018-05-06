class V1::IngredientsController < ApplicationController
  before_action :authenticate_user, except: [:index] 
  def index
    ingredient = Ingredient.all
  end
  def create 
    ingredient = Ingredient.new(
      name: params[:name],
      recipe_id: params[:recipe_id]
      )
    if ingredient.save
      render json: ingredient.as_json
    else
      render json: {errors: ingredient.errors.full_messages  }, status:  :unprocessable_entity
    end 
  end 

end

