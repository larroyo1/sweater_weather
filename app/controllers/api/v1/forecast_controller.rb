class Api::V1::ForecastController < ApplicationController

  def index
    location = MapFacade.get_coordinates(params[:location])
    weather = WeatherFacade.weather_info(location)

    render json: WeatherSerializer.new(weather)
  end
end
