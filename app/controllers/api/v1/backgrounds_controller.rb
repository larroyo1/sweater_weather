class Api::V1::BackgroundsController < ApplicationController

  def index
    background = BackgroundFacade.get_background(params[:location])

    render json: BackgroundsSerializer.new(background)
  end
end
