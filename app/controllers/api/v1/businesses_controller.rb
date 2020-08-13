class Api::V1::BusinessesController < ApplicationController
    before_action :authorized
    
    def index
        render json: { message: "Missing required query param - location" }, status: :bad_request and return if !safe_params.key?("location")
        render json: { message: "Missing required query param - keyword" }, status: :bad_request and return if !safe_params.key?("keyword")
        render json: { message: "Invalid sort_by term" }, status: :bad_request and return if !BusinessService.is_valid_sort(safe_params[:sort_by])
        render json: { message: "Invalid filter term" }, status: :bad_request and return if !BusinessService.is_valid_filter(safe_params[:filter])
        render json: { message: "Invalid page query" }, status: :bad_request and return if !BusinessHelper.is_valid_page_param(safe_params[:page])
        render json: { message: "Invalid page_limit query" }, status: :bad_request and return if !BusinessHelper.is_valid_page_param(safe_params[:page_limit])

        coordinates = BusinessHelper.get_coordinates(safe_params[:location])
        business    = BusinessService.new(coordinates[0], coordinates[1])
        resp        = business.get_businesses_by_keyword(safe_params[:keyword], safe_params[:sort_by], safe_params[:filter])
        if resp
            search = Search.find_or_create_by(criteria: safe_params[:keyword])
            @user.searches << search
            render json: BusinessHelper.paginate_results(resp["businesses"], safe_params[:page], safe_params[:page_limit])
        else
            render json: { message: "Internal server error" }, status: :internal_server_error
        end
    end

    private

    def safe_params
        params.permit(:keyword, :location, :sort_by, :filter, :page, :page_limit)
    end
end