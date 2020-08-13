class BusinessService
    
    def initialize(latitude, longitude)
        @latitude  = latitude
        @longitude = longitude
        @conn      = Faraday.new(
            url: "https://api.yelp.com/v3",
            headers: {"Authorization" => "Bearer #{ENV["yelp_api_key"]}"}
        )
    end

    def get_businesses_by_keyword(keyword, sort_by = nil, filter = nil)
        begin
            resp = @conn.get('businesses/search') do |req|
                req.params['term']       = keyword
                req.params['latitude']   = @latitude
                req.params['longitude']  = @longitude
                req.params['sort_by']    = sort_by if !sort_by.nil?
                req.params['categories'] = filter if !filter.nil?
            end
            JSON.parse(resp.body)
        rescue
            nil
        end
    end

    def self.is_valid_sort(sort_by)
        return true if sort_by.nil?
        sort_by.in?(['best_match', 'rating', 'review_count', 'distance'])
    end

    def self.is_valid_filter(filter)
       file = File.read("#{Rails.root}/public/categories.json") 
       categories = JSON.parse(file)
       return true if filter.nil?
       filter.in?(categories)
    end
end