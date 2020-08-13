require 'rails_helper'

RSpec.describe "User API" do
    
    context "POST /api/v1/user" do
        user = build(:user)
        params = { username: user.username, password: user.password }
        post "/api/v1/user", params: params

        output = JSON.parse(response.body)

        expect(response).to be_success
        expect(User.count).to eq(1)
        expect(User.username).to eq(user.username)
    end
end