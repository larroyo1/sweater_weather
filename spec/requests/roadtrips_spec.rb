require 'rails_helper'

RSpec.describe 'Roadtrip API' do
  describe 'happy path' do
    it 'returns roadtrip information and weather' do
      User.create!(email: 'example@test.com', password: 'password', password_confirmation: 'password', api_key: '123')

      info = {
        from: 'Denver, CO',
        to: 'Houston',
        api_key: '123'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/roadtrips', headers: headers, params: info.to_json
      trip_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(trip_json).to be_a(Hash)
      expect(trip_json[:data].keys).to include(:id, :type, :attributes)
      expect(trip_json[:data][:attributes].keys).to include(:start_city, :end_city, :travel_time, :weather)
      expect(trip_json[:data][:attributes][:weather].keys).to include(:temperature, :conditions)
    end
  end

  describe 'sad path' do
    it 'returns error is api_key is incorrect' do
      User.create!(email: 'example@test.com', password: 'password', password_confirmation: 'password', api_key: '123')

      info = {
        from: 'Denver, CO',
        to: 'Houston',
        api_key: '12312413254'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/roadtrips', headers: headers, params: info.to_json
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(error[:errors]).to eq('Authentication error')
    end

    it 'returns error message if route does not exist' do
      User.create!(email: 'example@test.com', password: 'password', password_confirmation: 'password', api_key: '123')

      info = {
        from: 'Fake',
        to: 'Not a real place',
        api_key: '123'
      }

      headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
      post '/api/v1/roadtrips', headers: headers, params: info.to_json
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(error[:error]).to eq("Impossible route")
    end
  end
end
