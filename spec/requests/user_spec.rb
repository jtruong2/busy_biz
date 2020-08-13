require 'rails_helper'

RSpec.describe "User API" do
    
    context "POST /api/v1/users" do
        it "creates a new user" do
            user = build(:user)
            params = { username: user.username, password: "password" }
            post "/api/v1/users", params: params
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(User.count).to eq(1)
            expect(output['username']).to eq(user.username)
        end
    end
end