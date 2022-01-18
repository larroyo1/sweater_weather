require 'rails_helper'

RSpec.describe 'Register API' do
  it 'creates a user and gives them an api key' do
    user_params = {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    post '/api/v1/users', headers: headers, params: user_params.to_json
    new_user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(new_user[:data].keys).to include(:id, :type, :attributes)
    expect(new_user[:data][:attributes].keys).to include(:email, :api_key)
    expect(new_user[:data][:type]).to eq('users')
    expect(new_user[:data][:attributes][:email]).to eq(user_params[:email])
  end
end
