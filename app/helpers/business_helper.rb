module BusinessHelper

    # returns as [latitude, longitude]
    def self.get_coordinates(location)
        begin
            Geocoder.search(location).first.coordinates
        rescue 
            nil
        end
    end

    def self.paginate_results(results, page = 1, page_limit = 20)
        results.paginate(page: page, per_page: page_limit)
    end

    def self.is_valid_page_param(value) 
        value.is_a?(Integer) && value > 0 || value.nil?
    end

    def self.is_valid_sort(sort_by)
        return true if sort_by.nil?
        sort_by.in?(['best_match', 'rating', 'review_count', 'distance'])
    end

    def self.is_valid_filter(filter)
       file = File.read("#{Rails.root}/app/data/categories.json")
       categories = JSON.parse(file)
       return true if filter.nil?
       filter.in?(categories)
    end

    def self.validate_params(params)
        error = ""
        error  += "Missing or invalid query param - keyword. " if !params.key?("keyword")
        error += "Missing or invalid query param - location. " if !params.key?("location")
        error += "Invalid sort_by term.  " if params.key?("sort_by") && !is_valid_sort(params[:sort_by]) 
        error += "Invalid filter term. " if params.key?("filter") && !is_valid_filter(params[:filter])
        error += "Invalid page query. " if params.key?("page") && !is_valid_page_param(params[:page])
        error += "Invalid page_limit query. " if params.key?("page_limit") && !is_valid_page_param(params[:page_limit])
        error
    end
    
    def self.format_params(params)
        params[:page] = params[:page].to_i if params.key?("page")
        params[:page_limit] = params[:page_limit].to_i if params.key?("page_limit")
        params[:filter] = params[:filter].downcase if params.key?("filter")
        params[:sort_by] = params[:sort_by].downcase if params.key?("sort_by")
        params
    end
end