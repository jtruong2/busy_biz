class BusinessService
    
    def initialize(latitude, longitude)
        @latitude  = latitude
        @longitude = longitude
        @conn      = Faraday.new(
            url: "https://api.yelp.com/v3",
            headers: {"Authorization" => "Bearer #{ENV["yelp_api_key"]}"}
        )
    end

    def get_businesses_by_keyword(keyword)
        begin
            resp = @conn.get('businesses/search') do |req|
                req.params['term']      = keyword
                req.params['latitude']  = @latitude
                req.params['longitude'] = @longitude
            end
            JSON.parse(resp.body)
        rescue
            nil
        end
    end
end