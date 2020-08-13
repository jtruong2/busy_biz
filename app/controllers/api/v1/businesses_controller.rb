class Api::V1::BusinessesController < ApplicationController
    before_action :authorized
    
    def index
        byebug
        if !safe_params.key?("location")
            render json: { message: "Missing required query param - location" }, status: :bad_request
        end
        if !safe_params.key?("keyword")
            render json: { message: "Missing required query param - location" }, status: :bad_request
        end
    end

    private

    def safe_params
        params.permit(:keyword, :location)
    end
end