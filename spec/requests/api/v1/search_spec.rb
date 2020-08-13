require 'rails_helper'

RSpec.describe "Search API" do
    
    context "GET /api/v1/searches" do
        it "retrieves all searches for current user" do
            user = create(:user)
            jwt = encode_token(user.id)
            sOne = create(:search)
            sTwo = create(:search)

            create(:user_search, user_id: user.id, search_id: sOne.id)
            create(:user_search, user_id: user.id, search_id: sTwo.id)

            get "/api/v1/searches", nil, {"AUTHORIZATION" => "Bearer #{jwt}"}
            output = JSON.parse(response.body)

            expect(response).to have_http_status(200)
            expect(output.count).to eq(2)
        end
    end
end