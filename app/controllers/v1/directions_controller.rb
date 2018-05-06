class V1::DirectionsController < ApplicationController
    before_action :authenticate_user, except: [:index] 
      def index
    directions = Direction.all
  end

  def create 
    direction = Direction.new(
        text: params[:text],
        order: params[:order],
        recipe_id: params[:recipe_id]
        )
     if direction.save
     render json: direction.as_json
      else
        render json: {errors: direction.errors.full_messages  }, status:  :unprocessable_entity
      end 
  end 
  
end

