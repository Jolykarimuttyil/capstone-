class V1::RecipesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def create 
    recipe = Recipe.new(
      name: params[:name],
      user_id: current_user.id
      )
    if recipe.save
      render json: recipe.as_json
    else
      render json: {errors: recipe.errors.full_messages  }, status:  :unprocessable_entity
    end 
  end 

  def show
    recipe = Recipe.find_by(id: params[:id])
    render json: recipe.as_json
  end 
end