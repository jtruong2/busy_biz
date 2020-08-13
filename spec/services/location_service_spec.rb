require 'rails_helper'

describe LocationService do
    context "retrieves cooridinates by location" do
        it ".get_coordinates" do
            
            expect(LocationService.get_coordinates("denver").count).to eq(2)
            expect(LocationService.get_coordinates("Colorado").count).to eq(2)
            expect(LocationService.get_coordinates("80202").count).to eq(2)
        end
    end
end