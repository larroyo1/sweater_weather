class WeatherFacade

  def self.weather_info(location)
    weather = WeatherService.get_weather(location)

    Weather.new(weather)
  end
end
