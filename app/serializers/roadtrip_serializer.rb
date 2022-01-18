class RoadtripSerializer

  def self.roadtrip(trip, weather)
    {
      data: {
        id: trip.id,
        type: 'roadtrip',
        attributes: {
          start_city: trip.from,
          end_city: trip.to,
          travel_time: trip.formatted_travel_time,
          weather: {
            temperature: weather.current_weather[:temp],
            conditions: weather.current_weather[:weather][0][:description]
         }
        }
      }
    }
  end
end
