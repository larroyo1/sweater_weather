require 'rails_helper'

RSpec.describe 'Sessions API endpoint' do
  describe 'happy path' do
    it 'returns 200 status code if successful' do
      User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password', api_key: '123')

      session_params = {
        email: 'test@example.com',
        password: 'password'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/sessions', headers: headers, params: session_params.to_json
      info = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(info).to be_a(Hash)
      expect(info[:data][:attributes][:email]).to eq(session_params[:email])
      expect(info[:data].keys).to include(:id, :type, :attributes)
      expect(info[:data][:attributes].keys).to include(:email, :api_key)
    end
  end

  describe 'sad path' do
    it 'returns error if password is incorrect' do
      User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password', api_key: '123')

      session_params = {
        email: 'test@example.com',
        password: 'idontremembermypassword'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/sessions', headers: headers, params: session_params.to_json
      info = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(info[:errors]).to eq("Error authenticating user")
    end

    it 'returns error if email is not found' do
      User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password', api_key: '123')

      session_params = {
        email: 'test@bademail.com',
        password: 'password'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/sessions', headers: headers, params: session_params.to_json
      info = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(info[:errors]).to eq("Error authenticating user")
    end
  end
end
