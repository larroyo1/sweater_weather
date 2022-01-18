class Api::V1::BooksController < ApplicationController

  def index
    books = BooksFacade.search_books(params[:location], params[:quantity])
    location = MapFacade.get_coordinates(params[:location])
    weather = WeatherFacade.weather_info(location)
    location_name = params[:location]

    render json: BooksSerializer.get_results(books, location, weather, location_name)
  end
end
