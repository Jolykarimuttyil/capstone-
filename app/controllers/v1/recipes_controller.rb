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
    # recipe = Recipe.find_by(id: params[:id])

    # render json: recipe.as_json
    # render json: {recipe_id: params[:recipe_url]}

    # uri = URI.encode "http://www.edamam.com/ontologies/edamam.owl#recipe_c17944a7af0decc2f627246b0bb24d8a", /\W/
    uri = "http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_9b5945e03f05acbf9d69625138385408"

    puts "-" * 40
    p uri
    puts "-" * 40

    url = "https://api.edamam.com/r=#{uri}&app_id=c2e953ab&app_key=28bae3bac65b4eb1f5e5a7ab4989ae11"

    response =  Unirest.get(url)
    recipe = response.body
    render json: recipe.as_json

  end 

  def api_search
    # response =  Unirest.get("https://api.edamam.com/search?q=#{params[:ingredients]}&app_id=c2e953ab&app_key=28bae3bac65b4eb1f5e5a7ab4989ae11&from=0&to=12&calories=#{params[:min_calories]}-#{params[:max_calories]}&health=#{params[:diet_restrictions]}&ingr=#{params[:max_ingredients]}&excluded=#{params[:excluded]}")

    url = "https://api.edamam.com/search?q=#{params[:ingredients]}&app_id=c2e953ab&app_key=28bae3bac65b4eb1f5e5a7ab4989ae11&from=0&to=12&calories=#{params[:min_calories]}-#{params[:max_calories]}&ingr=#{params[:max_ingredients]}&excluded=#{params[:excluded]}"

    if params[:diet_restrictions]
      url += "&health=#{params[:diet_restrictions]}"
    end

    response =  Unirest.get(url)
    recipes = response.body
    render json: recipes.as_json
  end
end