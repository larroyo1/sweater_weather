require 'rails_helper'

RSpec.describe 'Background API' do
  before(:each) do
    get '/api/v1/backgrounds?location=denver,co'
    @results = JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns a good response' do
    expect(response.status).to eq(200)
  end

  it 'returns the correct information' do
    background_info = @results[:data][:attributes][:picture]

    expect(background_info.keys).to include(:source, :source_logo)
    expect(background_info[:attributes].keys).to include(:image_url, :description)
  end
end
