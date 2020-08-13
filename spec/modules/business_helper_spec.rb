require 'rails_helper'

describe BusinessHelper do
    context "retrieves cooridinates by location" do
        it ".get_coordinates" do
            
            expect(BusinessHelper.get_coordinates("denver").count).to eq(2)
            expect(BusinessHelper.get_coordinates("Colorado").count).to eq(2)
            expect(BusinessHelper.get_coordinates("80202").count).to eq(2)
        end
    end

    context "paginates businesses results" do
        it ".paginate_results" do
            results = ["hello", "world", "I'm", "here", "now"]
            expect(BusinessHelper.paginate_results(results, 2, 2)).to eq(["I'm", "here"])
        end
    end

    context "is valid page param" do
        it ".is_valid_page_param" do
            expect(BusinessHelper.is_valid_page_param(3)).to eq(true)
            expect(BusinessHelper.is_valid_page_param(nil)).to eq(true)
            expect(BusinessHelper.is_valid_page_param("hello")).to eq(false)
            expect(BusinessHelper.is_valid_page_param(1.2)).to eq(false)
        end
    end
end