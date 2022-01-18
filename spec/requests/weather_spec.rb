require 'rails_helper'

RSpec.describe 'Weather API' do
  before(:each) do
    get '/api/v1/forecast?location=denver,co'
    @results = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
  end

  it 'gets a response' do
    expect(response.status).to eq(200)
  end

  it 'has the correct info for current_weather' do
    current_weather = @results[:data][:attributes][:current_weather]

    expect(current_weather.keys).to eq([:sunrise, :sunset, :feels_like, :humidity, :uvi, :visibility, :datetime, :temperature, :conditions, :icon])
  end

  it 'has the correct information for daily_weather' do
    daily_weather = @results[:data][:attributes][:daily_weather].first

    expect(daily_weather.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
  end
end
