require 'rails_helper'

describe BusinessService do
    context "retrieves businesses by keyword" do
        it ".get_businesses_by_keyword" do
            business = BusinessService.new("39.7541", "105.0002")
            
            expect(business.get_businesses_by_keyword("food")).to have_key("businesses")
        end
    end
end