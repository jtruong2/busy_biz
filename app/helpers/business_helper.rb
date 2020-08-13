module BusinessHelper

    def self.get_coordinates(location)
        # returns as [latitude, longitude]
        Geocoder.search(location).first.coordinates
    end
end