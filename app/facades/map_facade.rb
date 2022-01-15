class MapFacade

  def self.get_coordinates(location)
    response = MapService.get_location(location)
    coordinates = response[:results][0][:locations][0][:latLng]

    Location.new(coordinates)
  end
end
