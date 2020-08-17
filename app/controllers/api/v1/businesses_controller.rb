class Api::V1::BusinessesController < ApplicationController
    before_action :authorized
    
    def index
        formatted_params = BusinessHelper.format_params(safe_params)
        error            = BusinessHelper.validate_params(formatted_params)
        render json: { message:  error }, status: :bad_request and return if !error.empty?
    
        coordinates = BusinessHelper.get_coordinates(formatted_params[:location])
        render json: { message:  error }, status: :bad_request and return if coordinates.nil?

        business    = BusinessService.new(coordinates[0], coordinates[1])
        resp        = business.get_businesses_by_keyword(formatted_params[:keyword], formatted_params[:sort_by], formatted_params[:filter])
        if !resp.nil?
            puts formatted_params
            search = Search.find_or_create_by(keyword: formatted_params[:keyword], location: formatted_params[:location], filter: formatted_params[:filter], sort_by: formatted_params[:sort_by], page: formatted_params[:page], page_limit: formatted_params[:page_limit])
            @user.searches << search
            render json: BusinessHelper.paginate_results(resp["businesses"], formatted_params[:page], formatted_params[:page_limit])
        else
            render json: { message: "Internal server error" }, status: :internal_server_error
        end
    end

    private

    def safe_params
        params.permit(:keyword, :location, :sort_by, :filter, :page, :page_limit)
    end
end