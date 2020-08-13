class Api::V1::UsersController < ApplicationController
    def create
      user = User.new(safe_params)
      if user.save
        render json: user
      else
        render status: :unprocessable_entity
      end 
    end
  
    private
  
    def safe_params
      params.permit(:username, :password)
    end
  end