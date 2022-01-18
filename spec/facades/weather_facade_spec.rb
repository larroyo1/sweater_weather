require 'rails_helper'

RSpec.describe WeatherFacade do
  it 'creates weather poros with current/hourly/daily weather' do
    location = MapFacade.get_coordinates('Denver, CO')
    weather = WeatherFacade.weather_info(location)

    expect(weather).to be_a(Weather)
    expect(weather.id).to be(nil)
    expect(weather.current_weather).to be_a(Hash)
    expect(weather.current_weather.keys.count).to eq(14)
    expect(weather.hourly_weather).to be_a(Array)
    expect(weather.hourly_weather.first.keys.count).to eq(14)
    expect(weather.daily_weather).to be_a(Array)
    expect(weather.daily_weather.first.keys.count).to eq(18)
  end
end
