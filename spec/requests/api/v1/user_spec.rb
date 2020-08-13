require 'rails_helper'

RSpec.describe "User API" do
    
    context "POST /api/v1/users" do
        it "creates a new user" do
            user = build(:user)
            params = { username: user.username, password: user.password }
            post "/api/v1/users", params: params
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(User.count).to eq(1)
            expect(output['username']).to eq(user.username)
        end

        it "save fails without password" do
            user = build(:user)
            params = { username: user.username }
      
            post "/api/v1/users", params: params
      
            expect(User.count).to eq(0)
          end
      
        it "save fails without username" do
            user = build(:user)
            params = { password: "password" }
      
            post "/api/v1/users", params: params
      
            expect(User.count).to eq(0)
        end
    end

    context "GET /api/v1/users/me" do 
        it "Gets user's jwt token" do
            user = create(:user)
            params = { username: user.username, password: user.password }
            get "/api/v1/users/me", params: params
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output['username']).to eq(user.username)
        end

        it "Gets user's jwt token fails with invalid password" do
            user = create(:user)
            params = { username: user.username, password: "fakepass" }
            get "/api/v1/users/me", params: params
            output = JSON.parse(response.body)

            expect(response).to have_http_status(401)
        end
    end
end