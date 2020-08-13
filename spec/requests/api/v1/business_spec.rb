require 'rails_helper'

RSpec.describe "Business API", type: :request do

    before(:each) do
        u_build = build(:user)
        params = { username: u_build.username, password: u_build.password }
        post "/api/v1/users", params: params
        @token = JSON.parse(response.body)["token"]
        @user = get_user_by_username(u_build.username)
    end
    
    context "GET /api/v1/businesses" do
        it "searches for businesses by keyword by location" do
            get "/api/v1/businesses?keyword=food&location=denver", params: {}, headers: {"Authorization": "Bearer #{@token}"}
            output = JSON.parse(response.body)


            expect(response).to have_http_status(200)
            expect(output).to have_key("businesses")
            expect(@user.searches.count).to eq(1)

            get "/api/v1/businesses?keyword=restaurants&location=denver", params: {}, headers: {"Authorization": "Bearer #{@token}"}

            expect(@user.searches.count).to eq(2)
        end

        it "returns bad request if location is missing" do
            get "/api/v1/businesses?keyword=food", params: {}, headers: {"Authorization": "Bearer #{@token}"}

            expect(response).to have_http_status(400)
        end

        it "returns bad request if keyword is missing" do
            get "/api/v1/businesses?keyword=food", params: {}, headers: {"Authorization": "Bearer #{@token}"}
            output = JSON.parse(response.body)


            expect(response).to have_http_status(400)
        end

        it "sorts results by distance" do
            get "/api/v1/businesses?keyword=restaurants&location=denver&sort_by=distance", params: {}, headers: {"Authorization": "Bearer #{@token}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output["businesses"].first["distance"]).to be <= output["businesses"].last["distance"]
        end

        it "returns error if invalid sort_by term" do
            get "/api/v1/businesses?keyword=restaurants&location=denver&sort_by=coolest", params: {}, headers: {"Authorization": "Bearer #{@token}"}

            expect(response).to have_http_status(400)
        end

        it "filters results by category" do
            get "/api/v1/businesses?keyword=restaurants&location=denver&filter=waffles", params: {}, headers: {"Authorization": "Bearer #{@token}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output["businesses"].first["categories"].any? {|c| c["alias"] == "waffles"}).to eq(true) 
        end

        it "filters results by category" do
            get "/api/v1/businesses?keyword=restaurants&location=denver&filter=notafilter", params: {}, headers: {"Authorization": "Bearer #{@token}"}

            expect(response).to have_http_status(400)
        end

        it "paginates results by page and page limit" do
            get "/api/v1/businesses?keyword=restaurants&location=denver&page=2&page_limit=10", params: {}, headers: {"Authorization": "Bearer #{@token}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output.count).to eq(10) 
        end
    end
end