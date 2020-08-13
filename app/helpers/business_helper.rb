module BusinessHelper

    # returns as [latitude, longitude]
    def self.get_coordinates(location)
        Geocoder.search(location).first.coordinates
    end

    def self.paginate_results(results, page = 1, page_limit = 20)
        results.paginate(page: page, per_page: page_limit)
    end

    def self.is_valid_page_param(value) 
        return true if value.is_a? Integer || value.nil?
        false
    end
end