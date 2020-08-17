class Api::V1::SearchesController < ApplicationController
    before_action :authorized

    def index
        render json: @user.searches.select(:keyword, :location, :sort_by, :filter, :page, :page_limit).to_json(:except => :id)
    end
end