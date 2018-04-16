class V1::RecipesController < ApplicationController
  before_action :authenticate_user
  def index 
    if current_user
      recipes = current_user.recipes
      render json: recipes.as_json
    else
      render json: []
    end
  end
end 
