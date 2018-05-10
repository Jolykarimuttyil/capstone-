class V1::RecipesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :api_search]

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

  def api_search
    response =  Unirest.get("https://api.edamam.com/search?q=chicken soup&app_id=c2e953ab&app_key=28bae3bac65b4eb1f5e5a7ab4989ae11&from=0&to=3&calories=591-722&health=alcohol-free")
    recipes = response.body
    render json: recipes.as_json
  end
end