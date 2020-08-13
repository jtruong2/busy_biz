class Api::V1::BusinessesController < ApplicationController
    before_action :authorized
    
    def index
        render json: { message: "Missing required query param - location" }, status: :bad_request and return if !safe_params.key?("location")
        render json: { message: "Missing required query param - keyword" }, status: :bad_request and return if !safe_params.key?("keyword")

        coordinates = LocationService.get_coordinates(safe_params[:location])
        business    = BusinessService.new(coordinates[0], coordinates[1])
        resp        = business.get_businesses_by_keyword(safe_params[:keyword])
        if resp
            search = Search.find_or_create_by(criteria: safe_params[:keyword])
            @user.searches << search
            render json: resp
        else
            render json: { message: "Internal server error" }, status: :internal_server_error
        end
    end

    private

    def safe_params
        params.permit(:keyword, :location)
    end
end