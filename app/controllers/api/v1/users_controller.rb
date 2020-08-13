class Api::V1::UsersController < ApplicationController
  before_action :authorized, except: [:create]

    def create
      user = User.new(safe_params)
      if user.save
        token = encode_token({user_id: user.id})
        render json: {username: user.username, token: token}
      else
        render status: :unprocessable_entity
      end 
    end
  
    private
  
    def safe_params
      params.permit(:username, :password)
    end
  end