class Api::V1::BusinessesController < ApplicationController
    before_action :authorized
    
    def index
        formatted_params = BusinessHelper.format_params(safe_params)
        error            = BusinessHelper.validate_params(formatted_params)
        render json: { message:  error }, status: :bad_request and return if !error.empty?
    
        coordinates = BusinessHelper.get_coordinates(formatted_params[:location])
        business    = BusinessService.new(coordinates[0], coordinates[1])
        resp        = business.get_businesses_by_keyword(formatted_params[:keyword], formatted_params[:sort_by], formatted_params[:filter])
        if resp
            search = Search.find_or_create_by(criteria: formatted_params[:keyword])
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