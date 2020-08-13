require 'rails_helper'

describe BusinessHelper do
    context "retrieves cooridinates by location" do
        it ".get_coordinates" do
            
            expect(BusinessHelper.get_coordinates("denver").count).to eq(2)
            expect(BusinessHelper.get_coordinates("Colorado").count).to eq(2)
            expect(BusinessHelper.get_coordinates("80202").count).to eq(2)
        end
    end
end