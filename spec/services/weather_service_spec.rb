require 'rails_helper'

RSpec.describe WeatherService do
  it 'establishes connection to weather api and gets weather' do
    location = MapFacade.get_coordinates('Denver, CO')
    weather = WeatherService.get_weather(location)

    expect(weather).to be_a(Hash)
    expect(weather.keys).to include(:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily)
    expect(weather.keys).to_not include(:minutely)
  end
end
