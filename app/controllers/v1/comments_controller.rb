class V1::CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  
  def index
    comment = Comment.all
  end
  def create 
    comment = Comment.new(
      comment: params[:comment],
      recipe_id: params[:recipe_id],
      user_id: current_user.id
      )
    if comment.save
      render json: comment.as_json
    else
      render json: {errors: comment.errors.full_messages  }, status:  :unprocessable_entity
    end 
  end 
end 
