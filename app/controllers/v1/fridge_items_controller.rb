class V1::FridgeItemsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  def index
    fridge_items = Fridge_item.all
    render json: fridge_item.as_json
  end

  def create 
    fridge_item = Fridge_item.new(
      name: params[:name],
      user_id: current_user.id
      )
    if fridge_item.save
      render json: fridge_item.as_json
    else
      render json: {errors: fridge_item.errors.full_messages  }, status:  :unprocessable_entity
    end 
  end 
end
