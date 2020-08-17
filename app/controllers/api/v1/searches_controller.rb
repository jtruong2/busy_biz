class Api::V1::SearchesController < ApplicationController
    before_action :authorized

    def index
        render json: @user.searches.pluck(:keyword, :location, :sort_by, :filter, :page, :page_limit)
    end
end