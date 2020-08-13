class Api::V1::SearchesController < ApplicationController
    before_action :authorized

    def index
        render json: @user.searches.pluck(:criteria)
    end
end