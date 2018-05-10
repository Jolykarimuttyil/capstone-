class V1::RecipesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def create 
    # render json: {message: "test", params: params}
    recipe = Recipe.new(
      name: params[:name],
      user_id: current_user.id
      )
    if recipe.save
      # params[:ingredients].
      Ingredient.create(params[:ingredients].map {|ingredient| {recipe_id: recipe.id, name: ingredient}})
      Direction.create(params[:directions].each_with_index.map {|direction, i| {recipe_id: recipe.id, text: direction, order: i + 1}})
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