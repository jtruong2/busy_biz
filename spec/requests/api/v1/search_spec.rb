require 'rails_helper'

RSpec.describe "Search API", type: :request do
    context "GET /api/v1/searches" do
        it "retrieves all searches for current user" do
            u_build = build(:user)
            params = { username: u_build.username, password: u_build.password }
            post "/api/v1/users", params: params
            token = JSON.parse(response.body)["token"]
            user = get_user_by_username(u_build.username)

            s_one = create(:search)
            s_two = create(:search)

            create(:user_search, user: user, search: s_one)
            create(:user_search, user: user, search: s_two)

            get "/api/v1/searches", params: {}, headers: {"Authorization": "Bearer #{token}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output.count).to eq(2)
        end

        it "throws error if incorrect bearer token" do
            get "/api/v1/searches", params: {}, headers: {"Authorization": "Bearer faketoken"}

            expect(response).to have_http_status(401)
        end
    end
end