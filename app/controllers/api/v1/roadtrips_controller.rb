class Api::V1::RoadtripsController < ApplicationController

  def create
    user = User.find_by(api_key: roadtrip_params[:api_key])

    if !user.present? || !params[:api_key].present?
      render json: { errors: "Authentication error"}, status: :bad_request
    elsif RoadtripFacade.get_directions(roadtrip_params[:from], roadtrip_params[:to]) == 402
      render json: { error: "Impossible route" }, status: :bad_request
    else
      trip = RoadtripFacade.get_directions(roadtrip_params[:from], roadtrip_params[:to])
      weather = WeatherFacade.weather_info(MapFacade.get_coordinates(roadtrip_params[:to]))

      render json: RoadtripSerializer.roadtrip(trip, weather)
    end
  end

  private

  def roadtrip_params
    params.permit(:from, :to, :api_key)
  end
end
