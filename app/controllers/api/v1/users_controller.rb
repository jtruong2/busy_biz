class Api::V1::UsersController < ApplicationController
  before_action :authorized, except: [:create, :refresh_token]

    def create
      user = User.new(safe_params)
      if user.save
        token = encode_token({user_id: user.id})
        render json: {username: user.username, token: token}
      else
        render status: :unprocessable_entity
      end 
    end

    def refresh_token 
      user = User.find_by(username: safe_params[:username])
      if user && user.authenticate(safe_params[:password])
        token = encode_token({user_id: user.id})
        render json: {username: user.username, token: token}
      else
        render json: { message: "Invalid username or password"}, status: :unauthorized
      end
    end

    private
  
    def safe_params
      params.permit(:username, :password)
    end
  end