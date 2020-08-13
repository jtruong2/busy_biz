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
        it "searches for businesses by keyword" do

            get "/api/v1/businesses?keyword=gas%20stations", params: {}, headers: {"Authorization": "Bearer #{token}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output.count).to eq(2)
        end
    end
end