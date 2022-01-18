require 'rails_helper'

RSpec.describe 'Register API' do
  
  #happy path
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

  #sad path
  it 'returns 400 error if passwords do not match' do
    user_params = {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'fakepassword'
    }

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    post '/api/v1/users', headers: headers, params: user_params.to_json
    error = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(error[:errors]).to eq("Error creating user")
  end

  it 'returns 400 error if email already exists' do
    user = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password', api_key: '123')
    user_params = {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    post '/api/v1/users', headers: headers, params: user_params.to_json
    error = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(error[:errors]).to eq("Error creating user")
  end
end
