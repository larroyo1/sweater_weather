class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.new(user_params)
    assign_api_key(new_user)

    if new_user.save
      render json: UsersSerializer.new(new_user), status: :created
    else
      render json: { errors: "Error creating user"}, status: :bad_request
    end
  end

  private

  def assign_api_key(new_user)
    characters = ('a'..'z').to_a + ('0'..'9').to_a
    api_key = characters.sample(26).join("")
    new_user.update(api_key: api_key)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
