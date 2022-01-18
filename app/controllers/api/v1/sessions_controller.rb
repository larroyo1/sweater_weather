class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      render json: SessionSerializer.new(user)
    else
      render json: { errors: "Error authenticating user"}, status: :bad_request
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
