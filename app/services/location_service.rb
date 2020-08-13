class LocationService 

    def self.get_coordinates(location)
        Geocoder.search(location).first.coordinates
    end
end