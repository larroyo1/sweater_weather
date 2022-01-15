class WeatherService

  def self.get_weather(location)
    response = conn.get('/data/2.5/onecall') do |faraday|
      faraday.params['lat'] = location.lat
      faraday.params['lon'] = location.long
      faraday.params['exclude'] = 'minutely'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org') do |faraday|
      faraday.params['appid'] = ENV['weather_key']
    end
  end
end
